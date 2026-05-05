import 'package:app_sistema/provider/AuthProvider.dart';
import 'package:app_sistema/screen/CiudadesScreen.dart';
import 'package:app_sistema/screen/ClientesScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/MenuCard.dart';

import 'Loginscreen.dart';

class Adminscreen extends StatelessWidget {
  const Adminscreen({super.key});

  Future<void> logout(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Loginscree()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            MenuCard(
              title: "Clientes",
              icon: Icons.people,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ClientesScreen()),
                );
              },
            ),

            MenuCard(
              title: "Ciudades",
              icon: Icons.location_city,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CiudadesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
