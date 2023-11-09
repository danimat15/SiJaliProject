import 'package:flutter/material.dart';

class Searching extends StatefulWidget {
  const Searching({super.key});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4D1),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
        // padding: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'PENCARIAN KASUS BATAS',
                style: TextStyle(
                  fontSize: mediaQueryHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26577C),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Warna bayangan
                          spreadRadius: 2, // Menyebar bayangan
                          blurRadius: 5, // Tingkat kabur bayangan
                          offset:
                              const Offset(3, 3), // Perpindahan bayangan (x, y)
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        //suffixIcon: const Icon(Icons.clear, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Icon(Icons.search,
                      color: Color(0xFF26577C), size: 40),
                ),
              ],
            ),
            Column(
              // mainAxisSize: MainAxisSize
              //     .min, // MainAxisSize.min agar Column hanya sebesar widget di dalamnya
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: Colors.grey,
                          )),
                    ),
                    Container(
                        height: 100,
                        width: 260,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color(0xFFFFFFFF),
                        ))
                  ]),
                ),
              ],
            ),
          ]),
          // menampilkan hasil pencarian dalam bentuk box
        ),
      ),
    );
  }
}
