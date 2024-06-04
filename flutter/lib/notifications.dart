import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Kendaraan {
  final String noplat;
  final String jenis;

  Kendaraan({required this.noplat, required this.jenis});

  factory Kendaraan.fromJson(Map<String, dynamic> json) {
    return Kendaraan(
      noplat: json['noplat'],
      jenis: json['jenis'],
    );
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Kendaraan>> _kendaraanFuture;

  @override
  void initState() {
    super.initState();
    _fetchKendaraanAndSetState();
  }

  Future<void> _fetchKendaraanAndSetState() async {
    setState(() {
      _kendaraanFuture = fetchKendaraan();
    });
  }

  // Fungsi untuk mengambil data kendaraan dari API
  Future<List<Kendaraan>> fetchKendaraan() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/getKendaraan'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status']) {
        List<dynamic> data = responseData['data'];
        return data.map((item) => Kendaraan.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load kendaraan data');
      }
    } else {
      throw Exception('Failed to load kendaraan data');
    }
  }

  void _deleteKendaraan(String noplat) {
    // Lakukan pembaruan data setelah menghapus kendaraan
    _performAfterDelete(() {
      setState(() {
        _kendaraanFuture = _kendaraanFuture.then((kendaraans) {
          return kendaraans
              .where((kendaraan) => kendaraan.noplat != noplat)
              .toList();
        });
      });
    });
  }

  // Fungsi untuk melakukan sesuatu setelah menghapus kendaraan
  void _performAfterDelete(void Function() action) {
    // Misalnya, Anda bisa menampilkan pesan, atau melakukan sesuatu yang lain
    action();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.teal, // Sesuaikan dengan tema aplikasi Anda
      ),
      body: FutureBuilder<List<Kendaraan>>(
        future: _kendaraanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final kendaraan = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.teal, // Sesuaikan dengan tema aplikasi Anda
                      child: Text(
                        kendaraan.jenis[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      kendaraan.noplat,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      kendaraan.jenis,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteKendaraan(kendaraan.noplat);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
