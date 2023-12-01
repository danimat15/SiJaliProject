import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/update_kasus_batas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaliproject/login.dart';

class DetailSearching extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailSearching({Key? key, required this.data}) : super(key: key);

  @override
  _DetailSearchingState createState() => _DetailSearchingState();
}

class _DetailSearchingState extends State<DetailSearching> {
  late bool confirmed;

  Future<void> deleteData(BuildContext context) async {
    confirmed = false;

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
                setState(() {
                  confirmed = true;
                });
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
        Uri.parse('https://${IpConfig.serverIp}/delete-kasus-batas.php'),
        body: {
          'id': widget.data['id'],
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

  int id = 0;
  String role = "";

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin == true) {
      setState(() {
        role = pref.getString("role")!;
        id = pref.getInt("id") ??
            0; // Provide a default value (e.g., 0) if id is null
      });
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
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
                  '${widget.data['jenis_usaha']}',
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
                  '${widget.data['uraian_kegiatan']}',
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
                  '${widget.data['kd_kategori']}',
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
                  '${widget.data['rincian_kategori']}',
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
                  '${widget.data['kd_kbli']}',
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
                  '${widget.data['deskripsi_kbli']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: mediaQueryHeight * 0.02,
                    color: Color(0xFF26577C),
                  ),
                ),
                // UNTUK ROLE SUPERVISOR
                if (role == "supervisor")
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
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateKasusBatas(data: widget.data),
                              ),
                            );
                          },
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
