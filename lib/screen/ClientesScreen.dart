import 'package:app_sistema/servicio/CiudadServicio.dart';
import 'package:app_sistema/servicio/ClienteServcio.dart';
import 'package:app_sistema/widget/AppDropdown.dart';
import 'package:flutter/material.dart';

import '../modelo/Cliente.dart';
import '../modelo/Ciudad.dart';
import '../widget/AppList.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  final ClienteServicio _clienteService = ClienteServicio();
  final CiudadServicio _ciudadService = CiudadServicio();

  List<Cliente> clientes = [];
  List<Ciudad> ciudades = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await cargarCiudades();
    await cargarClientes();
  }

  Future<void> cargarClientes() async {
    final data = await _clienteService.getClientes();

    setState(() {
      clientes = data;
      loading = false;
    });
  }

  Future<void> cargarCiudades() async {
    final data = await _ciudadService.getCiudades();

    setState(() {
      ciudades = data;
    });
  }

  void mostrarDialogo({Cliente? cliente}) {
    final cedulaController = TextEditingController(text: cliente?.cedula ?? "");

    final nombreController = TextEditingController(text: cliente?.nombre ?? "");

    final apellidoController = TextEditingController(
      text: cliente?.apellido ?? "",
    );

    final telefonoController = TextEditingController(
      text: cliente?.telefono ?? "",
    );

    final correoController = TextEditingController(text: cliente?.correo ?? "");

    final direccionController = TextEditingController(
      text: cliente?.direccion ?? "",
    );

    Ciudad? ciudadSeleccionada = cliente?.ciudad;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(cliente == null ? "Nuevo Cliente" : "Editar Cliente"),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: cedulaController,
                      decoration: const InputDecoration(labelText: "Cédula"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(labelText: "Nombre"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: apellidoController,
                      decoration: const InputDecoration(labelText: "Apellido"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: telefonoController,
                      decoration: const InputDecoration(labelText: "Teléfono"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: correoController,
                      decoration: const InputDecoration(labelText: "Correo"),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: direccionController,
                      decoration: const InputDecoration(labelText: "Dirección"),
                    ),

                    const SizedBox(height: 15),

                    AppDropdown<Ciudad>(
                      value: ciudadSeleccionada,
                      label: "Ciudad",
                      items: ciudades,

                      itemLabel: (ciudad) => ciudad.nombre,

                      onChanged: (value) {
                        setStateDialog(() {
                          ciudadSeleccionada = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (cedulaController.text.isEmpty ||
                        nombreController.text.isEmpty ||
                        apellidoController.text.isEmpty ||
                        ciudadSeleccionada == null) {
                      return;
                    }

                    final nuevoCliente = Cliente(
                      id: cliente?.id,
                      cedula: cedulaController.text,
                      nombre: nombreController.text,
                      apellido: apellidoController.text,
                      telefono: telefonoController.text,
                      correo: correoController.text,
                      direccion: direccionController.text,
                      ciudad: ciudadSeleccionada!,
                    );

                    bool ok;

                    if (cliente == null) {
                      ok = await _clienteService.crearCliente(nuevoCliente);
                    } else {
                      ok = await _clienteService.actualizarCliente(
                        nuevoCliente,
                      );
                    }

                    if (ok) {
                      Navigator.pop(context);
                      cargarClientes();
                    }
                  },
                  child: const Text("Guardar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void eliminar(int id) async {
    await _clienteService.eliminarCliente(id);
    cargarClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clientes")),

      floatingActionButton: FloatingActionButton(
        onPressed: () => mostrarDialogo(),
        child: const Icon(Icons.add),
      ),

      body: AppList<Cliente>(
        items: clientes,
        loading: loading,
        emptyText: "No existen clientes",

        itemBuilder: (cliente) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),

              title: Text("${cliente.nombre} ${cliente.apellido}"),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cédula: ${cliente.cedula}"),
                  Text("Teléfono: ${cliente.telefono}"),
                  Text("Correo: ${cliente.correo}"),
                  Text("Dirección: ${cliente.direccion}"),
                  Text("Ciudad: ${cliente.ciudad.nombre}"),
                ],
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => mostrarDialogo(cliente: cliente),
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => eliminar(cliente.id!),
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
