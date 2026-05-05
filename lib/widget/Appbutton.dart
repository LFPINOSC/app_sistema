import 'package:flutter/material.dart';

class Appbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  const Appbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.touch_app),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
