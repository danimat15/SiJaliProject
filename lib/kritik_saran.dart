import 'package:flutter/material.dart';

class KritikSaran extends StatefulWidget {
  const KritikSaran({super.key});

  @override
  State<KritikSaran> createState() => _DashboardState();
}

class _DashboardState extends State<KritikSaran> {
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
                  bottom: screenHeight * 0.02,
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
                  width: screenWidth * 0.5, // Adjusted image width
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
                  'KRITIK',
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
                  // top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                ),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                ),
                child: Text(
                  'SARAN',
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
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Color(0xFFFFFFFF),
                ),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(screenWidth * 0.02),
                child: Material(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () {},
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
                                  screenWidth * 0.04, // Adjusted font size
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
