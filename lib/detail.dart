import 'package:flutter/material.dart';
import 'models/data.dart'; // Import model Animal

// Halaman Detail Hewan - menampilkan semua data hewan secara lengkap
class DetailPage extends StatelessWidget {
  // Menerima data hewan yang dikirim dari halaman home
  final Animal animal;

  const DetailPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna hitam dan tombol back untuk kembali ke Home
      appBar: AppBar(
        title: Text(
          animal.name, // Menampilkan nama hewan di AppBar
          style: const TextStyle(color: Colors.white), // Warna teks putih
        ),
        backgroundColor: Colors.black, // Warna AppBar hitam
        centerTitle: true, // Judul di tengah
        iconTheme: const IconThemeData(color: Colors.white), // Warna icon back putih
        // Tombol back di navbar untuk kembali ke Home Page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icon panah kembali
          onPressed: () {
            // Kembali ke halaman Home Page
            Navigator.pop(context);
          },
        ),
      ),

      // Background halaman warna broken white
      backgroundColor: const Color(0xFFFAFAFA), // Warna broken white

      // Body halaman detail - menggunakan SingleChildScrollView agar bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Konten rata kiri
          children: [
            // Gambar hewan - ditampilkan full width di bagian atas
            SizedBox(
              width: double.infinity, // Lebar penuh
              height: 250, // Tinggi gambar
              child: Image.network(
                '${animal.image}?auto=compress&w=800', // URL gambar dengan resize untuk performa
                fit: BoxFit.cover, // Gambar memenuhi area tanpa distorsi
                cacheWidth: 800, // Membatasi cache gambar di memori
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
                      child: Icon(Icons.broken_image, size: 60), // Icon gambar rusak
                    ),
                  );
                },
              ),
            ),

            // Konten detail hewan
            Padding(
              padding: const EdgeInsets.all(16), // Padding di sekeliling konten
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Konten rata kiri
                children: [
                  // Nama hewan - judul utama
                  Text(
                    animal.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold, // Teks tebal
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8), // Spasi antar elemen

                  // Chip tipe hewan (Mammal, Reptile, dll)
                  Chip(
                    label: Text(
                      animal.type, // Tipe hewan
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    backgroundColor: Colors.black87, // Warna chip hitam
                  ),
                  const SizedBox(height: 20), // Spasi antar elemen

                  // Baris informasi berat dan tinggi berdampingan
                  Row(
                    children: [
                      // Card info berat hewan
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.monitor_weight_outlined, // Icon timbangan
                          label: 'Berat', // Label
                          value: '${animal.weight} kg', // Nilai berat
                        ),
                      ),
                      const SizedBox(width: 12), // Spasi antar card

                      // Card info tinggi hewan
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.height, // Icon tinggi
                          label: 'Tinggi', // Label
                          value: '${animal.height} cm', // Nilai tinggi
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Spasi antar elemen

                  // Label section Habitat
                  const Text(
                    'Habitat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Judul section tebal
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10), // Spasi antar elemen

                  // Menampilkan habitat dalam bentuk Chip/Wrap agar rapi
                  Wrap(
                    spacing: 8, // Jarak horizontal antar chip
                    runSpacing: 8, // Jarak vertikal antar baris chip
                    children: animal.habitat.map((habitat) {
                      // Setiap habitat ditampilkan sebagai chip
                      return Chip(
                        avatar: const Icon(Icons.location_on, size: 18, color: Colors.green), // Icon lokasi
                        label: Text(
                          habitat, // Nama habitat
                          style: const TextStyle(fontSize: 13),
                        ),
                        backgroundColor: Colors.green[50], // Warna chip hijau muda
                        side: BorderSide(color: Colors.green[200]!), // Border chip hijau
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20), // Spasi antar elemen

                  // Label section Aktivitas
                  const Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Judul section tebal
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10), // Spasi antar elemen

                  // Menampilkan aktivitas dalam bentuk list
                  ...animal.activities.map((activity) {
                    // Setiap aktivitas ditampilkan sebagai baris dengan icon
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6), // Jarak antar item
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle, // Icon centang
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 10), // Spasi antara icon dan teks
                          // Nama aktivitas
                          Text(
                            activity,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16), // Spasi bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat card informasi (berat & tinggi)
  Widget _buildInfoCard({
    required IconData icon, // Icon yang ditampilkan
    required String label, // Label informasi
    required String value, // Nilai informasi
  }) {
    return Container(
      padding: const EdgeInsets.all(14), // Padding di dalam card
      decoration: BoxDecoration(
        color: Colors.white, // Background card putih
        borderRadius: BorderRadius.circular(12), // Sudut rounded
        border: Border.all(color: Colors.grey[300]!), // Border abu-abu
      ),
      child: Column(
        children: [
          // Icon informasi
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(height: 6), // Spasi antar elemen

          // Label informasi (Berat / Tinggi)
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600], // Warna teks abu-abu
            ),
          ),
          const SizedBox(height: 4), // Spasi antar elemen

          // Nilai informasi (contoh: 220.5 kg)
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold, // Teks tebal
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
