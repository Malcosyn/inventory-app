import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/pages/setting_page.dart';
import 'package:inventory_app/core/widgets/bottom_navigation.dart';
import 'package:inventory_app/features/inventory/presentation/pages/inventory_page.dart'
    as inventory_feature;
import 'package:inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:inventory_app/features/order/presentation/pages/order_page.dart'
    as order_feature;
import 'package:inventory_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:inventory_app/features/stock_movement/presentation/pages/stock_movement_page.dart'
    as stock_feature;
import 'package:inventory_app/init_depedencies.dart';

class AppColors {
  static const primary = Color(0xFFF2C287);
  static const terracotta = Color(0xFFE67E5D);
  static const backgroundLight = Color(0xFFFCF9F5);
  static const cardBg = Colors.white;
  static const borderColor = Color(0xFFE2E8F0);
  static const textDark = Color(0xFF0F172A);
  static const textMedium = Color(0xFF64748B);
  static const textLight = Color(0xFF94A3B8);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<ProductBloc>()),
        BlocProvider.value(value: serviceLocator<InventoryBloc>()),
        BlocProvider.value(value: serviceLocator<OrderBloc>()),
      ],
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> {
  int _selectedNavIndex = 0;
  final List<double> _barData = [0.40, 0.60, 0.80, 0.55, 0.70, 0.90, 1.00];
  final List<String> _dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  String _selectedRange = 'Last 7 Days';

  void _onBottomNavChanged(int index) {
    if (index == 0) return;

    final Widget page;
    switch (index) {
      case 1:
        page = const inventory_feature.InventoryPage();
      case 2:
        page = const order_feature.OrderPage();
      case 3:
        page = const stock_feature.StockMovementPage();
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
  void initState() {
    super.initState();
    // Load data when page initializes
    Future.microtask(() {
      final productBloc = context.read<ProductBloc>();
      final inventoryBloc = context.read<InventoryBloc>();
      final orderBloc = context.read<OrderBloc>();

      // Load all data - storeId 1 as default, empty product list initially
      productBloc.add(LoadProducts(1));
      inventoryBloc.add(LoadInventory(<String>[]));
      orderBloc.add(LoadOrders(<String>[]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(
          Icons.add_rounded,
          color: Color(0xFF292524),
          size: 30,
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildQuickActions()),
              SliverToBoxAdapter(child: _buildInventorySummary()),
              SliverToBoxAdapter(child: _buildStockTrend()),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigation(
              selectedIndex: _selectedNavIndex,
              onNavChanged: _onBottomNavChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.account_circle_outlined,
              color: AppColors.textMedium,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Good Morning, Admin',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          _headerIconBtn(Icons.search_rounded),
          const SizedBox(width: 8),
          _notificationBtn(),
        ],
      ),
    );
  }

  Widget _headerIconBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: const Color(0xFF475569), size: 22),
    );
  }

  Widget _notificationBtn() {
    return Stack(
      children: [
        _headerIconBtn(Icons.notifications_outlined),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Quick Actions'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quickAction(
                icon: Icons.add_box_outlined,
                label: 'Add Item',
                bg: AppColors.primary,
                iconColor: const Color(0xFF292524),
                hasShadow: true,
              ),
              _quickAction(
                icon: Icons.qr_code_scanner_rounded,
                label: 'Scan',
                bg: const Color(0xFF1E293B),
                iconColor: Colors.white,
                hasShadow: true,
              ),
              _quickAction(
                icon: Icons.login_rounded,
                label: 'Stock In',
                bg: Colors.white,
                iconColor: AppColors.textDark,
                hasBorder: true,
              ),
              _quickAction(
                icon: Icons.logout_rounded,
                label: 'Stock Out',
                bg: Colors.white,
                iconColor: AppColors.textDark,
                hasBorder: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required Color bg,
    required Color iconColor,
    bool hasShadow = false,
    bool hasBorder = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: hasBorder
                  ? Border.all(color: AppColors.borderColor)
                  : null,
              boxShadow: hasShadow
                  ? [
                      BoxShadow(
                        color: bg.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Inventory Summary'),
          const SizedBox(height: 16),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              return BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, inventoryState) {
                  return BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, orderState) {
                      // Calculate total products
                      int totalProducts = 0;
                      if (productState is ProductLoaded) {
                        totalProducts = productState.products.length;
                      }

                      // Calculate low stock items
                      int lowStockItems = 0;
                      if (inventoryState is InventoryLoaded) {
                        lowStockItems = inventoryState.rows
                            .where(
                              (inv) =>
                                  inv.stockQuantity < inv.lowStockThreshold,
                            )
                            .length;
                      }

                      // Calculate today's transactions
                      int todayTransactions = 0;
                      if (orderState is OrderLoaded) {
                        final today = DateTime.now();
                        todayTransactions = orderState.orders.length;
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _summaryCard(
                                  icon: Icons.inventory_2_outlined,
                                  iconBg: AppColors.borderColor,
                                  iconColor: AppColors.textMedium,
                                  value: totalProducts.toString(),
                                  label: 'Total Products',
                                  isLoading: productState is ProductLoading,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _summaryCard(
                                  icon: Icons.warning_amber_rounded,
                                  iconBg: const Color(0xFFFFF7ED),
                                  iconColor: const Color(0xFFF97316),
                                  value: lowStockItems.toString(),
                                  valueColor: const Color(0xFFF97316),
                                  label: 'Low Stock Items',
                                  borderColor: const Color(0xFFFFEDD5),
                                  cardBg: const Color(0xFFFFF7ED),
                                  isLoading: inventoryState is InventoryLoading,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _transactionCard(
                            todayTransactions,
                            orderState is OrderLoading,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
    Color? valueColor,
    Color? borderColor,
    Color? cardBg,
    bool isLoading = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg ?? Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor ?? AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 12),
          if (isLoading)
            const SizedBox(
              width: 60,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: valueColor ?? AppColors.textDark,
              ),
            ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionCard(int count, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF3B82F6),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 60,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              const Text(
                "Today's Transactions",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF22C55E),
                size: 18,
              ),
              SizedBox(width: 2),
              Text(
                '12%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF22C55E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockTrend() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _sectionTitle('Stock Trend'),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRange,
                  isDense: true,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                    fontFamily: 'Manrope',
                  ),
                  items: ['Last 7 Days', 'Last 30 Days']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedRange = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(_barData.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: i == 0 ? 0 : 4,
                            right: i == _barData.length - 1 ? 0 : 4,
                          ),
                          child: _Bar(heightFraction: _barData[i]),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _dayLabels
                      .map(
                        (d) => Text(
                          d,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textLight,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: AppColors.textMedium,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _Bar extends StatefulWidget {
  final double heightFraction;

  const _Bar({required this.heightFraction});

  @override
  State<_Bar> createState() => _BarState();
}

class _BarState extends State<_Bar> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxH = constraints.maxHeight;
            return Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: maxH * widget.heightFraction,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.55),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
