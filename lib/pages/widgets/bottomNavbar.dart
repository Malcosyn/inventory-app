import 'package:flutter/material.dart';
import '../../constants.dart';

// ─── Bottom Navbar ────────────────────────────────────────────────────────────

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onScanTapped;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onScanTapped,
  });

  static const _leftItems = [
    (Icons.inventory_2_outlined, 'Inventory', 0),
    (Icons.shopping_cart_outlined, 'Orders', 1),
  ];

  static const _rightItems = [
    (Icons.local_shipping_outlined, 'Suppliers', 2),
    (Icons.bar_chart_outlined, 'Reports', 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurface,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Nav items kiri + kanan ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    ..._leftItems.map(
                      (e) => Expanded(
                        child: _NavItem(
                          icon: e.$1,
                          label: e.$2,
                          index: e.$3,
                          selectedIndex: selectedIndex,
                          onTap: onItemTapped,
                        ),
                      ),
                    ),
                    // Spacer untuk area tombol scan tengah
                    const SizedBox(width: 72),
                    ..._rightItems.map(
                      (e) => Expanded(
                        child: _NavItem(
                          icon: e.$1,
                          label: e.$2,
                          index: e.$3,
                          selectedIndex: selectedIndex,
                          onTap: onItemTapped,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Tombol Scan Barcode tengah (floating) ───────────────────
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: onScanTapped,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(color: kSurface, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimary.withOpacity(0.45),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? kPrimary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? kPrimaryDark : Colors.grey.shade400,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: selected ? kPrimaryDark : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
