import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/word_cloud/word_cloud.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
            ],
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //example data list
//   List<Map> word_list = [
//     {'keyword': 'Apple', 'value': 100},
//     {'keyword': 'Samsung S1', 'value': 60},
//     {'keyword': 'Intel', 'value': 55},
//     {'keyword': 'Tesla', 'value': 50},
//     {'keyword': 'AMD', 'value': 40},
//     {'keyword': 'Google', 'value': 35},
//     {'keyword': 'Qualcom', 'value': 31},
//     {'keyword': 'Netflix', 'value': 27},
//     {'keyword': 'Meta', 'value': 27},
//     {'keyword': 'Amazon', 'value': 26},
//     {'keyword': 'Nvidia', 'value': 25},
//     {'keyword': 'Microsoft', 'value': 25},
//     {'keyword': 'TSMC', 'value': 24},
//     {'keyword': 'PayPal', 'value': 24},
//     {'keyword': 'AT&T', 'value': 24},
//     {'keyword': 'Oracle', 'value': 23},
//     {'keyword': 'Unity', 'value': 23},
//     {'keyword': 'Roblox', 'value': 23},
//     {'keyword': 'Lucid', 'value': 22},
//     {'keyword': 'Naver', 'value': 20},
//     {'keyword': 'Kakao', 'value': 18},
//     {'keyword': 'NC Soft', 'value': 18},
//     {'keyword': 'LG', 'value': 16},
//     {'keyword': 'Hyundai', 'value': 16},
//     {'keyword': 'KIA', 'value': 16},
//     {'keyword': 'twitter', 'value': 16},
//     {'keyword': 'Tencent', 'value': 15},
//     {'keyword': 'Alibaba', 'value': 15},
//     {'keyword': 'LG', 'value': 16},
//     {'keyword': 'Hyundai', 'value': 16},
//     {'keyword': 'KIA', 'value': 16},
//     {'keyword': 'twitter', 'value': 16},
//     {'keyword': 'Tencent', 'value': 15},
//     {'keyword': 'Alibaba', 'value': 15},
//     {'keyword': 'Disney', 'value': 14},
//     {'keyword': 'Spotify', 'value': 14},
//     {'keyword': 'Udemy', 'value': 13},
//     {'keyword': 'Quizlet', 'value': 13},
//     {'keyword': 'Visa', 'value': 12},
//     {'keyword': 'Lucid', 'value': 22},
//     {'keyword': 'Naver', 'value': 20},
//     {'keyword': 'Hyundai', 'value': 16},
//     {'keyword': 'KIA', 'value': 16},
//     {'keyword': 'twitter', 'value': 16},
//     {'keyword': 'Tencent', 'value': 15},
//     {'keyword': 'Alibaba', 'value': 15},
//     {'keyword': 'Disney', 'value': 14},
//     {'keyword': 'Spotify', 'value': 14},
//     {'keyword': 'Visa', 'value': 12},
//     {'keyword': 'Microsoft', 'value': 10},
//     {'keyword': 'TSMC', 'value': 10},
//     {'keyword': 'PayPal', 'value': 24},
//     {'keyword': 'AT&T', 'value': 10},
//     {'keyword': 'Oracle', 'value': 10},
//     {'keyword': 'Unity', 'value': 10},
//     {'keyword': 'Roblox', 'value': 10},
//     {'keyword': 'Lucid', 'value': 10},
//     {'keyword': 'Naver', 'value': 10},
//     {'keyword': 'Kakao', 'value': 18},
//     {'keyword': 'NC Soft', 'value': 18},
//     {'keyword': 'LG', 'value': 16},
//     {'keyword': 'Hyundai', 'value': 16},
//     {'keyword': 'KIA', 'value': 16},
//     {'keyword': 'twitter', 'value': 16},
//     {'keyword': 'Tencent', 'value': 10},
//     {'keyword': 'Alibaba', 'value': 10},
//     {'keyword': 'Disney', 'value': 14},
//     {'keyword': 'Spotify', 'value': 14},
//     {'keyword': 'Udemy', 'value': 13},
//     {'keyword': 'NC Soft', 'value': 12},
//     {'keyword': 'LG', 'value': 16},
//     {'keyword': 'Hyundai hh', 'value': 10},
//     {'keyword': 'KIA', 'value': 16},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     WordCloudData wcdata = WordCloudData(data: word_list);
//     print(word_list);

//     return Scaffold(
//       body: Center(
//         child: WordCloudView(
//           data: wcdata,
//           mapcolor: Color.fromARGB(255, 174, 183, 235),
//           mapwidth: 300,
//           mapheight: 300,
//           maxtextsize: 60,
//           fontWeight: FontWeight.bold,
//           shape: WordCloudCircle(radius: 150),
//           // shape: WordCloudEllipse(majoraxis: 250, minoraxis: 200),
//           colorlist: [Colors.black, Colors.redAccent, Colors.indigoAccent],
//         ),
//       ),
//     );
//   }
// }
