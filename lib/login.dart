import 'package:flutter/material.dart';
import 'models/data.dart'; // Import data username & password
import 'home.dart'; // Import halaman home untuk navigasi

// Halaman Login - Stateful karena memiliki input field yang berubah
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil nilai input dari TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk toggle visibility password
  bool _obscurePassword = true;

  // Fungsi untuk memproses login
  void _login() {
    // Mengambil nilai input dari controller
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Validasi: cek apakah field kosong
    if (username.isEmpty || password.isEmpty) {
      // Tampilkan snackbar merah jika field kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password tidak boleh kosong!'),
          backgroundColor: Colors.red, // Warna snackbar merah
          duration: Duration(seconds: 2),
        ),
      );
      return; // Hentikan proses login
    }

    // Validasi: cocokkan input dengan data user1 yang tersimpan di models/data.dart
    if (username == user1.username && password == user1.password) {
      // Login berhasil - tampilkan snackbar hijau
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil!'),
          backgroundColor: Colors.green, // Warna snackbar hijau
          duration: Duration(seconds: 1),
        ),
      );

      // Navigasi ke halaman Home menggunakan pushReplacement
      // pushReplacement mengganti halaman login sehingga user tidak bisa kembali ke login dengan tombol back
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Login gagal - tampilkan snackbar merah dengan informasi error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password salah!'),
          backgroundColor: Colors.red, // Warna snackbar merah untuk login gagal
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Membersihkan controller saat widget dihapus dari tree untuk mencegah memory leak
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna hitam sesuai permintaan
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white), // Warna teks putih agar kontras di background hitam
        ),
        backgroundColor: Colors.black, // Warna AppBar hitam
        centerTitle: true, // Judul di tengah
      ),

      // Background halaman warna broken white
      backgroundColor: const Color(0xFFFAFAFA), // Warna broken white

      // Body halaman login
      body: Center(
        child: SingleChildScrollView(
          // SingleChildScrollView agar halaman bisa di-scroll saat keyboard muncul
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Posisi konten di tengah secara vertikal
            children: [
              // Icon user sebagai dekorasi halaman login
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.black54,
              ),
              const SizedBox(height: 24), // Spasi antar widget

              // Label judul form login
              const Text(
                'Silakan Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32), // Spasi antar widget

              // TextField untuk input Username (NIM)
              TextField(
                controller: _usernameController, // Menghubungkan controller ke TextField
                decoration: InputDecoration(
                  labelText: 'Username', // Label petunjuk input
                  prefixIcon: const Icon(Icons.person), // Icon di depan field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut rounded pada border
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background field putih
                ),
              ),
              const SizedBox(height: 16), // Spasi antar widget

              // TextField untuk input Password (Nama Prodi)
              TextField(
                controller: _passwordController, // Menghubungkan controller ke TextField
                obscureText: _obscurePassword, // Menyembunyikan teks password
                decoration: InputDecoration(
                  labelText: 'Password', // Label petunjuk input
                  prefixIcon: const Icon(Icons.lock), // Icon gembok di depan field
                  // Tombol untuk toggle visibility password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      // Toggle visibilitas password
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut rounded pada border
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background field putih
                ),
              ),
              const SizedBox(height: 24), // Spasi antar widget

              // Tombol Login - lebar penuh
              SizedBox(
                width: double.infinity, // Lebar tombol mengisi seluruh lebar parent
                height: 50,
                child: ElevatedButton(
                  onPressed: _login, // Memanggil fungsi _login saat tombol ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Warna tombol hitam
                    foregroundColor: Colors.white, // Warna teks tombol putih
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Sudut rounded pada tombol
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
