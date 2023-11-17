import 'package:flutter/material.dart';

class DetailSearching extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailSearching({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    // Implementasi halaman detail dengan menggunakan data
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4D1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF26577C),
        title: Text(
          'SiJali BPS',
          style: TextStyle(
              color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.06),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: mediaQueryHeight * 0.01,
                left: mediaQueryWidth * 0.06,
                right: mediaQueryWidth * 0.06,
                bottom: mediaQueryHeight * 0.05),
            child: Column(
              children: [
                Text(
                  'Jenis Usaha: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['jenis_usaha']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.02,
                    color: Color(0xFF26577C),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.05),
                Text(
                  'Uraian Kegiatan: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['uraian_kegiatan']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.02,
                    color: Color(0xFF26577C),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.05),
                Text(
                  'Kode Kategori: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['kd_kategori']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    color: Color(0xFF26577C),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.05),
                Text(
                  'Rincian Kategori: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['rincian_kategori']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.02,
                    color: Color(0xFF26577C),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.05),
                Text(
                  'Kode KBLI: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['kd_kbli']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    color: Color(0xFF26577C),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.05),
                Text(
                  'Deskripsi KBLI: ',
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26577C),
                  ),
                ),
                Text(
                  '${data['deskripsi_kbli']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.02,
                    color: Color(0xFF26577C),
                  ),
                ),

                // Tambahkan widget lain sesuai kebutuhan
              ],
            ),
          ),
        ),
      ),
    );
  }
}
