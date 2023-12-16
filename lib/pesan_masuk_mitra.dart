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
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _getPesan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var pesan = snapshot.data![index];
                return ListTile(
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
                  // leading: Icon(Icon.mail_outline),
                  leading: const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://${IpConfig.serverIp}/email.png'),
                  ),
                  title: Text('Kode Permasalahan : #3100-${pesan['id']}'),
                  subtitle: Text(
                    '${pesan['deskripsi']}',
                    maxLines: 3, // Maksimal 3 baris
                    overflow: TextOverflow
                        .ellipsis, // Tampilkan ellipsis jika melebihi 3 baris
                  ),
                  trailing: Text('${pesan['timestamp']}'),
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
