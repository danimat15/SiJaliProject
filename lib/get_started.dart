import 'package:flutter/material.dart';
import 'package:sijaliproject/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaliproject/dashboard.dart';
import 'package:sijaliproject/home.dart';
import 'package:sijaliproject/home_supervisor.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");

    if (islogin != null && islogin) {
      String loggedInRole = pref.getString("role") ?? '';

      if (loggedInRole == 'mitra') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => Home(
              initialScreen: const Dashboard(),
              initialTab: 0,
            ),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => HomeSupervisor(
              initialScreen: const Dashboard(),
              initialTab: 0,
            ),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFEBE4D1),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: screenWidth * 0.3), // Adjusted horizontal padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Adjusted spacing between top and text
                Text(
                  "Welcome To",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: screenWidth * 0.1),
                ),
                Text(
                  "SiJali",
                  style: TextStyle(
                      color: Color(0xFFE55604),
                      fontWeight: FontWeight.w900,
                      fontSize: screenWidth * 0.1),
                ),
                SizedBox(
                    height: screenHeight *
                        0.01), // Adjusted spacing between text and image

                Image(
                  image: AssetImage('images/welcome.png'),
                  width: screenWidth * 0.7, // Sesuaikan dengan kebutuhan
                  height: screenHeight *
                      0.5, // Tambahkan height untuk mengatur tinggi gambar
                  fit: BoxFit.contain, // Sesuaikan fit sesuai kebutuhan
                ),
                SizedBox(
                    height: screenHeight *
                        0.01), // Adjusted spacing between image and text

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal:
                          screenWidth * 0.05), // Adjusted horizontal margin
                  color: Colors.transparent,
                  child: Text(
                    "SiJali adalah aplikasi yang membantu mitra BPS dalam menemukan kategori KBLI untuk usaha-usaha yang termasuk dalam kasus batas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.04), // Adjusted font size
                  ),
                ),
                SizedBox(
                    height: screenHeight *
                        0.03), // Adjusted spacing between text and button

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: Container(
                    width: screenWidth * 0.5, // Adjusted button width
                    height: screenHeight * 0.06, // Adjusted button height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          screenHeight * 0.03), // Adjusted border radius
                      color: Color(0xFFE55604),
                    ),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.05), // Adjusted font size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
