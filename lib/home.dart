import 'package:flutter/material.dart';

// Halaman Home - ditampilkan setelah login berhasil
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna hitam sesuai tema
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white), // Warna teks putih agar kontras
        ),
        backgroundColor: Colors.black, // Warna AppBar hitam
        centerTitle: true, // Judul di tengah
      ),

      // Background halaman warna krem
      backgroundColor: const Color(0xFFFFF8E1), // Warna krem

      // Body halaman home
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisi konten di tengah
          children: [
            // Icon selamat datang
            Icon(
              Icons.home,
              size: 80,
              color: Colors.black54,
            ),
            SizedBox(height: 16), // Spasi antar widget

            // Teks selamat datang
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8), // Spasi antar widget

            // Teks informasi login berhasil
            Text(
              'Login Berhasil 🎉',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
