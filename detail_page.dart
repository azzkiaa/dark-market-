import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          product["name"],
          style: const TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.tealAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar / emoji produk
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.teal.withOpacity(0.2),
                child: Text(
                  "${product["image"]}",
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama produk
            Text(
              product["name"],
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Deskripsi produk
            Text(
              product["description"] ?? "",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Harga produk
            Text(
              "Harga: ${product["price"]}",
              style: const TextStyle(
                color: Colors.tealAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            // Tombol tambah ke keranjang
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  cartProvider.addToCart(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${product["name"]} ditambahkan ke keranjang",
                      ),
                      backgroundColor: Colors.tealAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text(
                  "Tambah ke Keranjang",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
