import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'orders_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().items;
    final cartProvider = context.read<CartProvider>();

    // Hitung total harga
    double totalHarga = cart.fold<double>(0, (sum, item) {
      final price =
          double.tryParse(
            item["price"].toString().replaceAll(RegExp(r'[^0-9.]'), ""),
          ) ??
          0;
      return sum + price;
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Keranjang",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                "Keranjang kosong",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : Column(
              children: [
                // Daftar item keranjang
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.withOpacity(0.2),
                          child: Text("${item["image"]}" ?? "📦"),
                        ),
                        title: Text(
                          item["name"],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          item["price"],
                          style: const TextStyle(color: Colors.tealAccent),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cartProvider.removeFromCart(index);
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Total harga
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp ${totalHarga.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tombol checkout
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      cartProvider.checkout();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout berhasil!")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const OrdersPage()),
                      );
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
