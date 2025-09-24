import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'cart_provider.dart';
import 'orders_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Futuristic Login",
        theme: ThemeData.dark(useMaterial3: true),
        home: const SplashScreen(),
      ),
    );
  }
}
