import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Apiservicio.dart';

class Authservice {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// LOGIN
  Future<bool> login(String username, String password) async {
    try {
      final url = Uri.parse("${Apiservice.baseUrl}/login");

      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"username": username, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data["token"];

        Apiservice.token = token;

        await _storage.write(key: "token", value: token);

        return true;
      }

      return false;
    } catch (e) {
      print("Error login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    Apiservice.token = null;
    await _storage.delete(key: "token");
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: "token");
    Apiservice.token = token;
    return token;
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
