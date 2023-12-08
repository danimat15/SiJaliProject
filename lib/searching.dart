import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/detail_searching.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sijaliproject/local_database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CustomContainer extends StatelessWidget {
  final List<Map<String, dynamic>> filteredData;
  final int index;

  final VoidCallback? onTap;

  const CustomContainer({
    Key? key,
    required this.filteredData,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    String uraianKegiatan = filteredData[index]['uraian_kegiatan'];
    if (uraianKegiatan.length > 100) {
      uraianKegiatan = uraianKegiatan.substring(0, 75) + '...';
    }
    // Your existing code here
    return InkWell(
      onTap: onTap,
      child: Container(
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
                  color: Color(0xFF26577C),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: mediaQueryHeight * 0.02,
                      left: mediaQueryWidth * 0.02,
                      right: mediaQueryWidth * 0.02,
                      bottom: mediaQueryHeight * 0.02),
                  child: Column(
                    children: [
                      Text(
                        'Kode KBLI: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQueryHeight * 0.018,
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.02),
                      Text(
                        filteredData[index]['kd_kbli'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: mediaQueryHeight * 0.03,
                        ),
                      ),
                    ],
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
              child: Padding(
                padding: EdgeInsets.only(
                    top: mediaQueryHeight * 0.02,
                    left: mediaQueryWidth * 0.02,
                    right: mediaQueryWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uraian Kegiatan: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQueryHeight * 0.018,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      uraianKegiatan,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: mediaQueryHeight * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Initialize futureData here
    futureData = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData([String? searchQuery]) async {
    final response = await http.get(
      Uri.parse(
          'http://${IpConfig.serverIp}/searching-kasus-batas.php?search=${Uri.encodeComponent(searchQuery ?? '')}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Define a list of stopwords
  List<String> stopwords = [
    'dan',
    'dari',
    'yang',
    'di',
    'ke',
    'pada',
    'dengan',
    'untuk',
    'ini',
    'dalam',
    'atau',
    'adalah',
    'tidak',
    'juga',
    'jika',
    'oleh',
    'sebagai',
    'namun',
    'karena',
    'itu',
    'tersebut',
    'bisa',
    'sudah',
    'sangat',
    'banyak',
    'sehingga',
    /* add more stopwords as needed */
  ];

// Other existing imports and code...

  Future<void> addData(String keyword) async {
    // Tokenize the input string, remove punctuation, and filter out stopwords
    List<String> tokens = tokenizeRemovePunctuationAndStopwords(keyword);

    // Add each token to the database
    for (String token in tokens) {
      final response = await http.post(
        Uri.parse('http://${IpConfig.serverIp}/insert-kata-kunci.php'),
        body: {'keyword': token},
      );

      if (response.statusCode == 200) {
        print('Token added successfully: $token');
      } else {
        print('Failed to add token: $token');
      }
    }
  }

  List<String> tokenizeRemovePunctuationAndStopwords(String input) {
    // Use a regular expression to replace non-alphanumeric characters with an empty string
    List<String> tokens = input.replaceAll(RegExp(r'[^\w\s]'), '').split(' ');

    // Convert tokens to lowercase
    tokens = tokens.map((token) => token.toLowerCase()).toList();

    // Filter out stopwords
    tokens = tokens.where((token) => !stopwords.contains(token)).toList();

    return tokens;
  }

  // List<Map<String, dynamic>> filterData(
  //     List<Map<String, dynamic>> data, String query) {
  //   String lowercaseQuery = query.toLowerCase();

  //   return data
  //       .where((map) =>
  //           map['uraian_kegiatan'].toLowerCase().contains(lowercaseQuery) ||
  //           map['kd_kbli'].toLowerCase().contains(lowercaseQuery) ||
  //           map['jenis_usaha'].toLowerCase().contains(lowercaseQuery) ||
  //           map['kd_kategori'].toLowerCase().contains(lowercaseQuery) ||
  //           map['rincian_kategori'].toLowerCase().contains(lowercaseQuery) ||
  //           map['deskripsi_kbli'].toLowerCase().contains(lowercaseQuery))
  //       .toList();
  // }

  int levenshteinDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    int substitutionCost(String x, String y) => x == y ? 0 : 1;

    List<List<int>> matrix = List.generate(
        a.length + 1, (i) => List.generate(b.length + 1, (j) => 0));

    for (int i = 0; i <= a.length; i++) {
      for (int j = 0; j <= b.length; j++) {
        if (i == 0) {
          matrix[i][j] = j;
        } else if (j == 0) {
          matrix[i][j] = i;
        } else {
          matrix[i][j] = [
            matrix[i - 1][j] + 1,
            matrix[i][j - 1] + 1,
            matrix[i - 1][j - 1] + substitutionCost(a[i - 1], b[j - 1]),
          ].reduce((min, element) => element < min ? element : min);
        }
      }
    }

    return matrix[a.length][b.length];
  }

  List<String> searchWithLevenshtein(
      List<String> options, String userInput, int maxDistance) {
    return options
        .where(
            (option) => levenshteinDistance(option, userInput) <= maxDistance)
        .toList();
  }

  List<Map<String, dynamic>> filterData(
      List<Map<String, dynamic>> data, String query) {
    List<String> keywords = tokenizeRemovePunctuationAndStopwords(query);

    // Filter out exact matches
    List<Map<String, dynamic>> exactMatches = data
        .where((map) => keywords.any((keyword) =>
            map['uraian_kegiatan'].toString().toLowerCase().contains(keyword) ||
            map['kd_kbli'].toString().toLowerCase().contains(keyword) ||
            map['jenis_usaha'].toString().toLowerCase().contains(keyword) ||
            map['kd_kategori'].toString().toLowerCase().contains(keyword) ||
            map['rincian_kategori']
                .toString()
                .toLowerCase()
                .contains(keyword) ||
            map['deskripsi_kbli'].toString().toLowerCase().contains(keyword)))
        .toList();

    if (exactMatches.isNotEmpty) {
      return exactMatches;
    }

    // No exact matches, try finding similar words
    List<String> validKeywords = data
        .map((map) =>
            map['uraian_kegiatan'].toString().toLowerCase() +
            ' ' +
            map['kd_kbli'].toString().toLowerCase() +
            ' ' +
            map['jenis_usaha'].toString().toLowerCase() +
            ' ' +
            map['kd_kategori'].toString().toLowerCase() +
            ' ' +
            map['rincian_kategori'].toString().toLowerCase() +
            ' ' +
            map['deskripsi_kbli'].toString().toLowerCase())
        .toList();

    List<String> similarWords = searchWithLevenshtein(validKeywords,
        query.toLowerCase(), 2); // Set your desired maximum distance

    return data
        .where((map) => similarWords.any((similarWord) =>
            map['uraian_kegiatan']
                .toString()
                .toLowerCase()
                .contains(similarWord) ||
            map['kd_kbli'].toString().toLowerCase().contains(similarWord) ||
            map['jenis_usaha'].toString().toLowerCase().contains(similarWord) ||
            map['kd_kategori'].toString().toLowerCase().contains(similarWord) ||
            map['rincian_kategori']
                .toString()
                .toLowerCase()
                .contains(similarWord) ||
            map['deskripsi_kbli']
                .toString()
                .toLowerCase()
                .contains(similarWord)))
        .toList();
  }

  Future<void> fetchDataFromDatabase() async {
    // Panggil metode untuk menyinkronkan data dari MySQL ke SQLite
    await dbHelper.syncDataToLocalDatabase();
  }

  Future<void> saveLastSyncDateTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
    prefs.setString('lastSyncDateTime', formattedDate);
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
                        onSubmitted: (query) {
                          setState(() {
                            futureData = fetchData();
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          futureData = fetchData();
                        });
                      },
                      child: Icon(Icons.search,
                          color: Color(0xFF26577C),
                          size: mediaQueryHeight * 0.04),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: mediaQueryWidht * 0.02),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          fetchDataFromDatabase();
                        });

                        await saveLastSyncDateTime(); // Save the date and time

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Data kasus batas telah disinkronisasi"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                            // adjust position of SnackBar
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Icon(Icons.sync,
                          color: Color(0xFF26577C),
                          size: mediaQueryHeight * 0.04),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQueryHeight * 0.02),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> filteredData = filterData(
                        snapshot.data!, searchController.text.toLowerCase());

                    if (filteredData.isEmpty) {
                      // Show "not found" image
                      return Padding(
                        padding: EdgeInsets.only(top: mediaQueryHeight * 0.04),
                        child: Text(
                          'Kasus batas tidak ditemukan. Silakan coba kembali dengan kata kunci lain atau tanyakan pada menu Bantuan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.02,
                            color: Color(0xFF26577C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

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
                            onTap: () {
                              addData(filteredData[index]['jenis_usaha']);
                              // Navigasi ke halaman lain di sini
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailSearching(
                                      data: filteredData[index]),
                                ),
                              );
                            },
                          );
                        },
                        padding:
                            EdgeInsets.only(bottom: mediaQueryHeight * 0.15),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
