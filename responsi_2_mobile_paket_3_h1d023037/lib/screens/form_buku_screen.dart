import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormBukuScreen extends StatefulWidget {
  final Map? dataAwal; // Jika null = Tambah, Jika ada isi = Edit
  const FormBukuScreen({super.key, this.dataAwal});

  @override
  State<FormBukuScreen> createState() => _FormBukuScreenState();
}

class _FormBukuScreenState extends State<FormBukuScreen> {
  // Controller untuk 7 inputan wajib
  final _judulCtrl = TextEditingController();
  final _hargaCtrl = TextEditingController();
  final _jumlahCtrl = TextEditingController();
  final _tglCtrl = TextEditingController();
  final _volCtrl = TextEditingController();
  final _penulisCtrl = TextEditingController();
  final _penerbitCtrl = TextEditingController();
  
  final String baseUrl = 'http://10.0.2.2/audimart_api';

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi kolom dengan data lama
    if (widget.dataAwal != null) {
      _judulCtrl.text = widget.dataAwal!['judul'];
      _hargaCtrl.text = widget.dataAwal!['harga'].toString();
      _jumlahCtrl.text = widget.dataAwal!['jumlah'].toString();
      _tglCtrl.text = widget.dataAwal!['tanggal_masuk'];
      _volCtrl.text = widget.dataAwal!['volume'].toString();
      _penulisCtrl.text = widget.dataAwal!['penulis'];
      _penerbitCtrl.text = widget.dataAwal!['penerbit'];
    }
  }

  Future<void> _simpan() async {
    // Tentukan URL: Edit atau Tambah?
    var url = widget.dataAwal == null 
        ? Uri.parse('$baseUrl/create.php') 
        : Uri.parse('$baseUrl/update.php');

    // Data yang dikirim
    var body = {
      'judul': _judulCtrl.text,
      'harga': _hargaCtrl.text,
      'jumlah': _jumlahCtrl.text,
      'tanggal_masuk': _tglCtrl.text,
      'volume': _volCtrl.text,
      'penulis': _penulisCtrl.text,
      'penerbit': _penerbitCtrl.text,
    };

    // Jika edit, harus bawa ID
    if (widget.dataAwal != null) {
      body['id'] = widget.dataAwal!['id'];
    }

    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      Navigator.pop(context); // Kembali ke Home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Gagal menyimpan")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dataAwal == null ? "Tambah Buku" : "Edit Buku"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInput(_judulCtrl, "Judul Buku"),
            _buildInput(_hargaCtrl, "Harga", isNumber: true),
            _buildInput(_jumlahCtrl, "Jumlah", isNumber: true),
            _buildInput(_tglCtrl, "Tanggal Masuk (YYYY-MM-DD)"),
            _buildInput(_volCtrl, "Volume", isNumber: true),
            _buildInput(_penulisCtrl, "Penulis"),
            _buildInput(_penerbitCtrl, "Penerbit"),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, foregroundColor: Colors.white),
                onPressed: _simpan,
                child: const Text("SIMPAN DATA"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}