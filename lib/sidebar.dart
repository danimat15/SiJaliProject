import 'package:flutter/material.dart';
import 'package:sijaliproject/get_started.dart';
import 'package:sijaliproject/about_app.dart';
import 'package:sijaliproject/home.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color(0xFFE55604),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Nama Pengguna',
                style: TextStyle(
                    color: Color(0xFF26577C),
                    fontSize: mediaQueryWidth * 0.05)),
            accountEmail: Text('Email',
                style: TextStyle(
                    color: Color(0xFF26577C),
                    fontSize: mediaQueryWidth * 0.04)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('N'),
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
            onTap: () {},
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Welcome()));
            },
          ),
        ],
      ),
    );
  }
}
