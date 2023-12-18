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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
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

            return Container(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.009),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '${detailPesan['tanggal']} pukul ${detailPesan['waktu']}',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE55604),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Permasalahan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '\n${detailPesan['deskripsi']}',
                    style: TextStyle(fontSize: screenHeight * 0.02),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE55604),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Balasan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '${detailPesan['balasan']}',
                    style: TextStyle(fontSize: screenHeight * 0.02),
                    textAlign: TextAlign.justify,
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
