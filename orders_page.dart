import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'order_detail_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil daftar orders dari CartProvider
    final orders = context.watch<CartProvider>().orders;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Pesanan Saya",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "Belum ada pesanan",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      order["id"] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${order["date"]} • ${order["status"]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      "Rp ${(order["total"] as double).toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderDetailPage(order: order),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
