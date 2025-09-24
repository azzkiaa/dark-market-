import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order["items"] as List<dynamic>;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Detail ${order["id"]}",
          style: const TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal: ${order["date"]}",
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Status: ${order["status"]}",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Text(
              "Item Pesanan:",
              style: TextStyle(
                color: Colors.tealAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map<String, dynamic>;
                  return Card(
                    color: Colors.grey[850],
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.withOpacity(0.2),
                        child: Text(item["image"] ?? "📦"),
                      ),
                      title: Text(
                        item["name"],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Qty: 1", // default qty karena belum ada sistem qty
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Text(
                        "Rp ${item["price"]}",
                        style: const TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(color: Colors.tealAccent),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: Rp ${(order["total"] as double).toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
