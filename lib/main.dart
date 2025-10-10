import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Online UI',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// --- Widget Utama dengan Bottom Navigation Bar ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   const MenuScreen(),
  //   const HistoryScreen(),
  //   const ProfileScreen(),
  // ];

  static final List<Widget> _widgetOptions = <Widget>[
    MenuScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// =================================================================
// 3 Halaman Utama
// =================================================================

// --- 1. Halaman Menu (Etalase) ---
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Contoh data kategori
  static const List<String> categories = [
    'Semua',
    'Kopi',
    'Non-Kopi',
    'Makanan Ringan',
    'Promo Hari Ini',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // a. SliverAppBar yang collapsible
        SliverAppBar(
          title: const Text('Menu Pilihan'),
          centerTitle: false,
          floating: true, // AppBar akan muncul kembali saat digulir ke bawah
          pinned: true,   // AppBar akan tetap berada di atas saat digulir ke atas
          expandedHeight: 60, // Tinggi header
          backgroundColor: Colors.white,
          actions: [
            // Tombol Keranjang
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),

        // b. Baris Kategori Horizontal
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryChip(
                  label: categories[index],
                  isSelected: index == 0, // Contoh: 'Semua' terpilih
                );
              },
            ),
          ),
        ),

        // c. Daftar Produk (GridView)
        SliverPadding(
          padding: const EdgeInsets.all(12.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 12, // Jarak horizontal antar kartu
              mainAxisSpacing: 12,  // Jarak vertikal antar kartu
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const MenuItemCard(
                  name: 'Kopi Susu Caramel',
                  price: 25000,
                  imagePath: 'assets/coffee.jpg'
                );
              },
              childCount: 8,
            ),
          ),
        ),
        
        // d. Sedikit ruang kosong di bawah Grid
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

// --- Widget Kustom: Chip Kategori ---
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    required this.label,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.teal.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        backgroundColor: isSelected ? Colors.teal : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final String name;
  final int price;
  final String imagePath; 

  const MenuItemCard({
    required this.name,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          // Bayangan yang lebih halus
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Placeholder Gambar
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath, // Menggunakan properti imagePath: 'assets/coffee.jpg'
                fit: BoxFit.cover,
                width: double.infinity, // Penting agar gambar mengisi lebar
                // Jika gambar gagal dimuat (misalnya path salah), tampilkan ikon
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),

          // Detail Produk
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 8.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Harga
                    Text(
                      'Rp ${price.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.w800, // Ditebalkan
                        fontSize: 16,
                      ),
                    ),
                    
                    // Tombol + (Add to Cart)
                    Container(
                      height: 30, // Mengontrol tinggi tombol
                      width: 30,  // Mengontrol lebar tombol
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(), // Penting untuk kontrol ukuran
                        iconSize: 18, // Ukuran ikon diperkecil
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. Halaman Riwayat Order ---
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Order'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return HistoryItemCard(
            orderId: 'ORD-202509$index',
            date: '10 Sept 2025',
            status: 'Selesai',
            total: 125000,
          );
        },
      ),
    );
  }
}

// --- Widget Kustom: Kartu Riwayat ---
class HistoryItemCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final int total;

  const HistoryItemCard({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          Icons.local_shipping_outlined,
          color: Colors.teal.shade400,
        ),
        title: Text(
          orderId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: $date'),
            Text('Status: $status', style: const TextStyle(color: Colors.green)),
          ],
        ),
        trailing: Text(
          'Rp ${total.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onTap: () {
          // UI Saja: Tidak ada aksi
        },
      ),
    );
  }
}

// --- 3. Halaman Profil ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Foto Profil (Image Placeholder)
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ahmad Flutter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ahmad.flutter@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Daftar Opsi Profil
            ListTile(
              leading: const Icon(Icons.edit_note, color: Colors.teal),
              title: const Text('Edit Profil'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined, color: Colors.teal),
              title: const Text('Alamat Pengiriman'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_none, color: Colors.teal),
              title: const Text('Pengaturan Notifikasi'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar', style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}