import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get items => _items;
  List<Map<String, dynamic>> get orders => _orders;

  void addToCart(Map<String, dynamic> product) {
    // Cek apakah produk sudah ada di keranjang
    final index = _items.indexWhere((item) => item["name"] == product["name"]);

    if (index >= 0) {
      // Jika sudah ada, tambahkan qty
      _items[index]["qty"] = (_items[index]["qty"] ?? 1) + 1;
    } else {
      // Jika belum ada, masukkan produk baru dengan qty = 1
      final newProduct = {...product, "qty": 1};
      _items.add(newProduct);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void checkout() {
    if (_items.isEmpty) return;

    final order = {
      "id": "ORD-${(_orders.length + 1).toString().padLeft(3, "0")}",
      "date": DateTime.now().toString().substring(0, 10),
      "status": "Diproses",
      "items": List<Map<String, dynamic>>.from(_items),
      "total": _items.fold<double>(0, (sum, item) {
        final price = item["price"] is double
            ? item["price"] as double
            : double.tryParse(
                    item["price"].toString().replaceAll(RegExp(r'[^0-9.]'), ""),
                  ) ??
                  0;
        final qty = item["qty"] ?? 1;
        return sum + (price * qty);
      }),
    };

    _orders.add(order);
    clearCart();
    notifyListeners();
  }
}
