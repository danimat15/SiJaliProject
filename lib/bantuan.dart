import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Bantuan extends StatefulWidget {
  const Bantuan({super.key});

  @override
  State<Bantuan> createState() => _BantuanState();
}

class _BantuanState extends State<Bantuan> {
  String selectedValue =
      'Usulan Kasus Batas'; //Nilai default yang dipilih dalam dropdown
  List<String> dropdownItems = [
    'Usulan Kasus Batas',
    'Permasalahan Pencacahan',
    'Lainnya'
  ];

  File? image;
  Future getImageGalery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: Color(0xFFEBE4D1),
            child: Padding(
              padding: EdgeInsets.only(
                  top: mediaQueryWidth * 0.08,
                  left: mediaQueryWidth * 0.05,
                  right: mediaQueryWidth * 0.05,
                  bottom: mediaQueryWidth * 0.08),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: mediaQueryWidth * 0.05),
                        child: Text(
                          'BANTUAN',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE55604),
                          ),
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          top: mediaQueryHeight * 0.03,
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01),
                      child: Text(
                        'Jenis Bantuan',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: mediaQueryHeight * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF26577C),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: mediaQueryHeight * 0.02),
                      child: Container(
                        // width: 350,

                        height: mediaQueryHeight * 0.06,
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFFFFFFFF), // Untuk menambahkan border
                          borderRadius: BorderRadius.circular(
                              10.0), // Untuk menambahkan sudut bulat
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: dropdownItems.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            underline: Container(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mediaQueryHeight * 0.01),
                      child: Column(children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: mediaQueryHeight * 0.03,
                                left: mediaQueryWidth * 0.01,
                                bottom: mediaQueryHeight * 0.01),
                            child: Text(
                              'Deskripsi Kasus Batas',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: mediaQueryHeight * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF26577C),
                              ),
                            )),
                        Container(
                          // height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: mediaQueryHeight * 0.02),
                              TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: mediaQueryHeight * 0.03,
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01),
                      height: mediaQueryHeight * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQueryHeight * 0.02,
                          left: mediaQueryWidth * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            color: const Color(0xFF26577C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () async {
                              image != null
                                  ? SizedBox(
                                      height: mediaQueryHeight * 0.3,
                                      width: mediaQueryWidth,
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ))
                                  : await getImageGalery();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                              child: Text("Dari Galery",
                                  style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: mediaQueryHeight * 0.02,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          MaterialButton(
                            color: const Color(0xFF26577C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () async {
                              image != null
                                  ? SizedBox(
                                      height: mediaQueryHeight * 0.3,
                                      width: mediaQueryWidth,
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ))
                                  : await getImageFoto();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                              child: Text("Dari Camera",
                                  style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: mediaQueryHeight * 0.02,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
