import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/models/account_model.dart';
import 'package:movie_app/services/auth_service.dart';

class AuthServiceProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  String? _sessionId;
  Account? _account;
  bool _isLoading = false;
  bool _isInitialized = false;

  String? get sessionId => _sessionId;
  Account? get account => _account;
  bool get isLoggedIn => _sessionId != null;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  AuthServiceProvider() {
    _initialize();
  }

  // Initialize Session

  Future<void> _initialize() async {
    _setLoading(true);
    try {
      _sessionId = await _service.loadSession();
      if (_sessionId != null) {
        _account = await _service.fetchAccountDetails(_sessionId!);
      }
    } catch (_) {
      await logout();
    } finally {
      _isInitialized = true;
      _setLoading(false);
      notifyListeners();
    }
  }

  // Helpers

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showToast(String message, {bool isError = true}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError ? AppColor.redAccent : AppColor.green,
      textColor: Colors.white,
    );
  }

  // Login

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _setLoading(true);

    try {
      final token = await _service.createRequestToken();

      await _service.validateWithLogin(
        username: username,
        password: password,
        requestToken: token!,
      );

      final session = await _service.createSession(token);

      _sessionId = session;
      await _service.saveSession(session!);

      _account = await _service.fetchAccountDetails(session);

      _showToast("Login successful", isError: false);
      return true;
    } catch (e) {
      _showToast(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout

  Future<void> logout() async {
    await _service.clearSession();
    _sessionId = null;
    _account = null;
    notifyListeners();

    _showToast("Logged out successfully", isError: false);
  }
}
