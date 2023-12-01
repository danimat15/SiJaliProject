import 'package:flutter/material.dart';
import 'package:sijaliproject/local_database/database_helper.dart';
// import 'package:sijaliproject/detail_searchingoffline.dart';

class CustomContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final String uraianKegiatan;
  final List<Map<String, dynamic>> filteredData;
  final int index;

  const CustomContainer(
      {Key? key,
      this.onTap,
      required this.filteredData,
      required this.uraianKegiatan,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    String uraianKegiatan = filteredData[index]['uraian_kegiatan'];
    if (uraianKegiatan.length > 100) {
      uraianKegiatan = uraianKegiatan.substring(0, 75) + '...';
    }

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
                  color: Colors.grey,
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

class SearchingOffline extends StatefulWidget {
  const SearchingOffline({super.key});

  @override
  State<SearchingOffline> createState() => _SearchingOfflineState();
}

class _SearchingOfflineState extends State<SearchingOffline> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController searchController = TextEditingController();
  Future<void>? futureData;
  List<Map<String, dynamic>> searchResults = [];
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initialize futureData here
    fetchData();
  }

  Future<void> fetchData() async {
    String searchQuery = searchController.text.toLowerCase();
    List<Map<String, dynamic>> result = await dbHelper.getAllData();
    print('Data dari database lokal: $result');

    setState(() {
      filteredData = result.where((record) {
        String uraianKegiatan = record['uraian_kegiatan'].toLowerCase();
        return uraianKegiatan.contains(searchQuery);
      }).toList();
    });

    // Gunakan data yang sudah terfilter
    print('Data yang sudah terfilter: $filteredData');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEBE4D1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF26577C),
        title: Text(
          'SiJali BPS',
          style: TextStyle(
              color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.06),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: mediaQueryWidth * 0.05,
            top: mediaQueryHeight * 0.05,
            right: mediaQueryWidth * 0.05,
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
                            // Panggil metode pencarian
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
                    padding: EdgeInsets.only(left: mediaQueryWidth * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Panggil metode pencarian
                          futureData = fetchData();
                        });
                      },
                      child: Icon(Icons.search,
                          color: Color(0xFF26577C),
                          size: mediaQueryHeight * 0.04),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQueryHeight * 0.02),
              Container(
                margin: EdgeInsets.only(top: mediaQueryHeight * 0.04),
                height: MediaQuery.of(context).size.height * 0.6,
                child: filteredData.isEmpty
                    ? Center(
                        child: Text(
                          'Kasus batas tidak ditemukan. Silakan coba kembali dengan kata kunci lain atau tanyakan pada menu Bantuan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.02,
                            color: Color(0xFF26577C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return CustomContainer(
                            filteredData: filteredData,
                            index: index,
                            onTap: () {
                              // addData(filteredData[index]['jenis_usaha']);
                              // Navigasi ke halaman lain di sini
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailSearchingOffline(
                              //         data: filteredData[index]),
                              //   ),
                              // );
                            },
                            uraianKegiatan: filteredData[index]
                                ['uraian_kegiatan'],
                          );
                        },
                        padding:
                            EdgeInsets.only(bottom: mediaQueryHeight * 0.15),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchDataFromDatabase() async {
    // Panggil metode untuk menyinkronkan data dari MySQL ke SQLite
    // await dbHelper.syncDataToLocalDatabase();

    // Ambil data dari tabel lokal
    List<Map<String, dynamic>> result =
        await (await dbHelper.database)!.query('kasusbatas');

    // Gunakan data yang diambil
    print('ini di offline');
    print(result);
    print('ini di offline');

    // Tutup koneksi database jika perlu
    // dbHelper.database!.close();
  }
}
