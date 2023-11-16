import 'package:flutter/material.dart';
import 'package:sijaliproject/home.dart';
import 'package:sijaliproject/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errormsg;
  bool? error, showprogress;
  String? username, password, role;

  var _username = TextEditingController();
  var _password = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  startLogin() async {
    String apiurl = "http://192.168.110.234:8080/sijali/login.php"; //api url

    try {
      var response = await http.post(
        Uri.parse(apiurl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'username': username!,
          'password': password!,
          // 'role': role!,
        },
      );

      if (response.statusCode == 200) {
        print("200");

        String cleanedResponse =
            response.body.replaceFirst(RegExp(r'.*?({)'), '{');
        var jsondata = json.decode(cleanedResponse);

        if (jsondata["error"]) {
          print('json error');
          setState(() {
            showprogress = false;
            error = true;
            errormsg = jsondata["message"];
            print(errormsg);

            // Show SnackBar for incorrect username or password
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Username or password is incorrect."),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
                // adjust position of SnackBar
                behavior: SnackBarBehavior.floating,
              ),
            );
          });
        } else if (jsondata["success"]) {
          print('json success');
          setState(() {
            error = false;
            showprogress = false;
          });
          role = jsondata["role"];
          if (role == 'mitra') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Home(
                  initialScreen: const Dashboard(),
                  initialTab: 0,
                ),
              ),
            );
            print('mitra');
          } else {
            if (role == 'supervisor') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Home(
                    initialScreen: const Dashboard(),
                    initialTab: 0,
                  ),
                ),
              );
              print('supervisor');
            } else {
              if (role == 'admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Home(
                      initialScreen: const Dashboard(),
                      initialTab: 0,
                    ),
                  ),
                );
                print('admin');
              }
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$role Login successful."),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
              // adjust position of SnackBar
              behavior: SnackBarBehavior.floating,
            ),
          );

          // ignore: use_build_context_synchronously
        } else {
          showprogress = false;
          error = true;
          errormsg = "Something went wrong.";
          print(errormsg);
        }
      } else {
        print("Not 200");
        setState(() {
          showprogress = false;
          error = true;
          errormsg = "Error during connecting to the server.";
          print(errormsg);
        });
      }
    } catch (e) {
      print('Error try');
      print("Error: $e");
    }
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey, // Key for accessing the Scaffold
      backgroundColor: const Color(0xFFEBE4D1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Image.asset(
                  "images/bg1-removebg-preview.png",
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.6,
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
                        color: const Color(0xFFE55604),
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Show SnackBar for incorrect username or password
                // if (error != null && error!)
                //   SizedBox(
                //     height: screenHeight * 0.02,
                //     child: Text(
                //       errormsg!,
                //       style: TextStyle(
                //         color: Colors.red,
                //       ),
                //     ),
                //   ),
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
                      controller: _username,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                  ),
                ),
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
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.09),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: const Color(0xFFE55604),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          setState(() {
                            showprogress = true;
                          });
                          await startLogin();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          child: Text("Login",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
