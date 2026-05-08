import 'package:app_sistema/modelo/Ciudad.dart';
import 'package:app_sistema/servicio/CiudadServicio.dart';
import 'package:flutter/material.dart';

import '../widget/AppList.dart';

class CiudadesScreen extends StatefulWidget {
  const CiudadesScreen({super.key});

  @override
  State<CiudadesScreen> createState() => _CiudadesScreenState();
}

class _CiudadesScreenState extends State<CiudadesScreen> {
  final CiudadServicio _service = CiudadServicio();

  List<Ciudad> ciudades = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarCiudades();
  }

  Future<void> cargarCiudades() async {
    final data = await _service.getCiudades();

    setState(() {
      ciudades = data;
      loading = false;
    });
  }

  void mostrarDialogo({Ciudad? ciudad}) {
    final controller = TextEditingController(text: ciudad?.nombre ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(ciudad == null ? "Nueva Ciudad" : "Editar Ciudad"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Nombre"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isEmpty) return;

              bool ok;

              if (ciudad == null) {
                // Crear nueva ciudad
                ok = await _service.crearCiudad(
                  Ciudad(nombre: controller.text),
                );
              } else {
                // Actualizar ciudad existente
                ok = await _service.actualizarCiudad(
                  ciudad.id!,
                  Ciudad(nombre: controller.text),
                );
              }

              if (ok) {
                Navigator.pop(context);
                cargarCiudades();
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  void eliminar(int id) async {
    await _service.eliminarCiudad(id);
    cargarCiudades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ciudades")),

      // 🔥 BOTÓN AGREGAR
      floatingActionButton: FloatingActionButton(
        onPressed: () => mostrarDialogo(),
        child: const Icon(Icons.add),
      ),

      // 🔥 LISTA REUTILIZABLE
      body: AppList<Ciudad>(
        items: ciudades,
        loading: loading,
        emptyMessage: "No hay ciudades",
        itemBuilder: (ciudad) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(ciudad.nombre),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => mostrarDialogo(ciudad: ciudad),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => eliminar(ciudad.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
