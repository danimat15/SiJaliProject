import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sijaliproject/searching_offline.dart';
import 'dart:io';

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _DashboardState();
}

class _DashboardState extends State<Notifikasi> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOffline = false;

  Future<List<Map<String, dynamic>>> getNotifikasi() async {
    try {
      var url = 'https://${IpConfig.serverIp}/read-notifikasi.php';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle the error when there is no internet connection
      print('Error fetching notifikasi: $e');
      // You can return an empty list or handle it based on your requirements
      return [];
    }
  }

  void showOfflineModePopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // Make it not dismissible
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tidak Ada Koneksi Internet"),
          content: Text(
              "Anda dalam mode offline. Silakan aktifkan koneksi internet untuk melanjutkan."),
          actions: [
            TextButton(
              onPressed: () async {
                // Handle action when "Kembali" is pressed
                // Add your offline mode logic here
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text("Oke"),
            ),
            TextButton(
              onPressed: () async {
                // Handle action when "Mode Offline" is pressed
                // Add your offline mode logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchingOffline(),
                  ),
                ).then((_) {
                  // Check internet when returning from SearchingOffline
                  checkInternetOnReturn();
                }); // Close the dialog
              },
              child: Text("Mode Offline"),
            ),
          ],
        );
      },
    );
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  showDialogBox() => showOfflineModePopup();

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> checkInternetOnReturn() async {
    bool isConnected = await checkInternet();
    if (!isConnected) {
      setState(() {
        isOffline = true;
      });
      showOfflineModePopup();
    } else {
      setState(() {
        isOffline = false;
      });
    }
  }

  @override
  void initState() {
    getConnectivity();
    checkInternetOnReturn();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
                        children: notifikasiList.isEmpty
                            ? [
                                Container(
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Tidak ada pembaruan kasus batas',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.02,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            : notifikasiList.map((notif) {
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
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.01,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight * 0.02,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.01),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Kode KBLI: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight * 0.02,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${notif['Kode KBLI']}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.01),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Jenis Usaha: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight * 0.02,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${notif['Jenis Usaha']}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.01),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Tanggal: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenHeight * 0.02,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${notif['Tanggal']} pukul ${notif['Waktu']}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
