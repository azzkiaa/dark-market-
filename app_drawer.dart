import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'orders_page.dart';
import 'setting.dart';
import 'about_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            accountName: const Text("kia"),
            accountEmail: const Text("kia@darkmarket.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.tealAccent),
            title: const Text("Beranda", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardPage(username: "kia"))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.tealAccent),
            title: const Text("Pesanan Saya", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OrdersPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.tealAccent),
            title: const Text("Pengaturan", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SettingPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.tealAccent),
            title: const Text("Tentang", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
