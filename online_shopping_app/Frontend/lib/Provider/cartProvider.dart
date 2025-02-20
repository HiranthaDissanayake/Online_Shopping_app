import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

void addToCart(Map<String, dynamic> item) {
  int index = _cartItems.indexWhere((cartItem) => cartItem["name"] == item["name"]);

  if (index != -1) {
    // If item already exists, increase its quantity
    _cartItems[index]["quantity"] += item["quantity"];
  } else {
    // If new item, ensure it has a quantity field
    _cartItems.add({...item, "quantity": item["quantity"]});
  }
  notifyListeners();
}


  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      double price =
          double.tryParse(item["price"].toString()) ?? 0.0; // Convert to double
      int quantity =
          int.tryParse(item["quantity"].toString()) ?? 1; // Convert to int
      return sum + (price * quantity);
    });
  }
}
