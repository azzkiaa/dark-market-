import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Pengaturan",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.person, color: Colors.tealAccent),
            title: Text(
              "Akun",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Kelola informasi akun anda",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.tealAccent),
            title: Text(
              "Keamanan",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Ubah password atau PIN",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.color_lens, color: Colors.tealAccent),
            title: Text(
              "Tema",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Pilih tema aplikasi",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
