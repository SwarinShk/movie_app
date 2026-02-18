// auth_service.dart

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/auth/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = dotenv.env['TMDB_BASE_URL']!;
  final String _apiKey = dotenv.env['TMDB_API_KEY']!;

  // Session Persistence

  Future<String?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  Future<void> saveSession(String session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', session);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
  }

  // API Calls

  Future<String?> createRequestToken() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'))
        .timeout(const Duration(seconds: 10));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      return data["request_token"];
    }

    throw Exception(data["status_message"] ?? "Failed to create token");
  }

  Future<void> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
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

    if (!(response.statusCode == 200 && data["success"] == true)) {
      throw Exception(data["status_message"] ?? "Invalid credentials");
    }
  }

  Future<String?> createSession(String requestToken) async {
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
    }

    throw Exception(data["status_message"] ?? "Failed to create session");
  }

  Future<Account> fetchAccountDetails(String sessionId) async {
    final uri = Uri.parse(
      '$_baseUrl/account?api_key=$_apiKey&session_id=$sessionId',
    );

    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }

    final data = jsonDecode(response.body);
    throw Exception(data["status_message"] ?? "Failed to fetch account");
  }
}
