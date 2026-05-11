import 'package:flutter/material.dart';

class AppList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final bool loading;
  final String emptyText;

  const AppList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.loading = false,
    this.emptyText = "No hay datos",
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text(emptyText));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index]);
      },
    );
  }
}
