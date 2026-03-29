import 'package:flutter/material.dart';
import 'package:inventory_app/core/pages/home_page.dart';
import 'package:inventory_app/core/pages/setting_page.dart';
import 'package:inventory_app/core/widgets/bottom_navigation.dart';
import 'package:inventory_app/features/inventory/presentation/pages/inventory_page.dart';
import 'package:inventory_app/features/stock_movement/presentation/pages/stock_movement_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  void _onBottomNavChanged(BuildContext context, int index) {
    final Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
      case 1:
        page = const InventoryPage();
      case 2:
        return;
      case 3:
        page = const StockMovementPage();
      case 4:
        page = const SettingPage();
      default:
        return;
    }

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          const Center(child: Text('Order Feature Page')),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigation(
              selectedIndex: 2,
              onNavChanged: (index) => _onBottomNavChanged(context, index),
            ),
          ),
        ],
      ),
    );
  }
}
