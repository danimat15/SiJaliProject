import 'package:flutter/material.dart';
import 'usulan_kasus_batas.dart'; // Import the UsulanKasusBatas page

class PesanMasukSupervisor extends StatelessWidget {
  const PesanMasukSupervisor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Masuk Supervisor'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected item
              if (value == 'Usulan Kasus Batas') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsulanKasusBatas(),
                  ),
                );
              } else {
                print('Selected item: $value');
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Usulan Kasus Batas'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('This is the Pesan Masuk Supervisor page'),
      ),
    );
  }
}
