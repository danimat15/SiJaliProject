import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  // Container(
                  //   padding: const EdgeInsets.only(right: 9),
                  //   alignment: Alignment.centerLeft,
                  //   child: Row(children: [
                  //     Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: PopupMenuButton(
                  //             // adjust wifth of popup menu

                  //             // adjust color of popup menu
                  //             color: const Color(0xFF26577C).withOpacity(0.9),
                  //             //adjust position of popup menu until left side of screen
                  //             offset: const Offset(-20, 59),
                  //             // rounded corner button
                  //             shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                 bottomRight: Radius.circular(15),
                  //               ),
                  //             ),
                  //             itemBuilder: (context) => [
                  //                   PopupMenuItem(
                  //                       padding: EdgeInsets.only(
                  //                           top: 20, bottom: 30),
                  //                       child: Row(
                  //                         mainAxisAlignment: MainAxisAlignment
                  //                             .center, // Center the content vertically
                  //                         children: [
                  //                           Column(
                  //                             children: [
                  //                               Icon(
                  //                                 Icons.person_outline,
                  //                                 size: 100,
                  //                                 color: Colors.white,
                  //                               ),
                  //                               Text("Nama Pengguna",
                  //                                   style: TextStyle(
                  //                                     color: Colors.white,
                  //                                   )),
                  //                               SizedBox(
                  //                                   height: mediaQueryHeight *
                  //                                       0.01),
                  //                               Text("Role Pengguna",
                  //                                   style: TextStyle(
                  //                                       color: Colors.white)),
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       )),
                  //                   PopupMenuItem(
                  //                     padding: const EdgeInsets.all(0),
                  //                     onTap: () {},
                  //                     child: Container(
                  //                       width: 180,
                  //                       decoration: const BoxDecoration(
                  //                         borderRadius: BorderRadius.only(
                  //                           bottomRight: Radius.circular(15),
                  //                           topRight: Radius.circular(15),
                  //                         ),
                  //                         color: Color(0xFFEBE4D1),
                  //                       ),
                  //                       child: const Padding(
                  //                         padding: EdgeInsets.all(10),
                  //                         child: Text(
                  //                           "Tentang Aplikasi",
                  //                           style: TextStyle(
                  //                               color: Color(0xFF26577C)),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   PopupMenuItem(
                  //                     padding: const EdgeInsets.only(
                  //                         top: 10, bottom: 20),
                  //                     onTap: () {},
                  //                     child: Container(
                  //                       width: 180,
                  //                       decoration: const BoxDecoration(
                  //                         borderRadius: BorderRadius.only(
                  //                           bottomRight: Radius.circular(15),
                  //                           topRight: Radius.circular(15),
                  //                         ),
                  //                         color: Color(0xFFEBE4D1),
                  //                       ),
                  //                       child: const Padding(
                  //                         padding: EdgeInsets.all(10),
                  //                         child: Text(
                  //                           "Logout",
                  //                           style: TextStyle(
                  //                               color: Color(0xFF26577C)),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //             child: const Icon(
                  //               Icons.person_outline,
                  //               size: 40,
                  //               color: Color(0xFF26577C),
                  //             ))),
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           left: 2.0), // Atur margin kiri di sini
                  //       child: Text(
                  //         'Nama Pengguna',
                  //         style: TextStyle(
                  //           fontSize: 20.0,
                  //           color: Color(0xFF26577C),
                  //           // adjust position of text
                  //           height: mediaQueryHeight * 0.0018,
                  //         ),
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: const Icon(
                  //         Icons.mail_outlined,
                  //         size: 40,
                  //         color: Color(0xFF26577C),
                  //       ),
                  //     )
                  //   ]),
                  // ),
                  // Container(
                  //   color: const Color(0xFF26577C),
                  //   margin: const EdgeInsets.only(top: 10.0),
                  //   child: SizedBox(
                  //     height: mediaQueryHeight * 0.002,
                  //     width: 370.0,
                  //   ),
                  // ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          top: mediaQueryHeight * 0.01,
                          left: mediaQueryWidth * 0.03),
                      child: Text(
                        'WORLDCLOUD JENIS USAHA',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // adjust font size by media query
                          fontSize: mediaQueryWidth * 0.06,

                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE55604),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: mediaQueryHeight * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFFFFFF),
                    ),
                  )
                ],
              ),
            )));
  }
}

// class PopUpMen extends StatelessWidget {
//   final List<PopupMenuEntry> menuList;
//   final Widget? icon;
//   const PopUpMen({Key? key, required this.menuList, this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       itemBuilder: ((context) => menuList),
//       icon: icon,
//     );
//   }
// }
