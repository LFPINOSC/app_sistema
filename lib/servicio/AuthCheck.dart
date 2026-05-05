import 'package:app_sistema/provider/AuthProvider.dart';
import 'package:app_sistema/screen/Adminscreen.dart';
import 'package:app_sistema/screen/Loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    verificar();
  }

  Future<void> verificar() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    await auth.checkAuth(); // revisa token en storage

    if (!mounted) return;

    if (auth.isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Adminscreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscree()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
