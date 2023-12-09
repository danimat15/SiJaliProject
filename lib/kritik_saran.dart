import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaliproject/login.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sijaliproject/searching_offline.dart';
import 'dart:io';

class KritikSaran extends StatefulWidget {
  const KritikSaran({super.key});

  @override
  State<KritikSaran> createState() => _DashboardState();
}

class _DashboardState extends State<KritikSaran> {
  TextEditingController kritik = TextEditingController();
  TextEditingController saran = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOffline = false;

  Future<void> insertrecord() async {
    if (kritik.text != "" || saran.text != "") {
      try {
        String uri = "https://${IpConfig.serverIp}/insert-kritik-saran.php";
        var res = await http.post(Uri.parse(uri), body: {
          "kritik": kritik.text,
          "saran": saran.text,
          "id_user": id.toString()
        });

        if (res.headers['content-type']?.contains('application/json') ??
            false) {
          print("Non-JSON response: ${res.body}");
          // Handle non-JSON response here, e.g., display an error message.
        } else {
          var response = jsonDecode(res.body);
          if (response["success"] == "true") {
            print("insert success!");
            kritik.text = "";
            saran.text = "";
            showSuccessNotification();
          } else {
            print("gagal");
            showErrorNotification();
          }
        }
      } catch (e) {
        print(e);
        showErrorNotification();
      }
    } else {
      print("tidak bole kosong!!!");
      showEmptyResponseError();
    }
  }

  void showSuccessNotification() {
    final snackBar = SnackBar(
      content: Text('Kritik dan saran berhasil dikirimkan.'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Kritik dan saran gagal dikirimkan. Silakan coba kembali'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the mediaQuery
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmptyResponseError() {
    final snackBar = SnackBar(
      content: Text('Isian tidak boleh kosong. Silakan isi terlebih dahulu.'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int id = 0;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin == true) {
      setState(() {
        id = pref.getInt("id") ?? 0;
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
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFEBE4D1),
          padding: EdgeInsets.all(screenWidth * 0.02), // Adjusted padding
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                ),
                child: Text(
                  'KRITIK DAN SARAN',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.08, // Adjusted font size
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE55604),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('images/kritikSaran.png'),
                  width: screenWidth * 0.7, // Adjusted image width
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                ),
                child: Text(
                  'Kritik',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.06, // Adjusted font size
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.02,
                  bottom: screenHeight * 0.01,
                  // Adjusted vertical padding
                ),
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                ),
                child: TextField(
                  controller: kritik,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukkan kritik Anda disini',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: screenWidth * 0.05,
                ),
                child: Text(
                  'Saran',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.06, // Adjusted font size
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.02,
                  bottom: screenHeight * 0.01,
                  // Adjusted vertical padding
                ),
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                ),
                child: TextField(
                  controller: saran,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukkan saran Anda disini',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.02, bottom: screenHeight * 0.05),
                child: Material(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () {
                      insertrecord();
                    },
                    child: Container(
                      width: screenWidth * 0.85, // Adjusted button width
                      height: screenHeight * 0.08, // Adjusted button height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        color: Color(0xFFE55604),
                      ),
                      child: InkWell(
                        splashColor: Colors.grey,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        child: Center(
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  screenWidth * 0.06, // Adjusted font size
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
