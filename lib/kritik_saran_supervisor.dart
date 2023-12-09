import 'dart:convert';
// import 'package:coba/ui/detailKritikSaran.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/detail_kritik_saran.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaliproject/login.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sijaliproject/searching_offline.dart';
import 'dart:io';

class SupervisorKritikSaran extends StatefulWidget {
  const SupervisorKritikSaran({super.key});

  @override
  State<SupervisorKritikSaran> createState() => _DashboardState();
}

class _DashboardState extends State<SupervisorKritikSaran> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOffline = false;

  Future<List<Map<String, dynamic>>> getKritikSaran() async {
    try {
      var url = 'https://${IpConfig.serverIp}/read-kritik-saran.php';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Jika respons berhasil
        List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        // Jika respons gagal
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle the error when there is no internet connection or any other issues
      print('Error fetching kritik saran: $e');
      // You can log the error, show a message to the user, or handle it based on your requirements
      return [];
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
          builder: (BuildContext context) => LoginScreen(),
        ),
        (route) => false,
      );
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
    getPref();
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
      body: SingleChildScrollView(
        child: Container(
          // color: Color(0xFFEBE4D1),
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
                            height: screenHeight * 0.3,
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFFFFFF),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                    left: screenWidth * 0.03,
                                    right: screenWidth * 0.03,
                                    bottom: screenHeight * 0.02,
                                  ), // Sesuaikan dengan kebutuhan
                                  child: Column(
                                    children: [
                                      Text(
                                        'id: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.02),
                                      ),
                                      Text(
                                        '${ks['id_user']}',
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
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
                                      SizedBox(height: screenHeight * 0.02),
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
                                  // child: Column(
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         Text(
                                  //           'Kritik: ',
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: screenHeight * 0.02,
                                  //           ),
                                  //         ),
                                  //         Expanded(
                                  //           child: Text(
                                  //             '${ks['kritik']}',
                                  //             textAlign: TextAlign.left,
                                  //             maxLines: 3,
                                  //             overflow: TextOverflow.ellipsis,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(height: screenHeight * 0.01),
                                  //     Row(
                                  //       children: [
                                  //         Text(
                                  //           'Saran: ',
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: screenHeight * 0.02,
                                  //           ),
                                  //         ),
                                  //         Expanded(
                                  //           child: Text(
                                  //             '${ks['saran']}',
                                  //             textAlign: TextAlign.left,
                                  //             maxLines: 3,
                                  //             overflow: TextOverflow.ellipsis,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
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
