import 'package:flutter/material.dart';
import '../servicio/Authservice.dart';
import '../servicio/Apiservicio.dart';

class AuthProvider with ChangeNotifier {
  final Authservice _authservice = Authservice();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    final ok = await _authservice.login(username, password);
    _isLoading = false;
    if (ok) {
      _isAuthenticated = true;
    }
    notifyListeners();
    return ok;
  }

  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    final isLogged = await _authservice.isLoggedIn();

    _isAuthenticated = isLogged;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authservice.logout();

    _isAuthenticated = false;
    Apiservice.token = null;

    _isLoading = false;
    notifyListeners();
  }

  String? get token => Apiservice.token;
}
