import 'package:flutter/material.dart';
import 'models/data.dart'; // Import data hewan dari models
import 'detail.dart'; // Import halaman detail hewan
import 'login.dart'; // Import halaman login untuk logout

// Halaman Home - menampilkan daftar hewan dalam bentuk grid 2 kolom
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna hitam
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white), // Warna teks putih agar kontras
        ),
        backgroundColor: Colors.black, // Warna AppBar hitam
        centerTitle: true, // Judul di tengah
        // Tombol logout di sebelah kanan navbar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // Icon logout berwarna putih
            tooltip: 'Logout', // Tooltip saat hover
            onPressed: () {
              // Navigasi kembali ke halaman login menggunakan pushReplacement
              // pushReplacement agar user tidak bisa kembali ke home dengan tombol back
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      // Background halaman warna broken white
      backgroundColor: const Color(0xFFFAFAFA), // Warna broken white

      // Body halaman home - menampilkan daftar hewan menggunakan GridView.builder
      body: GridView.builder(
        padding: const EdgeInsets.all(12), // Padding di sekeliling grid
        itemCount: dummyAnimals.length, // Jumlah item sesuai jumlah data hewan
        // Konfigurasi grid 2 kolom
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 card per baris (berdampingan)
          crossAxisSpacing: 12, // Jarak horizontal antar card
          mainAxisSpacing: 12, // Jarak vertikal antar card
          childAspectRatio: 0.75, // Rasio card agar berbentuk persegi dengan ruang teks
        ),
        itemBuilder: (context, index) {
          // Mengambil data hewan berdasarkan index
          final animal = dummyAnimals[index];

          // Card untuk setiap item hewan
          return Card(
            elevation: 3, // Bayangan card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Sudut rounded pada card
            ),
            clipBehavior: Clip.antiAlias, // Memotong konten agar mengikuti bentuk card
            // InkWell agar card bisa diklik
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman detail hewan saat card diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(animal: animal), // Mengirim data hewan ke halaman detail
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Konten rata kiri
                children: [
                  // Foto hewan - mengisi bagian atas card berbentuk persegi
                  Expanded(
                    child: SizedBox(
                      width: double.infinity, // Lebar penuh
                      child: Image.network(
                        animal.image, // URL gambar hewan dari data
                        fit: BoxFit.cover, // Gambar memenuhi area tanpa distorsi
                        // Placeholder saat gambar loading
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200], // Warna placeholder abu-abu
                            child: const Center(
                              child: CircularProgressIndicator(), // Indikator loading
                            ),
                          );
                        },
                        // Placeholder jika gambar gagal dimuat
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300], // Warna placeholder abu-abu
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 40), // Icon gambar rusak
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Informasi hewan di bawah gambar
                  Padding(
                    padding: const EdgeInsets.all(8), // Padding di dalam area teks
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
                      children: [
                        // Nama hewan
                        Text(
                          animal.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold, // Teks tebal
                            color: Colors.black87,
                          ),
                          maxLines: 1, // Maksimal 1 baris
                          overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
                        ),
                        const SizedBox(height: 2), // Spasi antar teks

                        // Tipe hewan (Mammal, Reptile, dll)
                        Text(
                          animal.type,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700], // Warna teks abu-abu gelap
                          ),
                        ),
                        const SizedBox(height: 2), // Spasi antar teks

                        // Habitat hewan - digabung dengan koma
                        Text(
                          animal.habitat.join(", "),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600], // Warna teks abu-abu
                          ),
                          maxLines: 1, // Maksimal 1 baris
                          overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
