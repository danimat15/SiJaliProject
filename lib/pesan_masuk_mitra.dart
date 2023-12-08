import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PesanMasukMitra extends StatelessWidget {
  const PesanMasukMitra({super.key});

  Future<List<dynamic>> _getPesan() async {
    final response = await http
        .get(Uri.parse('https://sijali.gaweyan.online/pesan_masuk_mitra.php'));

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
                  leading: const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/50'),
                  ),
                  title: Text('User ${pesan['id_user']}'),
                  subtitle: Text('${pesan['balasan']}'),
                  trailing: Text('${pesan['timestamp']}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
