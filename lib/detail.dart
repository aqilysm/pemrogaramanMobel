import 'package:flutter/material.dart';
import 'models/data.dart'; // Import model Animal

// Halaman Detail Hewan - dikosongkan terlebih dahulu
class DetailPage extends StatelessWidget {
  // Menerima data hewan yang dikirim dari halaman home
  final Animal animal;

  const DetailPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna hitam
      appBar: AppBar(
        title: Text(
          animal.name, // Menampilkan nama hewan di AppBar
          style: const TextStyle(color: Colors.white), // Warna teks putih
        ),
        backgroundColor: Colors.black, // Warna AppBar hitam
        centerTitle: true, // Judul di tengah
        iconTheme: const IconThemeData(color: Colors.white), // Warna icon back putih
      ),

      // Background halaman warna broken white
      backgroundColor: const Color(0xFFFAFAFA), // Warna broken white

      // Body dikosongkan terlebih dahulu
      body: const Center(
        child: Text(
          'Detail Page - Coming Soon',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
