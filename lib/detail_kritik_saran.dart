import 'package:flutter/material.dart';

class DetailKritikSaran extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailKritikSaran({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailKritikSaran> createState() => _DetailKritikSaranState();
}

class _DetailKritikSaranState extends State<DetailKritikSaran> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE55604),
        title: Text(
          'SiJali BPS',
          style:
              TextStyle(color: Color(0xFFEBE4D1), fontSize: screenWidth * 0.06),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                ),
                child: Text(
                  'Kritik',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.1,
                ),
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['kritik'] ?? 'Tidak ada kritik',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                ),
                child: Text(
                  'Saran',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.1,
                ),
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['saran'] ?? 'Tidak ada saran',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
