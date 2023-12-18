import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';
import 'detail_pesan_masuk_mitra.dart'; // Import halaman detail

class PesanMasukMitra extends StatelessWidget {
  final int userId;
  const PesanMasukMitra({Key? key, required this.userId}) : super(key: key);

  Future<List<dynamic>> _getPesan() async {
    final response = await http.get(Uri.parse(
        'https://${IpConfig.serverIp}/pesan_masuk_mitra.php?id=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> pesan = json.decode(response.body);
      return pesan;
    } else {
      throw Exception('Failed to load pesan');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
      body: FutureBuilder<List<dynamic>>(
        future: _getPesan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var pesan = snapshot.data![index];
                return Container(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    left: screenWidth * 0.03,
                    right: screenWidth * 0.05,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          // Navigasi ke halaman detail_pesan_masuk_mitra.dart dengan mengirimkan id pesan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPesanMitra(
                                idPesan: pesan['id'],
                                // Tambahkan parameter lain jika diperlukan
                              ),
                            ),
                          );
                        },
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('images/pesan.png'),
                        ),
                        title: Text('Kode Permasalahan : #3100-${pesan['id']}'),
                        subtitle: Text(
                          '${pesan['deskripsi']}',
                          maxLines: 3, // Maksimal 3 baris
                          overflow: TextOverflow
                              .ellipsis, // Tampilkan ellipsis jika melebihi 3 baris
                        ),
                        trailing: Text('${pesan['timestamp']}'),
                      ),
                      Divider(
                        color: Color(0xFFE55604),
                        thickness: 2,
                      ), // Tambahkan Divider setelah setiap ListTile
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
