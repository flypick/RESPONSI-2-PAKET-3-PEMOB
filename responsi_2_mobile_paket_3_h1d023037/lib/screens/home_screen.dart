import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_2_mobile_paket_3_h1d023037/screens/form_buku_screen.dart';
import 'package:responsi_2_mobile_paket_3_h1d023037/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _listBuku = [];
  final String baseUrl = 'http://10.0.2.2/audimart_api'; // Sesuaikan IP

  Future<void> _getBuku() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/read.php'));
      if (response.statusCode == 200) {
        setState(() {
          _listBuku = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteBuku(String id) async {
    await http.post(Uri.parse('$baseUrl/delete.php'), body: {'id': id});
    _getBuku(); // Refresh data setelah hapus
  }

  @override
  void initState() {
    super.initState();
    _getBuku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaris Audimart"), // Wajib ada nama
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      body: _listBuku.isEmpty
          ? const Center(child: Text("Belum ada data buku"))
          : ListView.builder(
              itemCount: _listBuku.length,
              itemBuilder: (context, index) {
                final data = _listBuku[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(data['judul'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Rp ${data['harga']} | Stok: ${data['jumlah']}\nPenulis: ${data['penulis']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // Ke halaman edit
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormBukuScreen(dataAwal: data),
                              ),
                            );
                            _getBuku(); // Refresh saat kembali
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Konfirmasi hapus
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Hapus Buku?"),
                                content: const Text("Data tidak bisa dikembalikan."),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
                                  TextButton(
                                    onPressed: () {
                                      _deleteBuku(data['id']);
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const FormBukuScreen()));
          _getBuku();
        },
      ),
    );
  }
}