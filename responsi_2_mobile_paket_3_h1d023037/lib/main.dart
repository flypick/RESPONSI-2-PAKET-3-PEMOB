import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023037/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audimart',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Warna wajib 
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set halaman awal ke Login
    );
  }
}