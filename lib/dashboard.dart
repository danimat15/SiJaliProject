import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/word_cloud/word_cloud.dart';
import 'dart:io';
import 'package:sijaliproject/searching_offline.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOffline = false;

  Future<List<Map<String, dynamic>>> getKeyword() async {
    try {
      var url = 'https://${IpConfig.serverIp}/read-keyword.php';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // Add this line for debugging
        return data.cast<Map<String, dynamic>>();
      } else {
        // If the response status code is not 200, return an empty list
        return [];
      }
    } catch (e) {
      // If an exception occurs, return an empty list
      print('Error fetching permasalahan: $e');
      return [];
    }
  }

  void showOfflineModePopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // Make it not dismissible
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tidak Ada Koneksi Internet"),
          content: Text(
              "Anda dalam mode offline. Silakan aktifkan koneksi internet untuk melanjutkan."),
          actions: [
            TextButton(
              onPressed: () async {
                // Handle action when "Kembali" is pressed
                // Add your offline mode logic here
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text("Oke"),
            ),
            TextButton(
              onPressed: () async {
                // Handle action when "Mode Offline" is pressed
                // Add your offline mode logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchingOffline(),
                  ),
                ).then((_) {
                  // Check internet when returning from SearchingOffline
                  checkInternetOnReturn();
                }); // Close the dialog
              },
              child: Text("Mode Offline"),
            ),
          ],
        );
      },
    );
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  showDialogBox() => showOfflineModePopup();

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> checkInternetOnReturn() async {
    bool isConnected = await checkInternet();
    if (!isConnected) {
      setState(() {
        isOffline = true;
      });
      showOfflineModePopup();
    } else {
      setState(() {
        isOffline = false;
      });
    }
  }

  Future<int> getAllKasusBatas() async {
    try {
      final response = await http.get(
        Uri.parse('https://${IpConfig.serverIp}/get-jumlah-kasus-batas.php'),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body);

        // Check if dataList is not empty
        if (dataList.isNotEmpty) {
          // Assuming the response is a list with a Map inside
          Map<String, dynamic> data = dataList[0];
          // Assuming the key in the map is 'added_cases_count'
          return data['all_cases_count'];
        } else {
          // If the list is empty, return 0
          return 0;
        }
      } else {
        // If the response status code is not 200, return 0
        return 0;
      }
    } catch (e) {
      // If an exception occurs, return 0
      print('Error fetching all cases: $e');
      return 0;
    }
  }

  Future<int> getAddedForCurrentMonth() async {
    try {
      DateTime now = DateTime.now();
      int currentMonth = now.month;

      print(currentMonth);
      final response = await http.get(
        Uri.parse(
            'https://${IpConfig.serverIp}/get-jumlah-kasus-batas-ditambahkan.php?month=$currentMonth'),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body);

        // Check if dataList is not empty
        if (dataList.isNotEmpty) {
          // Assuming the response is a list with a Map inside
          Map<String, dynamic> data = dataList[0];
          // Assuming the key in the map is 'added_cases_count'
          return data['added_cases_count'];
        } else {
          // If the list is empty, return 0
          return 0;
        }
      } else {
        // If the response status code is not 200, return 0
        return 0;
      }
    } catch (e) {
      // If an exception occurs, return 0
      print('Error fetching added cases: $e');
      return 0;
    }
  }

  Future<int> getUpdatedForCurrentMonth() async {
    try {
      DateTime now = DateTime.now();
      int currentMonth = now.month;

      var url =
          'https://${IpConfig.serverIp}/get-jumlah-kasus-batas-diperbarui.php?month=$currentMonth';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body);

        // Check if dataList is not empty
        if (dataList.isNotEmpty) {
          // Assuming the response is a list with a Map inside
          Map<String, dynamic> data = dataList[0];
          // Assuming the key in the map is 'updated_cases_count'
          return data['updated_cases_count'];
        } else {
          // If the list is empty, return 0
          return 0;
        }
      } else {
        // If the response status code is not 200, return 0
        return 0;
      }
    } catch (e) {
      // If an exception occurs, return 0
      print('Error fetching updated cases: $e');
      return 0;
    }
  }

  @override
  void initState() {
    getConnectivity();
    checkInternetOnReturn();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: mediaQueryHeight * 0.01),
          color: const Color(0xFFEBE4D1),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    top: mediaQueryHeight * 0.01,
                    left: mediaQueryWidth * 0.03,
                  ),
                  child: Text(
                    'WORLDCLOUD JENIS USAHA',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: mediaQueryWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE55604),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: mediaQueryHeight * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFFFFFF),
                    // add shadow effects
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: getKeyword(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text('No keywords found'),
                        );
                      } else {
                        List<Map> keywordData = snapshot.data!;

                        // Use keywordData to update your UI or perform other tasks
                        return WordCloud(keywordData: keywordData);
                        // return MyHomePage(title: 'Word Cloud');
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    top: mediaQueryHeight * 0.04,
                    left: mediaQueryWidth * 0.03,
                  ),
                  child: Text(
                    'RINGKASAN BULAN INI',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: mediaQueryWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE55604),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: mediaQueryHeight * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: const Color(0xFFFFFFFF),
                    // add shadow effects
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 1,
                    //     blurRadius: 5,
                    //     offset: const Offset(0, 3),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Kasus Batas',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: mediaQueryWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE55604),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                                top: mediaQueryHeight * 0.02,
                                bottom: mediaQueryHeight * 0.02,
                                right: mediaQueryWidth * 0.03,
                              ),
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.3,
                              ),
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder<int>(
                                future: getAllKasusBatas(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    int allCases =
                                        snapshot.data ?? 0; // Default to 0
                                    return Text(
                                      '$allCases',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: mediaQueryWidth * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE55604),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mediaQueryHeight * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kasus Batas Ditambahkan',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: mediaQueryWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE55604),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                                top: mediaQueryHeight * 0.02,
                                bottom: mediaQueryHeight * 0.02,
                                right: mediaQueryWidth * 0.03,
                              ),
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.13,
                              ),
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder<int>(
                                future: getAddedForCurrentMonth(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    int addedCases =
                                        snapshot.data ?? 0; // Default to 0
                                    return Text(
                                      '$addedCases',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: mediaQueryWidth * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mediaQueryHeight * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kasus Batas Diperbarui',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: mediaQueryWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFE55604),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: mediaQueryWidth * 0.03,
                                top: mediaQueryHeight * 0.02,
                                bottom: mediaQueryHeight * 0.02,
                                right: mediaQueryWidth * 0.03,
                              ),
                              margin: EdgeInsets.only(
                                left: mediaQueryWidth * 0.19,
                              ),
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder<int>(
                                future: getUpdatedForCurrentMonth(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    int updatedCases =
                                        snapshot.data ?? 0; // Default to 0
                                    return Text(
                                      '$updatedCases',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: mediaQueryWidth * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF26577C),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// YourWordCloudWidget is a placeholder for the widget you use to display the keyword cloud.
// You need to replace it with the actual widget you're using for the keyword cloud.
class WordCloud extends StatefulWidget {
  const WordCloud({super.key, required this.keywordData});
  final List<Map> keywordData;

  @override
  State<WordCloud> createState() => _WordCloudState();
}

class _WordCloudState extends State<WordCloud> {
  List<Map> wordList = [];

  @override
  void initState() {
    super.initState();
    wordList = widget.keywordData;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    WordCloudData wcdata = WordCloudData(data: wordList);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WordCloudView(
            data: wcdata,
            // mapcolor: Color.fromARGB(255, 174, 183, 235),
            // mapwidth: 350,
            mapwidth: mediaQueryWidth * 0.8,
            // mapheight: 200,
            mapheight: mediaQueryHeight * 0.3,
            maxtextsize: 40,
            fontWeight: FontWeight.bold,
            // shape: WordCloudCircle(radius: 180),
            shape: WordCloudEllipse(majoraxis: 200, minoraxis: 150),
            colorlist: [
              Colors.green,
              Colors.redAccent,
              Colors.indigoAccent,
              Colors.yellow
            ],
          ),
        ],
      ),
    );
  }
}
