import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:http/http.dart' as http;

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _DashboardState();
}

class _DashboardState extends State<Notifikasi> {
  Future<List<Map<String, dynamic>>> getNotifikasi() async {
    var url = 'https://${IpConfig.serverIp}/read-notifikasi.php';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
      body: Column(
        children: [
          Container(
            color: Color(0xFFEBE4D1),
            padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
            ),
            child: Text(
              "NOTIFIKASI",
              style: TextStyle(
                color: Color(0xFFE55604),
                fontWeight: FontWeight.w900,
                fontSize: screenHeight * 0.04,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'images/notifikasi.png',
              width: screenWidth * 0.5,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xFFEBE4D1),
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                child: FutureBuilder(
                  future: getNotifikasi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> notifikasiList =
                          snapshot.data as List<Map<String, dynamic>>;

                      // notifikasiList
                      //     .sort((a, b) => b['Waktu'].compareTo(a['Waktu']));
                      return Column(
                        children: notifikasiList.map((notif) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: screenHeight * 0.01,
                                left: screenWidth * 0.02,
                                right: screenWidth * 0.02,
                              ),
                              height: screenHeight * 0.15,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: screenWidth * 0.02,
                                      right: screenWidth * 0.02,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Kasus batas telah ${notif['Status']}!',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.02,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              'Kode KBLI: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.02,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${notif['Kode KBLI']}',
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              'Jenis Usaha: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.02,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${notif['Jenis Usaha']}',
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              'Tanggal: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.02,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${notif['Tanggal']} pukul ${notif['Waktu']}',
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
