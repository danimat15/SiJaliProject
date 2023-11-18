import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sijaliproject/api_config.dart';

class DetailSearching extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailSearching({Key? key, required this.data}) : super(key: key);

  Future<void> deleteData(BuildContext context) async {
    bool confirmed = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Kasus Batas',
              style: TextStyle(color: Color(0xFF26577C))),
          content: Text('Apakah anda yakin untuk menghapus kasus batas ini?',
              style: TextStyle(color: Color(0xFF26577C))),
          backgroundColor: Color(0xFFEBE4D1),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                confirmed = true;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              icon: Icon(Icons.check),
              label: SizedBox.shrink(), // Hide the label
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change the background color to green
              ),
              icon: Icon(Icons.clear,
                  color: Colors.white), // Change the color to white
              label: SizedBox.shrink(), // Hide the label
            ),
          ],
        );
      },
    );

    if (confirmed) {
      final response = await http.post(
        Uri.parse('http://${IpConfig.serverIp}/sijali/delete-kasus-batas.php'),
        body: {
          'id': data['id'],
        },
      );

      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text('Kasus batas berhasil dihapus'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          content: Text('Kasus batas gagal dihapus'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

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
                // UNTUK ROLE SUPERVISOR
                Padding(
                  padding: EdgeInsets.only(
                    top: mediaQueryHeight * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: const Color(0xFF26577C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {},
                        child: Padding(
                          padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                          child: Text("Update",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: mediaQueryHeight * 0.02,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      MaterialButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async {
                            await deleteData(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                            child: Text("Delete",
                                style: TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: mediaQueryHeight * 0.02,
                                  fontWeight: FontWeight.w500,
                                )),
                          )),
                    ],
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
