import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/bottomNavbar.dart';
import '../../constants.dart';
import 'edit.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  Product get p => widget.product;

  Color get _statusBg {
    switch (p.status) {
      case StockStatus.inStock:
        return const Color(0xFFFEF3C7);
      case StockStatus.lowStock:
        return const Color(0xFFFFEDD5);
      case StockStatus.outOfStock:
        return const Color(0xFFFEE2E2);
    }
  }

  Color get _statusColor {
    switch (p.status) {
      case StockStatus.inStock:
        return const Color(0xFFB45309);
      case StockStatus.lowStock:
        return const Color(0xFFEA580C);
      case StockStatus.outOfStock:
        return const Color(0xFFDC2626);
    }
  }

  String get _statusLabel {
    switch (p.status) {
      case StockStatus.inStock:
        return 'IN STOCK';
      case StockStatus.lowStock:
        return 'LOW STOCK';
      case StockStatus.outOfStock:
        return 'OUT OF STOCK';
    }
  }

  IconData get _statusIcon {
    switch (p.status) {
      case StockStatus.inStock:
        return Icons.check_circle_outline;
      case StockStatus.lowStock:
        return Icons.warning_amber_outlined;
      case StockStatus.outOfStock:
        return Icons.remove_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOut = p.status == StockStatus.outOfStock;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: kBackground,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: kWarmAccent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSurface.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => _showOptions(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kSurface.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      color: isOut ? Colors.grey : null,
                      colorBlendMode: isOut ? BlendMode.saturation : null,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey.shade400,
                          size: 64,
                        ),
                      ),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Colors.grey.shade100,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.expectedTotalBytes != null
                                  ? progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: kPrimary,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              kBackground.withOpacity(0.9),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _statusBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _statusColor.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_statusIcon, size: 12, color: _statusColor),
                            const SizedBox(width: 4),
                            Text(
                              _statusLabel,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: _statusColor,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p.category,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${p.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: kPrimaryDark,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'per unit',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Info Cards
                    Row(
                      children: [
                        Expanded(
                          child: _InfoCard(
                            icon: Icons.inventory_2_outlined,
                            label: 'Stock',
                            value: '${p.units} units',
                            color: kPrimaryDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InfoCard(
                            icon: Icons.tag_outlined,
                            label: 'SKU',
                            value: '#${p.id}',
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InfoCard(
                            icon: Icons.category_outlined,
                            label: 'Category',
                            value: p.category.split(' ').first,
                            color: Colors.deepOrange.shade300,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 16),

                    // ── UPDATE STOCK ──────────────────────────────────────
                    const Text(
                      'UPDATE STOCK',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kSurface,
                        borderRadius: BorderRadius.circular(16),
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
                          _QtyButton(
                            icon: Icons.remove,
                            onTap: () {
                              if (_quantity > 1) setState(() => _quantity--);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          _QtyButton(
                            icon: Icons.add,
                            onTap: () => setState(() => _quantity++),
                            filled: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            label: 'Reduce Stock',
                            icon: Icons.remove_circle_outline,
                            color: Colors.red.shade400,
                            bgColor: Colors.red.shade50,
                            onTap: () => _showStockSnackbar(
                              context,
                              'reduce',
                              _quantity,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionButton(
                            label: 'Add Stock',
                            icon: Icons.add_circle_outline,
                            color: kPrimaryDark,
                            bgColor: kPrimary.withOpacity(0.12),
                            onTap: () => _showStockSnackbar(
                              context,
                              'tambah',
                              _quantity,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 16),

                    // ── PRODUCT INFORMATION ───────────────────────────────
                    const Text(
                      'PRODUCT INFORMATION',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: kSurface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _DetailRow(label: 'Product Name', value: p.name),
                          _DetailRow(label: 'SKU / ID', value: p.id),
                          _DetailRow(label: 'Category', value: p.category),
                          _DetailRow(
                            label: 'Price',
                            value: '\$${p.price.toStringAsFixed(2)}',
                          ),
                          _DetailRow(
                            label: 'Available Stock',
                            value: '${p.units} units',
                          ),
                          _DetailRow(
                            label: 'Status',
                            value: _statusLabel,
                            valueColor: _statusColor,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Edit & Delete Buttons ─────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                EditProductSheet.show(context, p),
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text('Edit Product'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kPrimaryDark,
                              side: const BorderSide(color: kPrimary),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () => _confirmDelete(context),
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: const Text('Delete'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red.shade200),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockSnackbar(BuildContext context, String type, int qty) {
    final isAdd = type == 'tambah';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isAdd ? Icons.add_circle_outline : Icons.remove_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              '${isAdd ? 'Added' : 'Reduced'} $qty units of ${p.name}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
        backgroundColor: isAdd ? kPrimaryDark : Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
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
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                color: Colors.red.shade400,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Delete Product?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              '"${p.name}" will be permanently deleted\nfrom your inventory.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
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
            _OptionTile(
              icon: Icons.edit_outlined,
              label: 'Edit Product',
              onTap: () {
                Navigator.pop(context);
                EditProductSheet.show(context, p);
              },
            ),
            _OptionTile(
              icon: Icons.qr_code_outlined,
              label: 'View Barcode',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: () => Navigator.pop(context),
            ),
            _OptionTile(
              icon: Icons.delete_outline,
              label: 'Delete Product',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─── Sub Widgets ──────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: filled ? kPrimary : kPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 20,
          color: filled ? Colors.white : kPrimaryDark,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: Colors.grey.shade100,
            indent: 16,
            endIndent: 16,
          ),
      ],
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