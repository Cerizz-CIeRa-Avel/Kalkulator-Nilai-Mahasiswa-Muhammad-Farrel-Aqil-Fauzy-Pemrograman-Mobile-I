import 'package:flutter/material.dart';

class Mahasiswa {
  final String nama;
  final double tugas;
  final double uts;
  final double uas;
  final double nilaiAkhir;
  final String grade;
  final String status;

  Mahasiswa({
    required this.nama,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.nilaiAkhir,
    required this.grade,
    required this.status,
  });

  factory Mahasiswa.hitung({
    required String nama,
    required double tugas,
    required double uts,
    required double uas,
  }) {
    double nilaiAkhir = (0.30 * tugas) + (0.30 * uts) + (0.40 * uas);

    String grade;
    if (nilaiAkhir >= 85) {
      grade = 'A';
    } else if (nilaiAkhir >= 75) {
      grade = 'B';
    } else if (nilaiAkhir >= 65) {
      grade = 'C';
    } else if (nilaiAkhir >= 50) {
      grade = 'D';
    } else {
      grade = 'E';
    }

    String status = (nilaiAkhir >= 60) ? 'Lulus' : 'Tidak Lulus';

    return Mahasiswa(
      nama: nama,
      tugas: tugas,
      uts: uts,
      uas: uas,
      nilaiAkhir: nilaiAkhir,
      grade: grade,
      status: status,
    );
  }
}

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

  final List<Mahasiswa> _listMahasiswa = [
    Mahasiswa.hitung(nama: 'Andi Pratama', tugas: 85, uts: 90, uas: 88),
    Mahasiswa.hitung(nama: 'Budi Santoso', tugas: 70, uts: 75, uas: 80),
    Mahasiswa.hitung(nama: 'Citra Dewi', tugas: 60, uts: 65, uas: 55),
    Mahasiswa.hitung(nama: 'Doni Wijaya', tugas: 50, uts: 45, uas: 50),
    Mahasiswa.hitung(nama: 'Eka Putri', tugas: 95, uts: 85, uas: 90),
    Mahasiswa.hitung(nama: 'Fajar Nugraha', tugas: 40, uts: 50, uas: 45),
    Mahasiswa.hitung(nama: 'Gita Gutawa', tugas: 78, uts: 82, uas: 75),
    Mahasiswa.hitung(nama: 'Hadi Kurniawan', tugas: 65, uts: 70, uas: 60),
    Mahasiswa.hitung(nama: 'Indah Permata', tugas: 88, uts: 92, uas: 95),
    Mahasiswa.hitung(nama: 'Joko Susilo', tugas: 55, uts: 60, uas: 58),
  ];

  void _tambahMahasiswa() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final mhsBaru = Mahasiswa.hitung(
          nama: _namaController.text,
          tugas: double.parse(_tugasController.text),
          uts: double.parse(_utsController.text),
          uas: double.parse(_uasController.text),
        );

        _listMahasiswa.insert(0, mhsBaru);

        _namaController.clear();
        _tugasController.clear();
        _utsController.clear();
        _uasController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Mahasiswa Berhasil Ditambahkan!')),
      );
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
        title: const Text('Aplikasi Nilai Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Form Input
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Input Data Mahasiswa Baru',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Mahasiswa',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Isi nama' : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _tugasController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Tugas',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Isi nilai'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _utsController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'UTS',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Isi nilai'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _uasController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'UAS',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Isi nilai'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _tambahMahasiswa,
                        child: const Text('Hitung & Tambah Data'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Header Daftar Mahasiswa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Nilai Mahasiswa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text('Total: ${_listMahasiswa.length}'),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Section List Mahasiswa (Minimal 10 Data)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _listMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = _listMahasiswa[index];
                final isLulus = mhs.status == 'Lulus';

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          isLulus ? Colors.green.shade100 : Colors.red.shade100,
                      child: Text(
                        mhs.grade,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isLulus ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    title: Text(
                      mhs.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tugas: ${mhs.tugas.toInt()} | UTS: ${mhs.uts.toInt()} | UAS: ${mhs.uas.toInt()}\n'
                      'Nilai Akhir: ${mhs.nilaiAkhir.toStringAsFixed(2)}',
                    ),
                    isThreeLine: true,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isLulus ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        mhs.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}