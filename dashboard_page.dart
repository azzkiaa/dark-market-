import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'detail_page.dart';
import 'cart_page.dart';
import 'cart_provider.dart';
import 'about_page.dart' as about;
import 'orders_page.dart';
import 'setting.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _gridController;
  int _selectedCategory = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> categories = [
    "Semua Produk",
    "Senjata Api",
    "Senjata Tajam",
    "Pelindung",
    "Perlengkapan",
    "Obat-obatan",
  ];

  final List<Map<String, dynamic>> products = [
    // --- Senjata Api ---
    {
      "name": "AK-47 Assault Rifle",
      "price": "\$3,500",
      "category": "Senjata Api",
      "rating": 4.8,
      "image": "🔫",
      "description":
          "Senjata otomatis andalan, kondisi baru, termasuk 3 magazen",
    },
    {
      "name": "Glock 19 Pistol",
      "price": "\$850",
      "category": "Senjata Api",
      "rating": 4.6,
      "image": "🔫",
      "description":
          "Pistol semi-otomatis, mudah disembunyikan, aman digunakan",
    },
    {
      "name": "M4A1 Carbine",
      "price": "\$2,800",
      "category": "Senjata Api",
      "rating": 4.7,
      "image": "🔫",
      "description":
          "Carbine ringan dengan akurasi tinggi, cocok untuk pertempuran jarak menengah.",
    },
    {
      "name": "Sniper Rifle AWM",
      "price": "\$5,500",
      "category": "Senjata Api",
      "rating": 4.9,
      "image": "🎯",
      "description": "Senapan jarak jauh presisi tinggi, termasuk teleskop 8x.",
    },

    // --- Senjata Tajam ---
    {
      "name": "Combat Knife",
      "price": "\$280",
      "category": "Senjata Tajam",
      "rating": 4.5,
      "image": "🔪",
      "description": "Pisau tempur high-carbon steel, tahan karat dan tajam",
    },
    {
      "name": "Samurai Katana",
      "price": "\$1,100",
      "category": "Senjata Tajam",
      "rating": 4.8,
      "image": "⚔️",
      "description":
          "Pedang katana tradisional Jepang, tajam dan berlapis baja lipat.",
    },

    // --- Pelindung & Perlengkapan ---
    {
      "name": "Kevlar Vest",
      "price": "\$1,200",
      "category": "Pelindung",
      "rating": 4.7,
      "image": "🛡️",
      "description": "Rompi anti peluru tingkat IIIA, ukuran universal",
    },
    {
      "name": "Tactical Helmet",
      "price": "\$600",
      "category": "Pelindung",
      "rating": 4.4,
      "image": "🪖",
      "description":
          "Helm taktis dengan perlindungan balistik standar militer.",
    },
    {
      "name": "Smoke Grenade",
      "price": "\$150",
      "category": "Perlengkapan",
      "rating": 4.3,
      "image": "💨",
      "description": "Granat asap untuk perlindungan visual dan strategi.",
    },
    {
      "name": "Binoculars",
      "price": "\$200",
      "category": "Perlengkapan",
      "rating": 4.2,
      "image": "🔭",
      "description": "Teropong jarak jauh dengan night vision.",
    },

    // --- Obat-obatan ---
    {
      "name": "First Aid Kit",
      "price": "\$100",
      "category": "Obat-obatan",
      "rating": 4.6,
      "image": "🩹",
      "description":
          "Kotak P3K lengkap dengan perban, obat merah, dan kasa steril.",
    },
    {
      "name": "Adrenaline Shot",
      "price": "\$250",
      "category": "Obat-obatan",
      "rating": 4.7,
      "image": "💉",
      "description": "Suntikan adrenalin darurat untuk meningkatkan stamina.",
    },
    {
      "name": "Painkillers",
      "price": "\$120",
      "category": "Obat-obatan",
      "rating": 4.5,
      "image": "💊",
      "description": "Obat pereda nyeri cepat, cocok untuk pemulihan darurat.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _gridController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedCategory == 0) {
      return products;
    } else {
      String selectedCategory = categories[_selectedCategory];
      return products
          .where((product) => product["category"] == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().items;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "DARK MARKET",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.tealAccent),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          // Cart Icon
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.tealAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          // Logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.tealAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      // Drawer
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.teal),
              accountName: Text(
                widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                "${widget.username}@darkmarket.com",
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Colors.tealAccent, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.tealAccent),
              title: const Text(
                "Beranda",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.tealAccent),
              title: const Text(
                "Pesanan Saya",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrdersPage()),
                );
              },
            ),
            const Divider(color: Colors.tealAccent),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.tealAccent),
              title: const Text(
                "Pengaturan",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.tealAccent),
              title: const Text(
                "Tentang",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const about.AboutPage()),
                );
              },
            ),
          ],
        ),
      ),

      // Body
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _gridController,
            builder: (context, child) {
              return CustomPaint(
                painter: GridPainter(_gridController.value),
                size: MediaQuery.of(context).size,
              );
            },
          ),

          // Konten utama
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat datang, ${widget.username}",
                      style: const TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Temukan produk terbaik dengan harga khusus",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Category filter
              SizedBox(
                height: 50,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(
                          categories[index],
                          style: TextStyle(
                            color: _selectedCategory == index
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        selected: _selectedCategory == index,
                        selectedColor: Colors.tealAccent,
                        backgroundColor: Colors.grey[800],
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // List Produk
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          "Tidak ada produk",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Card(
                            color: Colors.grey[900]!.withOpacity(0.7),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.withOpacity(0.2),
                                radius: 25,
                                child: Text(
                                  product["image"],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              title: Text(
                                product["name"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                product["price"],
                                style: const TextStyle(
                                  color: Colors.tealAccent,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.tealAccent,
                                    ),
                                    onPressed: () {
                                      context.read<CartProvider>().addToCart(
                                        product,
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Ditambahkan ke keranjang",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.flash_on,
                                      color: Colors.orangeAccent,
                                    ),
                                    onPressed: () {
                                      final cartProvider = context
                                          .read<CartProvider>();
                                      cartProvider.addToCart(product);
                                      cartProvider.checkout();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Pembelian berhasil (Beli Langsung)",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(product: product),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
