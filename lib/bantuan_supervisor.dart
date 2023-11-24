import 'dart:async';
import 'dart:convert';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/detail_bantuan_supervisor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BantuanSupervisor extends StatefulWidget {
  const BantuanSupervisor({Key? key}) : super(key: key);

  @override
  _BantuanSupervisorState createState() => _BantuanSupervisorState();
}

class _BantuanSupervisorState extends State<BantuanSupervisor> {
  Future<List<Map<String, dynamic>>> getUsulan() async {
    try {
      var url = 'http://${IpConfig.serverIp}/sijali/read-bantuan-usulan.php';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        // If the response status code is not 200, return an empty list
        return [];
      }
    } catch (e) {
      // If an exception occurs, return an empty list
      print('Error fetching usulan: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getPermasalahan() async {
    try {
      var url =
          'http://${IpConfig.serverIp}/sijali/read-bantuan-permasalahan.php';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
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
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEBE4D1),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: false,
                pinned: true,
                backgroundColor: Color(0xFFEBE4D1),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                      mediaQueryHeight * 0.01), // Adjust the height as needed
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Usulan Kasus Batas'),
                      Tab(text: 'Permasalahan'),
                    ],
                    labelStyle: TextStyle(
                      fontSize: mediaQueryHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Color(0xFFE55604),
                    indicatorWeight: 4.0,
                    labelColor: Color(0xFFE55604),
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(
              top: mediaQueryHeight * 0.01,
              left: mediaQueryHeight * 0.01,
              right: mediaQueryHeight * 0.01,
              bottom: mediaQueryHeight * 0.01,
            ),
            child: TabBarView(
              children: [
                FutureBuilder(
                  future: getUsulan(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Map<String, dynamic>> usulanList =
                          snapshot.data ?? [];

                      bool allUsulanHaveBalasan = usulanList.every(
                        (kb) => kb['balasan'] != null && kb['balasan'] != '',
                      );

                      return usulanList.isEmpty
                          ? Center(
                              child: Text(
                                'Tidak ada usulan kasus batas',
                                style: TextStyle(
                                  fontSize: mediaQueryHeight * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : allUsulanHaveBalasan
                              ? Center(
                                  child: Text(
                                    'Semua usulan kasus batas sudah ditanggapi',
                                    style: TextStyle(
                                      fontSize: mediaQueryHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: usulanList.map((kb) {
                                    if (kb['balasan'] == null ||
                                        kb['balasan'] == '') {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailBantuanSupervisor(
                                                      detail: kb),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Text(
                                                  '${kb['deskripsi']}',
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                );
                    }
                  },
                ),
                FutureBuilder(
                  future: getPermasalahan(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Map<String, dynamic>> permasalahanList =
                          snapshot.data ?? [];

                      bool allPermasalahanHaveBalasan = permasalahanList.every(
                          (mslh) =>
                              mslh['balasan'] != null && mslh['balasan'] != '');

                      return permasalahanList.isEmpty
                          ? Center(
                              child: Text(
                                'Tidak ada permasalahan',
                                style: TextStyle(
                                  fontSize: mediaQueryHeight * 0.025,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : allPermasalahanHaveBalasan
                              ? Center(
                                  child: Text(
                                    'Semua permasalahan sudah ditanggapi',
                                    style: TextStyle(
                                      fontSize: mediaQueryHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: permasalahanList.map((mslh) {
                                    if (mslh['balasan'] == null ||
                                        mslh['balasan'] == '') {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailBantuanSupervisor(
                                                      detail: mslh),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Text(
                                                  '${mslh['deskripsi']}',
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
