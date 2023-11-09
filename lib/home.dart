import 'package:sijaliproject/geotagging.dart';
import 'package:sijaliproject/kritik_saran.dart';
import 'package:sijaliproject/searching.dart';
import 'package:flutter/material.dart';
import 'package:sijaliproject/dashboard.dart';
import 'package:sijaliproject/sidebar.dart';

class Home extends StatefulWidget {
  final Widget initialScreen;
  final int initialTab;

  const Home({Key? key, required this.initialScreen, required this.initialTab})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget currentScreen;
  late int currentTab;

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreen;
    currentTab = widget.initialTab;
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor:
            currentTab == 4 ? const Color(0xFF26577C) : const Color(0xFFE55604),
        title: Text(
          'SiJali BPS',
          style: TextStyle(
              color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.06),
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            currentTab == 4 ? const Color(0xFF26577C) : const Color(0xFFE55604),
        child: Icon(
          Icons.search,
          size: mediaQueryWidth * 0.15,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            currentScreen = const Searching();
            currentTab = 4;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: mediaQueryHeight * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        currentScreen = const Dashboard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: mediaQueryWidth * 0.1,
                          color: currentTab == 0
                              ? const Color(0xFF26577C)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontSize: mediaQueryWidth * 0.03,
                              color: currentTab == 0
                                  ? const Color(0xFF26577C)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(
                        right: mediaQueryWidth * 0.06,
                        left: 0,
                        top: 0,
                        bottom: 0),
                    onPressed: () {
                      setState(() {
                        currentScreen = const KritikSaran();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.messenger_outline_rounded,
                          size: mediaQueryWidth * 0.1,
                          color: currentTab == 1
                              ? const Color(0xFF26577C)
                              : Colors.grey,
                        ),
                        Text(
                          'Kritik & Saran',
                          style: TextStyle(
                              fontSize: mediaQueryWidth * 0.03,
                              color: currentTab == 1
                                  ? const Color(0xFF26577C)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: mediaQueryWidth * 0.01,
              ),
              Row(
                children: [
                  MaterialButton(
                    padding: EdgeInsets.only(
                        left: mediaQueryWidth * 0.06,
                        right: 0,
                        top: 0,
                        bottom: 0),
                    onPressed: () {
                      setState(() {
                        currentScreen = const Geotagging();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: mediaQueryWidth * 0.1,
                          color: currentTab == 2
                              ? const Color(0xFF26577C)
                              : Colors.grey,
                        ),
                        Text(
                          'Geotagging',
                          style: TextStyle(
                              fontSize: mediaQueryWidth * 0.03,
                              color: currentTab == 2
                                  ? const Color(0xFF26577C)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        currentScreen = const Dashboard();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: mediaQueryWidth * 0.1,
                          color: currentTab == 3
                              ? const Color(0xFF26577C)
                              : Colors.grey,
                        ),
                        Text(
                          'Bantuan',
                          style: TextStyle(
                              fontSize: mediaQueryWidth * 0.03,
                              color: currentTab == 3
                                  ? const Color(0xFF26577C)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
