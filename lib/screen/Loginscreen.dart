import 'package:app_sistema/provider/AuthProvider.dart';
import 'package:app_sistema/screen/Adminscreen.dart';
import 'package:app_sistema/servicio/Authservice.dart';
import 'package:app_sistema/widget/AppTextField.dart';
import 'package:app_sistema/widget/Appbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginscree extends StatefulWidget {
  const Loginscree({super.key});

  @override
  State<Loginscree> createState() => _LoginscreeState();
}

class _LoginscreeState extends State<Loginscree> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authservice = Authservice();
  void _login() async {
    if (formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      final ok = await auth.login(_username.text.trim(), _password.text.trim());

      if (!mounted) return;

      if (ok) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Adminscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario o contraseña incorrectos")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Apptextfield(
                controller: _username,
                label: "Username",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              Apptextfield(
                controller: _password,
                label: "Password",
                icon: Icons.lock,
                obcureText: true,
              ),
              const SizedBox(height: 16),
              Appbutton(text: "Login", onPressed: _login, icon: Icons.login),
            ],
          ),
        ),
      ),
    );
  }
}
