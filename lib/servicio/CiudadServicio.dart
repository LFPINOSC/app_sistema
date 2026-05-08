import 'dart:convert';

import 'package:app_sistema/modelo/Ciudad.dart';
import 'package:app_sistema/servicio/Apiservicio.dart';
import 'package:http/http.dart' as http;

class CiudadServicio {
  final String urlBase = "${Apiservice.baseUrl}/ciudad";
  Map<String, String> headers() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Apiservice.token}",
    };
  }

  Future<List<Ciudad>> getCiudades() async {
    try {
      final response = await http.get(Uri.parse(urlBase), headers: headers());
      if (response.statusCode == 200) {
        return jsonDecode(
          response.body,
        ).map((e) => Ciudad.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load ciudades");
      }
    } catch (e) {
      print("Error fetching ciudades: $e");
      throw Exception("Error fetching ciudades");
    }
  }

  Future<bool> crearCiudad(Ciudad ciudad) async {
    try {
      final response = await http.post(
        Uri.parse(urlBase),
        headers: headers(),
        body: jsonEncode(ciudad.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating ciudad: $e");
      return false;
    }
  }

  Future<bool> eliminarCiudad(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$urlBase/$id"),
        headers: headers(),
      );
      return response.statusCode == 204;
    } catch (e) {
      print("Error deleting ciudad: $e");
      return false;
    }
  }

  Future<bool> actualizarCiudad(int id, Ciudad ciudad) async {
    try {
      final response = await http.put(
        Uri.parse("$urlBase/$id"),
        headers: headers(),
        body: jsonEncode(ciudad.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating ciudad: $e");
      return false;
    }
  }
}
