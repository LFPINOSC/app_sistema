import 'dart:convert';
import 'package:app_sistema/modelo/Ciudad.dart';
import 'package:http/http.dart' as http;
import '../servicio/Apiservicio.dart';

class CiudadServicio {
  final String baseUrl = "${Apiservice.baseUrl}/ciudad";

  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Apiservice.token}",
    };
  }

  Future<List<Ciudad>> getCiudades() async {
    final response = await http.get(Uri.parse(baseUrl), headers: _headers());

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Ciudad.fromJson(e)).toList();
    }

    return [];
  }

  Future<bool> crearCiudad(String nombre) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: _headers(),
      body: jsonEncode({"nombre": nombre}),
    );

    return response.statusCode == 201;
  }

  Future<bool> actualizarCiudad(int id, String nombre) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: _headers(),
      body: jsonEncode({"nombre": nombre}),
    );

    return response.statusCode == 200;
  }

  Future<bool> eliminarCiudad(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
      headers: _headers(),
    );

    return response.statusCode == 200;
  }
}
