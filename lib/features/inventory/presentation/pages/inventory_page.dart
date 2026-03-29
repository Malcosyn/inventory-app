import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/pages/home_page.dart';
import 'package:inventory_app/core/pages/setting_page.dart';
import 'package:inventory_app/core/widgets/bottom_navigation.dart';
import 'package:inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:inventory_app/features/order/presentation/pages/order_page.dart';
import 'package:inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:inventory_app/features/stock_movement/presentation/pages/stock_movement_page.dart';
import 'package:inventory_app/init_depedencies.dart';

const kPrimary = Color(0xFFF2C287);
const kPrimaryDark = Color(0xFFD9A05B);
const kBackground = Color(0xFFFCF9F5);
const kWarmAccent = Color(0xFFFDF6ED);
const kSurface = Colors.white;

enum StockStatus { inStock, lowStock, outOfStock }

class _InventoryItem {
  final String productId;
  final String name;
  final String category;
  final int units;
  final double price;
  final String imageUrl;
  final StockStatus status;

  const _InventoryItem({
    required this.productId,
    required this.name,
    required this.category,
    required this.units,
    required this.price,
    required this.imageUrl,
    required this.status,
  });
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<ProductBloc>()),
        BlocProvider.value(value: serviceLocator<InventoryBloc>()),
      ],
      child: const _InventoryView(),
    );
  }
}

class _InventoryView extends StatefulWidget {
  const _InventoryView();

  @override
  State<_InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<_InventoryView> {
  String _selectedCategory = 'All Categories';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductBloc>().add(LoadProducts(1));
    });
  }

  void _onBottomNavChanged(int index) {
    final Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
      case 1:
        return;
      case 2:
        page = const OrderPage();
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
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (prev, curr) => curr is ProductLoaded,
      listener: (context, state) {
        if (state is ProductLoaded) {
          final ids = state.products.map((p) => p.id).toList();
          context.read<InventoryBloc>().add(LoadInventory(ids));
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: kBackground,
          body: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildDynamicBody()),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomNavigation(
                  selectedIndex: 1,
                  onNavChanged: _onBottomNavChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: kWarmAccent.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: kPrimary.withValues(alpha: 0.12), width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: kPrimaryDark,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inventory',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Main Warehouse',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: const InputDecoration(
                    hintText: 'Search products, SKUs...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicBody() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, productState) {
        return BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, inventoryState) {
            if (productState is ProductLoading ||
                (productState is ProductLoaded &&
                    inventoryState is InventoryLoading)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (productState is ProductFailure) {
              return _StateMessage(message: productState.message);
            }

            if (inventoryState is InventoryFailure) {
              return _StateMessage(message: inventoryState.message);
            }

            if (productState is! ProductLoaded ||
                inventoryState is! InventoryLoaded) {
              return const _StateMessage(message: 'Memuat data inventory...');
            }

            final items = _joinProductsWithInventory(
              productState.products,
              inventoryState.rows,
            );

            final categories = <String>{'All Categories'}
              ..addAll(items.map((e) => e.category));
            final categoryList = categories.toList()..sort();
            categoryList.remove('All Categories');
            categoryList.insert(0, 'All Categories');

            final activeCategory = categoryList.contains(_selectedCategory)
                ? _selectedCategory
                : 'All Categories';

            final query = _searchQuery.toLowerCase();
            final filtered = items.where((item) {
              final matchCat =
                  activeCategory == 'All Categories' ||
                  item.category == activeCategory;
              final matchSearch =
                  query.isEmpty ||
                  item.name.toLowerCase().contains(query) ||
                  item.category.toLowerCase().contains(query);
              return matchCat && matchSearch;
            }).toList();

            return Column(
              children: [
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    itemCount: categoryList.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final cat = categoryList[i];
                      final selected = activeCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected ? kPrimary : kSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: _buildProductList(filtered)),
              ],
            );
          },
        );
      },
    );
  }

  List<_InventoryItem> _joinProductsWithInventory(List products, List rows) {
    final rowByProductId = {for (final row in rows) row.productId: row};

    return products.map((product) {
      final row = rowByProductId[product.id];
      final stock = row?.stockQuantity ?? 0;
      final threshold = row?.lowStockThreshold ?? 5;

      final status = stock <= 0
          ? StockStatus.outOfStock
          : stock <= threshold
          ? StockStatus.lowStock
          : StockStatus.inStock;

      return _InventoryItem(
        productId: product.id,
        name: product.name,
        category: product.categoryId.toString(),
        units: stock,
        price: row?.sellingPrice ?? 0,
        imageUrl: product.imageUrl,
        status: status,
      );
    }).toList();
  }

  Widget _buildProductList(List<_InventoryItem> products) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'ALL PRODUCTS (${products.length})',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProductCard(product: products[index]),
              ),
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _InventoryItem product;
  const _ProductCard({required this.product});

  Color get _statusBg {
    switch (product.status) {
      case StockStatus.inStock:
        return const Color(0xFFFEF3C7);
      case StockStatus.lowStock:
        return const Color(0xFFFFEDD5);
      case StockStatus.outOfStock:
        return const Color(0xFFFEE2E2);
    }
  }

  Color get _statusColor {
    switch (product.status) {
      case StockStatus.inStock:
        return const Color(0xFFB45309);
      case StockStatus.lowStock:
        return const Color(0xFFEA580C);
      case StockStatus.outOfStock:
        return const Color(0xFFDC2626);
    }
  }

  String get _statusLabel {
    switch (product.status) {
      case StockStatus.inStock:
        return 'IN STOCK';
      case StockStatus.lowStock:
        return 'LOW STOCK';
      case StockStatus.outOfStock:
        return 'OUT OF STOCK';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              height: 80,
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imageFallback(),
                    )
                  : _imageFallback(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Category ${product.category} • ${product.units} units',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: kPrimaryDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.inventory_2_outlined, color: Colors.grey),
    );
  }
}

class _StateMessage extends StatelessWidget {
  final String message;
  const _StateMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
