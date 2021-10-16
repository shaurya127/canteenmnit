import 'dart:ffi';

class AnyFoodItemOverview {
  final String ID;
  final String name;
  final double price;
  final bool isAvailable;
  final int quantity;

  AnyFoodItemOverview({
    required this.ID,
    required this.name,
    required this.price,
    required this.isAvailable,
    required this.quantity,
  });
}
