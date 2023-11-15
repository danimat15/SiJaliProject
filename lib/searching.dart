import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomContainer extends StatelessWidget {
  final List<Map<String, dynamic>> filteredData;
  final int index;

  const CustomContainer(
      {Key? key, required this.filteredData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    // Your existing code here
    return Container(
      margin: EdgeInsets.only(bottom: mediaQueryHeight * 0.02),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: mediaQueryHeight * 0.15,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: Colors.grey,
              ),
              child: Center(
                child: Text(
                  filteredData[index]['kd_kbli'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQueryHeight * 0.03,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: mediaQueryHeight * 0.15,
            width: mediaQueryWidth * 0.66,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(0xFFFFFFFF),
            ),
            child: Center(
                child: Padding(
              padding: EdgeInsets.only(
                  top: mediaQueryHeight * 0.02,
                  left: mediaQueryWidth * 0.02,
                  right: mediaQueryWidth * 0.02,
                  bottom: mediaQueryHeight * 0.02),
              child: Text(
                filteredData[index]['uraian_kegiatan'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: mediaQueryHeight * 0.02,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  TextEditingController searchController = TextEditingController();
  Future<List<Map<String, dynamic>>>? futureData;

  @override
  void initState() {
    super.initState();
    // Initialize futureData here
    futureData = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.0.10/sijali/searching-kasus-batas.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, dynamic>> filterData(
      List<Map<String, dynamic>> data, String query) {
    return data
        .where((map) =>
            map['uraian_kegiatan'].toString().contains(query) ||
            map['kd_kbli'].toString().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4D1),
      body: Padding(
        padding: EdgeInsets.only(
            left: mediaQueryWidht * 0.05,
            top: mediaQueryHeight * 0.05,
            right: mediaQueryWidht * 0.05,
            bottom: mediaQueryHeight * 0.01),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              SizedBox(height: mediaQueryHeight * 0.02),
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
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          setState(() {
                            futureData = fetchData(); // Reset futureData
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: mediaQueryHeight * 0.02,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: mediaQueryWidht * 0.02),
                    child: Icon(Icons.search,
                        color: Color(0xFF26577C),
                        size: mediaQueryHeight * 0.04),
                  ),
                ],
              ),
              SizedBox(height: mediaQueryHeight * 0.02),
              // Wrap ListView.builder with a Container for a fixed height
              FutureBuilder<List<Map<String, dynamic>>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> filteredData =
                        filterData(snapshot.data!, searchController.text);
                    return Container(
                      margin: EdgeInsets.only(top: mediaQueryHeight * 0.04),
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return CustomContainer(
                            filteredData: filteredData,
                            index: index,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              // ...
            ],
          ),
        ),
      ),
    );
  }
}
