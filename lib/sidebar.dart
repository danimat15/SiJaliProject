import 'package:flutter/material.dart';
import 'package:sijaliproject/about_app.dart';
import 'package:sijaliproject/login.dart';
import 'package:sijaliproject/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pesan_masuk_mitra.dart'; // Import the new files
import 'pesan_masuk_supervisor.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String username = "";
  int id = 0;
  String role = "";

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin == true) {
      setState(() {
        username = pref.getString("username")!;
        role = pref.getString("role")!;
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

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove("username");
      preferences.remove("id");
      preferences.remove("role");
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil Logout"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Updated method to handle "Pesan Masuk" tap
  handlePesanMasukTap() {
    if (role == 'mitra') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(
            initialScreen: PesanMasukMitra(),
            initialTab: 5,
          ),
        ),
      );
    } else if (role == 'supervisor') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(
            initialScreen: PesanMasukSupervisor(),
            initialTab: 5,
          ),
        ),
      );
    }
    // Add additional conditions if needed for other roles
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color(0xFFE55604),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username,
                style: TextStyle(
                    color: Color(0xFF26577C),
                    fontSize: mediaQueryWidth * 0.05)),
            accountEmail: Text(role,
                style: TextStyle(
                    color: Color(0xFF26577C),
                    fontSize: mediaQueryWidth * 0.04)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                id.toString(),
                style: TextStyle(
                    color: Color(0xFF26577C), fontSize: mediaQueryWidth * 0.05),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFEBE4D1),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail_outline,
              color: Color(0xFFEBE4D1),
              size: mediaQueryWidth * 0.07,
            ),
            title: Text(
              'Pesan Masuk',
              style: TextStyle(
                  color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.04),
            ),
            onTap: handlePesanMasukTap,
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Color(0xFFEBE4D1),
              size: mediaQueryWidth * 0.07,
            ),
            title: Text(
              'Tentang Aplikasi',
              style: TextStyle(
                  color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.04),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Home(
                    initialScreen: const AboutApp(),
                    initialTab: 5,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: Color(0xFFEBE4D1), size: mediaQueryWidth * 0.07),
            title: Text('Logout',
                style: TextStyle(
                    color: Color(0xFFEBE4D1),
                    fontSize: mediaQueryWidth * 0.04)),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
