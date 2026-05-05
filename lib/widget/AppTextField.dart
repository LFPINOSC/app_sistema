import 'package:flutter/material.dart';

class Apptextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obcureText;
  const Apptextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obcureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obcureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
