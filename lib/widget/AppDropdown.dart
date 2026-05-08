import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final String label;
  final List<T> items;
  final String Function(T item) itemLabel;
  final void Function(T?) onChanged;

  const AppDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,

      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),

      items: items.map((item) {
        return DropdownMenuItem<T>(value: item, child: Text(itemLabel(item)));
      }).toList(),

      onChanged: onChanged,
    );
  }
}
