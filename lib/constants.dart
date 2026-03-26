import 'package:flutter/material.dart';

// ─── Colors ────────────────────────────────────────────────────────────────
const kPrimary = Color(0xFFF2C287);
const kPrimaryDark = Color(0xFFD9A05B);
const kBackground = Color(0xFFFCF9F5);
const kWarmAccent = Color(0xFFFDF6ED);
const kSurface = Colors.white;

// ─── Data Models ───────────────────────────────────────────────────────────
enum StockStatus { inStock, lowStock, outOfStock }

class Product {
  final String id;
  final String name;
  final String category;
  final int units;
  final double price;
  final String imageUrl;
  final StockStatus status;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.units,
    required this.price,
    required this.imageUrl,
    required this.status,
  });
}
