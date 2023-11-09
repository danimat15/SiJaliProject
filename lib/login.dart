import 'package:flutter/material.dart';
import 'package:sijaliproject/home.dart';
import 'package:sijaliproject/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4D1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Image.asset(
                "images/bg1-removebg-preview.png",
                height: screenHeight * 0.2,
                width: screenWidth * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.025,
                ),
                child: Text("Login",
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.w900,
                      // fontFamily: 'Poppins',
                      color: const Color(0xFFE55604),
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  )),
              SizedBox(height: screenHeight * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.09),
              // Align(alignment: Alignment.centerLeft,
              // child: InkWell(
              //   onTap: () {

              //   },

              // ),
              // ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    color: const Color(0xFFE55604),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home(
                                    initialScreen: const Dashboard(),
                                    initialTab: 0,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Login",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
