import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorNilaiApp());
}

class KalkulatorNilaiApp extends StatelessWidget {
  const KalkulatorNilaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Nilai Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KalkulatorNilaiPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KalkulatorNilaiPage extends StatefulWidget {
  const KalkulatorNilaiPage({super.key});

  @override
  State<KalkulatorNilaiPage> createState() => _KalkulatorNilaiPageState();
}

class _KalkulatorNilaiPageState extends State<KalkulatorNilaiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _tugasController = TextEditingController();
  final _utsController = TextEditingController();
  final _uasController = TextEditingController();

  String _namaHasil = '';
  double _nilaiAkhir = 0;
  String _grade = '';
  String _status = '';
  bool _sudahHitung = false;

  void _hitungNilai() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _namaHasil = _namaController.text;
        double tugas = double.parse(_tugasController.text);
        double uts = double.parse(_utsController.text);
        double uas = double.parse(_uasController.text);

        _nilaiAkhir = (0.30 * tugas) + (0.30 * uts) + (0.40 * uas);

        if (_nilaiAkhir >= 85) {
          _grade = 'A';
        } else if (_nilaiAkhir >= 75) {
          _grade = 'B';
        } else if (_nilaiAkhir >= 65) {
          _grade = 'C';
        } else if (_nilaiAkhir >= 50) {
          _grade = 'D';
        } else {
          _grade = 'E';
        }

        if (_nilaiAkhir >= 60) {
          _status = 'Lulus';
        } else {
          _status = 'Tidak Lulus';
        }

        _sudahHitung = true;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tugasController.dispose();
    _utsController.dispose();
    _uasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Nilai Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mahasiswa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _tugasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nilai Tugas (0 - 100)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.assignment),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nilai tugas tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _utsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nilai UTS (0 - 100)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nilai UTS tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _uasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nilai UAS (0 - 100)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.menu_book),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nilai UAS tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _hitungNilai,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Hitung Nilai Akhir',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),

              if (_sudahHitung) ...[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hasil Perhitungan Nilai',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        Text('Nama: $_namaHasil',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 6),
                        Text(
                          'Nilai Akhir: ${_nilaiAkhir.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Grade: $_grade',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Status: $_status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _status == 'Lulus'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}