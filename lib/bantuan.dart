import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Bantuan extends StatefulWidget {
  const Bantuan({super.key});

  @override
  State<Bantuan> createState() => _BantuanState();
}

class _BantuanState extends State<Bantuan> {
  TextEditingController controllerDesc = TextEditingController();

  void addData() async {
    var url = Uri.parse("http://192.168.0.10/sijali/insert-bantuan.php");

    try {
      var response = await http.post(url, body: {
        "jenis_bantuan": selectedValue,
        "deskripsi": controllerDesc.text,
      });

      // Check if the data insertion was successful
      if (response.statusCode == 200) {
        // Show success notification
        showSuccessNotification();

        // Clear the form or perform any other actions as needed
        clearForm();
      } else {
        // Show error notification
        showErrorNotification();
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      showErrorNotification();
    }
  }

  void showSuccessNotification() {
    final snackBar = SnackBar(
      content: Text('Data added successfully!'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Failed to add data'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the screen
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void clearForm() {
    // Clear the form fields or reset any necessary state variables
    controllerDesc.clear();
    selectedValue = 'Usulan Kasus Batas';
    image = null;
    setState(() {});
  }

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
                                controller: controllerDesc,
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
                    Padding(
                      padding: EdgeInsets.only(top: mediaQueryHeight * 0.02),
                      child: SizedBox(
                          width: mediaQueryWidth * 0.85,
                          child: MaterialButton(
                            color: const Color(0xFFE55604),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              addData();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(mediaQueryHeight * 0.02),
                              child: Text("Submit",
                                  style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: mediaQueryWidth * 0.06,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )));
  }
}
