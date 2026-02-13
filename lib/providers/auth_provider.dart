import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final String _baseUrl = dotenv.env['TMDB_BASE_URL']!;
  final String _apiKey = dotenv.env['TMDB_API_KEY']!;

  String? _sessionId;
  Account? _account;
  bool _isLoading = false;

  late Future<void> sessionLoaded;

  // Getters

  String? get sessionId => _sessionId;
  Account? get account => _account;
  bool get isLoggedIn => _sessionId != null;
  bool get isLoading => _isLoading;

  // Constructor

  AuthProvider() {
    sessionLoaded = _loadSession();
  }

  // Toast Helper

  void _showToast(String message, {bool isError = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppColor.redAccent : AppColor.green,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  // Session Persistence

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final storedSession = prefs.getString('session_id');

    if (storedSession != null) {
      _sessionId = storedSession;
      notifyListeners();
      await fetchAccountDetails();
    }
  }

  Future<void> _saveSession(String session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', session);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
    _sessionId = null;
    _account = null;
    notifyListeners();
  }

  // Loading Helper

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _stopLoading(bool value) {
    _isLoading = false;
    notifyListeners();
    return value;
  }

  // API Calls

  Future<String?> _createRequestToken() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'))
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return data["request_token"];
      } else {
        _showToast(data["status_message"] ?? "Failed to create request token");
      }
    } catch (e) {
      _showToast("Network error while creating request token");
    }

    return null;
  }

  Future<bool> _validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(
              '$_baseUrl/authentication/token/validate_with_login?api_key=$_apiKey',
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "username": username,
              "password": password,
              "request_token": requestToken,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return true;
      } else {
        _showToast(data["status_message"] ?? "Invalid username or password");
      }
    } catch (e) {
      _showToast("Login validation failed. Check your internet connection.");
    }

    return false;
  }

  Future<String?> _createSession(String requestToken) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/authentication/session/new?api_key=$_apiKey'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"request_token": requestToken}),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        return data["session_id"];
      } else {
        _showToast(data["status_message"] ?? "Failed to create session");
      }
    } catch (e) {
      _showToast("Session creation failed.");
    }

    return null;
  }

  // Public Login Method

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _setLoading(true);

    final token = await _createRequestToken();
    if (token == null) return _stopLoading(false);

    final validated = await _validateWithLogin(
      username: username,
      password: password,
      requestToken: token,
    );
    if (!validated) return _stopLoading(false);

    final session = await _createSession(token);
    if (session == null) return _stopLoading(false);

    _sessionId = session;
    await _saveSession(session);

    await fetchAccountDetails();

    _showToast("Login successful", isError: false);

    return _stopLoading(true);
  }

  // Logout

  Future<void> logout() async {
    await _clearSession();
    _showToast("Logged out successfully", isError: false);
  }

  // Fetch Account

  Future<Account?> fetchAccountDetails() async {
    if (_sessionId == null) {
      _showToast("User not logged in.");
      return null;
    }

    try {
      final uri = Uri.parse(
        '$_baseUrl/account?api_key=$_apiKey&session_id=$_sessionId',
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _account = Account.fromJson(data);
        notifyListeners();
        return _account;
      } else {
        final data = jsonDecode(response.body);
        _showToast(data["status_message"] ?? "Failed to fetch account details");
      }
    } catch (e) {
      _showToast("Network error while fetching account details.");
    }

    return null;
  }
}
