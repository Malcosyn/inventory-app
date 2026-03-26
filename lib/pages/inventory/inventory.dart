import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bottomNavbar.dart';
import '../../constants.dart';
import 'detail.dart';

// ─── App Root ──────────────────────────────────────────────────────────────────

class MinimarketApp extends StatelessWidget {
  const MinimarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimarket Inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF2C287),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const InventoryPage(),
    );
  }
}

// ─── Sample Data ───────────────────────────────────────────────────────────────

final List<Product> sampleProducts = [
  const Product(
    id: '001',
    name: 'Cola Classic 330ml',
    category: 'Beverages',
    units: 24,
    price: 1.25,
    imageUrl:
        'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=200&q=80',
    status: StockStatus.inStock,
  ),
  const Product(
    id: '002',
    name: 'Whole Milk 1L',
    category: 'Dairy',
    units: 5,
    price: 2.50,
    imageUrl:
        'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=200&q=80',
    status: StockStatus.lowStock,
  ),
  const Product(
    id: '003',
    name: 'Vine Tomatoes',
    category: 'Produce',
    units: 0,
    price: 3.99,
    imageUrl:
        'https://images.unsplash.com/photo-1558818498-28c1e002b655?w=200&q=80',
    status: StockStatus.outOfStock,
  ),
  const Product(
    id: '004',
    name: 'Potato Chips 150g',
    category: 'Snacks',
    units: 42,
    price: 1.80,
    imageUrl:
        'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&q=80',
    status: StockStatus.inStock,
  ),
  const Product(
    id: '005',
    name: 'Orange Juice 1L',
    category: 'Beverages',
    units: 18,
    price: 3.20,
    imageUrl:
        'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=200&q=80',
    status: StockStatus.inStock,
  ),
  const Product(
    id: '006',
    name: 'Greek Yogurt 200g',
    category: 'Dairy & Eggs',
    units: 3,
    price: 1.99,
    imageUrl:
        'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=200&q=80',
    status: StockStatus.lowStock,
  ),
  const Product(
    id: '007',
    name: 'Dishwashing Liquid',
    category: 'Household',
    units: 30,
    price: 2.75,
    imageUrl:
        'https://images.unsplash.com/photo-1585412727339-54e4bae3bbf9?w=200&q=80',
    status: StockStatus.inStock,
  ),
  const Product(
    id: '008',
    name: 'Banana (1kg)',
    category: 'Produce',
    units: 0,
    price: 1.10,
    imageUrl:
        'https://images.unsplash.com/photo-1543218024-57a70143c369?w=200&q=80',
    status: StockStatus.outOfStock,
  ),
];

// ─── Constants ─────────────────────────────────────────────────────────────────

const kPrimary = Color(0xFFF2C287);
const kPrimaryDark = Color(0xFFD9A05B);
const kBackground = Color(0xFFFCF9F5);
const kWarmAccent = Color(0xFFFDF6ED);
const kSurface = Colors.white;

// ─── Main Page ─────────────────────────────────────────────────────────────────

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int _selectedNavIndex = 0;
  String _selectedCategory = 'All Categories';
  String _searchQuery = '';

  final List<String> categories = [
    'All Categories',
    'Beverages',
    'Snacks',
    'Dairy & Eggs',
    'Produce',
    'Household',
  ];

  List<Product> get filteredProducts {
    return sampleProducts.where((p) {
      final matchCat =
          _selectedCategory == 'All Categories' ||
          p.category == _selectedCategory ||
          p.category.contains(_selectedCategory);
      final matchSearch =
          _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCat && matchSearch;
    }).toList();
  }

  void _onScanTapped() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ScanPlaceholderSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: kBackground,
        body: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildProductList()),
          ],
        ),
        bottomNavigationBar: BottomNavbar(
          selectedIndex: _selectedNavIndex,
          onItemTapped: (index) => setState(() => _selectedNavIndex = index),
          onScanTapped: _onScanTapped,
        ),
      ),
    );
  }

  // ─── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: kWarmAccent.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(color: kPrimary.withOpacity(0.12), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                      color: kPrimary.withOpacity(0.15),
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
                          letterSpacing: -0.5,
                          height: 1.1,
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
                      size: 22,
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Search products, SKUs...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final cat = categories[i];
                  final selected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? kPrimary : kSurface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Product List ─────────────────────────────────────────────────────────────

  Widget _buildProductList() {
    final products = filteredProducts;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ALL PRODUCTS (${products.length})',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Sort by: Name',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryDark,
                  ),
                ),
              ],
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

// ─── Scan Placeholder Sheet ───────────────────────────────────────────────────

class _ScanPlaceholderSheet extends StatelessWidget {
  const _ScanPlaceholderSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: kPrimary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: kPrimaryDark,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Scan Barcode',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Integrasikan dengan package mobile_scanner\nuntuk mengaktifkan kamera scanner.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Tutup',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Product Card ─────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _pressed = false;

  Color get _statusBg {
    switch (widget.product.status) {
      case StockStatus.inStock:
        return const Color(0xFFFEF3C7);
      case StockStatus.lowStock:
        return const Color(0xFFFFEDD5);
      case StockStatus.outOfStock:
        return const Color(0xFFFEE2E2);
    }
  }

  Color get _statusColor {
    switch (widget.product.status) {
      case StockStatus.inStock:
        return const Color(0xFFB45309);
      case StockStatus.lowStock:
        return const Color(0xFFEA580C);
      case StockStatus.outOfStock:
        return const Color(0xFFDC2626);
    }
  }

  String get _statusLabel {
    switch (widget.product.status) {
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
    final isOut = widget.product.status == StockStatus.outOfStock;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedOpacity(
          opacity: isOut ? 0.75 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _pressed
                    ? kPrimary.withOpacity(0.3)
                    : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade100,
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                      color: isOut ? Colors.grey : null,
                      colorBlendMode: isOut ? BlendMode.saturation : null,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                      progress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            color: kPrimary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
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
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.product.category} • ${widget.product.units} units',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: kPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showOptions(context),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _OptionsSheet(product: widget.product),
    );
  }
}

// ─── Options Bottom Sheet ─────────────────────────────────────────────────────

class _OptionsSheet extends StatelessWidget {
  final Product product;
  const _OptionsSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  color: kPrimaryDark,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          _OptionTile(
            icon: Icons.edit_outlined,
            label: 'Edit Product',
            onTap: () => Navigator.pop(context),
          ),
          _OptionTile(
            icon: Icons.add_circle_outline,
            label: 'Update Stock',
            onTap: () => Navigator.pop(context),
          ),
          _OptionTile(
            icon: Icons.qr_code_outlined,
            label: 'View Barcode',
            onTap: () => Navigator.pop(context),
          ),
          _OptionTile(
            icon: Icons.delete_outline,
            label: 'Delete Product',
            color: Colors.red,
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? Colors.grey.shade700, size: 20),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.grey.shade800,
        ),
      ),
      dense: true,
    );
  }
}
