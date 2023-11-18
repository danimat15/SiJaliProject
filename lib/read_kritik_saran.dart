import 'dart:convert';
// import 'package:coba/ui/detailKritikSaran.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/detail_kritik_saran.dart';
import 'package:http/http.dart' as http;

class SupervisorKritikSaran extends StatefulWidget {
  const SupervisorKritikSaran({super.key});

  @override
  State<SupervisorKritikSaran> createState() => _DashboardState();
}

class _DashboardState extends State<SupervisorKritikSaran> {
  Future<List<Map<String, dynamic>>> getKritikSaran() async {
    var url = 'http://${IpConfig.serverIp}/sijali/read-kritik-saran.php';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Jika respons berhasil
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      // Jika respons gagal
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFEBE4D1),
          padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.05),
          child: Column(
            children: [
              Text(
                "KRITIK DAN SARAN",
                style: TextStyle(
                  color: Color(0xFFE55604),
                  fontWeight: FontWeight.w900,
                  fontSize: screenHeight * 0.04,
                ),
              ),
              Center(
                child: Image.asset(
                  'images/kritikSaran.png',
                  width: screenWidth * 0.7,
                ),
              ),
              FutureBuilder(
                future: getKritikSaran(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> kritikSaranList =
                        snapshot.data as List<Map<String, dynamic>>;

                    return Column(
                      children: kritikSaranList.map((ks) {
                        return GestureDetector(
                          onTap: () {
                            //Ketika kotak diklik, pindah ke halaman detail
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailKritikSaran(data: ks),
                              ),
                            );
                          },
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
                                  ), // Sesuaikan dengan kebutuhan
                                  child: Column(
                                    children: [
                                      Text(
                                        'Kritik: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.02),
                                      ),
                                      Text(
                                        '${ks['kritik']}',
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        'Saran: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.02),
                                      ),
                                      Text(
                                        '${ks['saran']}',
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }
}
