import 'package:sijaliproject/sidebar.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _DashboardState();
}

class _DashboardState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        child: Container(
          // color: Color(0xFFEBE4D1),
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                ),
                child: Text(
                  'TENTANG APLIKASI',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE55604),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.03,
                ),
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                // height: screenHeight *
                //     0.8, // Adjusted container height to fill the screen height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                ),
                child: SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: screenWidth * 0.02,
                        right: screenWidth * 0.02,
                        bottom: screenHeight * 0.05),
                    child: Text(
                      "Aplikasi ini adalah aplikasi untuk membantu mitra dalam menentukan kode KBLI untuk UMKM yang termasuk dalam kasus batas. Aplikasi ini dikembangkan oleh mahasiswa Politeknik Statistika STIS, Program Studi Komputasi Statistik dengan Peminatan Sains Data kelas 3SD2 angkatan 63.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
