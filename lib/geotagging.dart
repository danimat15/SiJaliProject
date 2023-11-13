import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Geotagging extends StatefulWidget {
  const Geotagging({super.key});

  @override
  State<Geotagging> createState() => _GeotaggingState();
}

class _GeotaggingState extends State<Geotagging> {
  TextEditingController controllerLongitude = TextEditingController();
  TextEditingController controllerLatitude = TextEditingController();

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  void addData() async {
    var url = Uri.parse("http://192.168.110.58/sijali/insert-geotagging.php");

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['jenis_usaha'] = selectedValue;
      request.fields['longitude'] = controllerLongitude.text;
      request.fields['latitude'] = controllerLatitude.text;

      var response = await request.send();

      // Check if the data insertion was successful
      if (response.statusCode == 200) {
        // Show success notification
        showSuccessNotification();
        print(response.statusCode);

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
      content: Text('Berhasil melakukan geotagging'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Gagal melakukan geotagging'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the screen
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void clearForm() {
    // Clear the form fields or reset any necessary state variables
    selectedValue = 'Pedagang 1';
    controllerLongitude.clear();
    controllerLatitude.clear();
    setState(() {});
  }

  String selectedValue =
      'Pedagang 1'; //Nilai default yang dipilih dalam dropdown
  List<String> dropdownItems = ['Pedagang 1', 'Pedagang 2', 'Pedagang 3'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            color: Color(0xFFEBE4D1),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          bottom: screenHeight * 0.02),
                      child: Text(
                        'GEOTAGGING',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: screenHeight * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE55604),
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: screenWidth * 0.02,
                        bottom: screenHeight * 0.02),
                    child: Text(
                      'JENIS USAHA',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF26577C),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.85,
                    height: screenWidth * 0.13,
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFFFFFFF), // Untuk menambahkan border
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
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                      width: screenWidth * 0.85,
                      child: MaterialButton(
                        color: const Color(0xFF26577C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          _currentLocation = await _getCurrentLocation();
                          controllerLongitude.text =
                              _currentLocation!.longitude.toString();
                          controllerLatitude.text =
                              _currentLocation!.latitude.toString();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child: Text("Ambil Lokasi",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: screenHeight * 0.025,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: screenWidth * 0.02,
                        bottom: screenHeight * 0.02),
                    child: Text(
                      'LONGITUDE',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF26577C),
                      ),
                    ),
                  ),
                  Container(
                      width: screenWidth * 0.85,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          controller: controllerLongitude,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: screenWidth * 0.02,
                        bottom: screenHeight * 0.02),
                    child: Text(
                      'LATITUDE',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF26577C),
                      ),
                    ),
                  ),
                  Container(
                      width: screenWidth * 0.85,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          controller: controllerLatitude,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  SizedBox(height: screenWidth * 0.05),
                  SizedBox(
                      width: screenWidth * 0.85,
                      child: MaterialButton(
                        color: const Color(0xFFE55604),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          addData();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child: Text("Submit",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )),
                ],
              ),
            )));
  }
}
