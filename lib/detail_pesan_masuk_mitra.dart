import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';

class DetailPesanMitra extends StatelessWidget {
  final String idPesan;
  const DetailPesanMitra({Key? key, required this.idPesan}) : super(key: key);

  Future<Map<String, dynamic>> _getDetailPesan() async {
    final response = await http.get(Uri.parse(
        'https://${IpConfig.serverIp}/detail_pesan_mitra.php?id=$idPesan'));

    if (response.statusCode == 200) {
      Map<String, dynamic> detailPesan = json.decode(response.body);
      return detailPesan;
    } else {
      throw Exception('Failed to load detail pesan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pesan',
          style:
              TextStyle(color: Colors.white), // Ganti warna teks menjadi putih
        ),
        backgroundColor: Color(0xFFE55604), // Ganti warna AppBar
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getDetailPesan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("Detail pesan tidak tersedia"),
            );
          } else {
            Map<String, dynamic> detailPesan = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Permasalahan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\n${detailPesan['deskripsi']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      'Balasan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${detailPesan['balasan']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  // Tampilkan data lain sesuai kebutuhan
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
