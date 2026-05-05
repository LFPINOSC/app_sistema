import 'package:flutter/material.dart';

class CiudadesScreen extends StatelessWidget {
  const CiudadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ciudades")),
      body: const Center(child: Text("CRUD de Ciudades aquí")),
    );
  }
}
