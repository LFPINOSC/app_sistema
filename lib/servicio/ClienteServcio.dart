import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modelo/Cliente.dart';
import '../servicio/Apiservicio.dart';

class ClienteServicio {
  final String baseUrl = "${Apiservice.baseUrl}/cliente";

  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Apiservice.token}",
    };
  }

  Future<List<Cliente>> getClientes() async {
    final response = await http.get(Uri.parse(baseUrl), headers: _headers());

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => Cliente.fromJson(e)).toList();
    }

    return [];
  }

  Future<Cliente?> getClienteById(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$id"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  Future<Cliente?> getClienteByCedula(String cedula) async {
    final response = await http.get(
      Uri.parse("$baseUrl/cedula/$cedula"),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  Future<bool> crearCliente(Cliente cliente) async {
    try {
      print("JSON ENVIADO:");
      print(jsonEncode(cliente.toJson()));

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: _headers(),
        body: jsonEncode(cliente.toJson()),
      );

      print("STATUS: ${response.statusCode}");
      print("RESPUESTA:");
      print(response.body);

      return response.statusCode == 201;
    } catch (e) {
      print("ERROR crearCliente:");
      print(e);

      return false;
    }
  }

  Future<bool> actualizarCliente(Cliente cliente) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${cliente.id}"),
      headers: _headers(),
      body: jsonEncode(cliente.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> eliminarCliente(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
      headers: _headers(),
    );

    return response.statusCode == 200;
  }
}
