import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KritikSaran extends StatefulWidget {
  const KritikSaran({super.key});

  @override
  State<KritikSaran> createState() => _DashboardState();
}

class _DashboardState extends State<KritikSaran> {
  TextEditingController kritik = TextEditingController();
  TextEditingController saran = TextEditingController();

  Future<void> insertrecord() async {
    if (kritik.text != "" || saran.text != "") {
      try {
        String uri =
            "http://${IpConfig.serverIp}/sijali/insert-kritik-saran.php";
        var res = await http.post(Uri.parse(uri),
            body: {"kritik": kritik.text, "saran": saran.text});

        // var response=jsonDecode(res.body);
        // // String jsonsDataString = response.data.toString();
        // if(response[]=="true") {
        //   print("insert success!");
        //   kritik.text = "";
        //   saran.text = "";
        // }
        // else {
        //   print("gagalll");
        // }

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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.015, // Adjusted vertical padding
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
                  maxLines: 4,
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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.015, // Adjusted vertical padding
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
                  maxLines: 4,
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
