import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_shape.dart';
import 'package:word_cloud/word_cloud_tap.dart';
import 'package:word_cloud/word_cloud_tap_view.dart';
import 'package:word_cloud/word_cloud_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Map<String, dynamic>>> getKeyword() async {
    try {
      var url = 'http://${IpConfig.serverIp}/sijali/read-keyword.php';
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
                height: mediaQueryHeight * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFFFFFF),
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
                      List<Map<String, dynamic>> keywordData = snapshot.data!;

                      // Use keywordData to update your UI or perform other tasks
                      return WordCloud(keywordData: keywordData);
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

// YourWordCloudWidget is a placeholder for the widget you use to display the word cloud.
// You need to replace it with the actual widget you're using for the word cloud.
class WordCloud extends StatefulWidget {
  final List<Map<String, dynamic>> keywordData;
  WordCloud({required this.keywordData});

  @override
  State<WordCloud> createState() => _WordCloudState();
}

class _WordCloudState extends State<WordCloud> {
  List<Map<String, dynamic>> word_list = [];
  int count = 0;
  String wordstring = '';

  @override
  void initState() {
    super.initState();
    word_list = widget.keywordData;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("wordcloud"),
    );
  }
}
