import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _gridController;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    // Animasi grid
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _gridController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background grid
          AnimatedBuilder(
            animation: _gridController,
            builder: (context, child) {
              return CustomPaint(
                painter: GridPainter(_gridController.value),
                size: MediaQuery.of(context).size,
              );
            },
          ),

          // Form login di tengah dengan container
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.tealAccent.withOpacity(0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/globe.png",
                        height: 80,
                        color: Colors.tealAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "WELCOME TO DARK MARKET",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        "Please enter your email and password",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Username
                    const Text(
                      "Username",
                      style: TextStyle(fontSize: 12, color: Colors.tealAccent),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 12, color: Colors.tealAccent),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Tombol login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 40,
                          ),
                          backgroundColor: Colors.tealAccent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardPage(
                                username: _usernameController.text,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Painter untuk grid bergerak
class GridPainter extends CustomPainter {
  final double animationValue;
  GridPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.tealAccent.withOpacity(0.2)
      ..strokeWidth = 1;

    const cellSize = 40.0;
    final offset = animationValue * cellSize;

    for (double x = -cellSize; x < size.width + cellSize; x += cellSize) {
      canvas.drawLine(
        Offset(x + offset, 0),
        Offset(x + offset, size.height),
        paint,
      );
    }
    for (double y = -cellSize; y < size.height + cellSize; y += cellSize) {
      canvas.drawLine(
        Offset(0, y + offset),
        Offset(size.width, y + offset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
