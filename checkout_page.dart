import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orders_provider.dart';

class CheckoutPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const CheckoutPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Produk
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal.withOpacity(0.2),
                  child: Text(
                    product["image"],
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["name"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product["price"],
                        style: const TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Metode Pembayaran
            const Text(
              "Metode Pembayaran",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[900],
              leading: const Icon(Icons.payment, color: Colors.tealAccent),
              title: const Text(
                "Transfer Bank",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              tileColor: Colors.grey[900],
              leading: const Icon(Icons.qr_code, color: Colors.tealAccent),
              title: const Text(
                "QRIS / E-Wallet",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              tileColor: Colors.grey[900],
              leading: const Icon(
                Icons.local_shipping,
                color: Colors.tealAccent,
              ),
              title: const Text(
                "COD (Bayar di tempat)",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),

            const Spacer(),

            // Tombol konfirmasi
            ElevatedButton(
              onPressed: () {
                // 🔹 Simpan pesanan ke provider
                context.read<OrdersProvider>().addOrder(product);

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Pesanan Berhasil"),
                    content: const Text(
                      "Terima kasih! Pesanan kamu sudah masuk ke daftar Pesanan Saya.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // balik ke detail/dashboard
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Konfirmasi Pesanan"),
            ),
          ],
        ),
      ),
    );
  }
}
