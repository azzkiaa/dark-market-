import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  void addOrder(Map<String, dynamic> product) {
    _orders.add(product);
    notifyListeners();
  }
}
