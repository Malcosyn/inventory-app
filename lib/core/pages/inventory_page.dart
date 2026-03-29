import 'package:flutter/material.dart';
import 'package:inventory_app/features/inventory/presentation/pages/inventory_page.dart'
    as feature_inventory;

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const feature_inventory.InventoryPage();
  }
}
