import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Tentang",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "DarkMarket App",
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Aplikasi ini adalah demo marketplace dengan tema futuristik "
              "yang menampilkan halaman dashboard, pesanan, pengaturan, dan info tentang aplikasi.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Versi: 1.0.0",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Text(
              "Dibuat dengan Flutter ❤️",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
