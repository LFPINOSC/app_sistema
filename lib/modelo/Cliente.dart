import 'package:app_sistema/modelo/Ciudad.dart';

class Cliente {
  int? id;
  String cedula;
  String nombre;
  String apellido;
  String telefono;
  String correo;
  String direccion;
  Ciudad ciudad;
  Cliente({
    this.id,
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.ciudad,
  });
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      cedula: json['cedula'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      correo: json['correo'],
      direccion: json['direccion'],
      ciudad: Ciudad.fromJson(json['ciudad']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
      'ciudad': ciudad.toJson(),
    };
  }
}
