import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_2_mobile_paket_3_h1d023037/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  
  // Ganti URL ini. Jika pakai Emulator Android gunakan 10.0.2.2
  // Jika pakai HP fisik, gunakan IP Laptop (misal 192.168.1.x)
  final String baseUrl = 'http://10.0.2.2/audimart_api'; 

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'username': _usernameCtrl.text,
        'password': _passwordCtrl.text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        // Login Berhasil
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Gagal")));
      }
    }
  }

  Future<void> _register() async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrasi.php'),
      body: {
        'username': _usernameCtrl.text,
        'password': _passwordCtrl.text,
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registrasi Berhasil, Silakan Login")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50], // Warna tema coklat muda
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("AUDIMART", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.brown)),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Username"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, foregroundColor: Colors.white),
                child: const Text("LOGIN"),
              ),
              TextButton(
                onPressed: _register,
                child: const Text("Belum punya akun? Daftar disini", style: TextStyle(color: Colors.brown)),
              )
            ],
          ),
        ),
      ),
    );
  }
}