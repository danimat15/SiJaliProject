import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sijaliproject/searching_offline.dart';

class TambahKasusBatas extends StatefulWidget {
  const TambahKasusBatas({Key? key}) : super(key: key);

  @override
  State<TambahKasusBatas> createState() => _TambahKasusBatasState();
}

class _TambahKasusBatasState extends State<TambahKasusBatas> {
  String selectedValue = 'A. Pertanian, Kehutanan, dan Perikanan';
  List<String> dropdownItems = [
    'A. Pertanian, Kehutanan, dan Perikanan',
    'B. Pertambangan dan Penggalian',
    'C. Industri Pengolahan',
    'D. Pengadaan Listrik, Gas, Uap/Air Panas Dan Udara Dingin',
    'E. Treatment Air, Treatment Air Limbah, Treatment dan Pemulihan Material Sampah, dan Aktivitas Remediasi',
    'F. Konstruksi',
    'G. Perdagangan Besar Dan Eceran; Reparasi Dan Perawatan Mobil Dan Sepeda Motor',
    'H. Pengangkutan dan Pergudangan',
    'I. Penyediaan Akomodasi Dan Penyediaan Makan Minum',
    'J. Informasi Dan Komunikasi',
    'K. Aktivitas Keuangan dan Asuransi',
    'L. Real Estat',
    'M. Aktivitas Profesional, Ilmiah Dan Teknis',
    'N. Aktivitas Penyewaan dan Sewa Guna Usaha Tanpa Hak Opsi, Ketenagakerjaan, Agen Perjalanan dan Penunjang Usaha Lainnya',
    'O. Administrasi Pemerintahan, Pertahanan Dan Jaminan Sosial Wajib',
    'P. Pendidikan',
    'Q. Aktivitas Kesehatan Manusia Dan Aktivitas Sosial',
    'R. Kesenian, Hiburan Dan Rekreasi',
    'S. Aktivitas Jasa Lainnya',
    'T. Aktivitas Rumah Tangga Sebagai Pemberi Kerja; Aktivitas Yang Menghasilkan Barang Dan Jasa Oleh Rumah Tangga yang Digunakan untuk Memenuhi Kebutuhan Sendiri',
    'U. Aktivitas Badan Internasional Dan Badan Ekstra Internasional Lainnya'
  ];

  String kategori = "";
  String deskripsi = "";
  DateTime currentDateTime = DateTime.now();

  final TextEditingController _kodeKBLIController = TextEditingController();
  final TextEditingController _deskripsiKBLIController =
      TextEditingController();
  final TextEditingController _uraianKegiatanController =
      TextEditingController();
  final TextEditingController _jenisUsahaController = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isOffline = false;

  void addData() async {
    if (_kodeKBLIController.text.isEmpty ||
        _deskripsiKBLIController.text.isEmpty ||
        _uraianKegiatanController.text.isEmpty ||
        _jenisUsahaController.text.isEmpty ||
        image == null) {
      // Tampilkan SnackBar untuk memberi tahu pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Isian tidak boleh kosong. Silakan isi terlebih dahulu."),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    int? kodeKBLI = int.tryParse(_kodeKBLIController.text);
    if (kodeKBLI == null) {
      // Tampilkan SnackBar untuk memberi tahu pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Isian Kode KBLI harus berupa angka"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_kodeKBLIController.text.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kode KBLI harus berupa 5 karakter"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    var url = Uri.parse("https://${IpConfig.serverIp}/tambah-kasus-batas.php");

    String kategori = "";
    String deskripsi = "";
    if (selectedValue == "A. Pertanian, Kehutanan, dan Perikanan") {
      kategori = "A";
      deskripsi = "Pertanian, Kehutanan, dan Perikanan";
    } else if (selectedValue == "B. Pertambangan dan Penggalian") {
      kategori = "B";
      deskripsi = "Pertambangan dan Penggalian";
    } else if (selectedValue == "C. Industri Pengolahan") {
      kategori = "C";
      deskripsi = "Industri Pengolahan";
    } else if (selectedValue ==
        "D. Pengadaan Listrik, Gas, Uap/Air Panas, dan Udara Dingin") {
      kategori = "D";
      deskripsi = "Pengadaan Listrik, Gas, Uap/Air Panas, dan Udara Dingin";
    } else if (selectedValue ==
        "E. Treatment Air, Treatment Air Limbah, Treatment dan Pemulihan Material Sampah, dan Aktivitas Remediasi") {
      kategori = "E";
      deskripsi =
          "Treatment Air, Treatment Air Limbah, Treatment dan Pemulihan Material Sampah, dan Aktivitas Remediasi";
    } else if (selectedValue == "F. Konstruksi") {
      kategori = "F";
      deskripsi = "Konstruksi";
    } else if (selectedValue ==
        "G. Perdagangan Besar dan Eceran; Reparasi dan Perawatan Mobil dan Sepeda Motor") {
      kategori = "G";
      deskripsi =
          "Perdagangan Besar dan Eceran; Reparasi dan Perawatan Mobil dan Sepeda Motor";
    } else if (selectedValue == "H. Pengangkutan dan Pergudangan") {
      kategori = "H";
      deskripsi = "Pengangkutan dan Pergudangan";
    } else if (selectedValue ==
        "I. Penyediaan Akomodasi Dan Penyediaan Makan Minum") {
      kategori = "I";
      deskripsi = "Penyediaan Akomodasi Dan Penyediaan Makan Minum";
    } else if (selectedValue == "J. Informasi Dan Komunikasi") {
      kategori = "J";
      deskripsi = "Informasi Dan Komunikasi";
    } else if (selectedValue == "K. Aktivitas Keuangan dan Asuransi") {
      kategori = "K";
      deskripsi = "Aktivitas Keuangan dan Asuransi";
    } else if (selectedValue == "L. Real Estat") {
      kategori = "L";
      deskripsi = "Real Estat";
    } else if (selectedValue == "M. Aktivitas Profesional, Ilmiah Dan Teknis") {
      kategori = "M";
      deskripsi = "Aktivitas Profesional, Ilmiah Dan Teknis";
    } else if (selectedValue ==
        "N. Aktivitas Penyewaan dan Sewa Guna Usaha Tanpa Hak Opsi, Ketenagakerjaan, Agen Perjalanan dan Penunjang Usaha Lainnya") {
      kategori = "N";
      deskripsi =
          "Aktivitas Penyewaan dan Sewa Guna Usaha Tanpa Hak Opsi, Ketenagakerjaan, Agen Perjalanan dan Penunjang Usaha Lainnya";
    } else if (selectedValue ==
        "O. Administrasi Pemerintahan, Pertahanan Dan Jaminan Sosial Wajib") {
      kategori = "O";
      deskripsi =
          "Administrasi Pemerintahan, Pertahanan Dan Jaminan Sosial Wajib";
    } else if (selectedValue == "P. Pendidikan") {
      kategori = "P";
      deskripsi = "Pendidikan";
    } else if (selectedValue ==
        "Q. Aktivitas Kesehatan Manusia Dan Aktivitas Sosial") {
      kategori = "Q";
      deskripsi = "Aktivitas Kesehatan Manusia Dan Aktivitas Sosial";
    } else if (selectedValue == "R. Kesenian, Hiburan Dan Rekreasi") {
      kategori = "R";
      deskripsi = "Kesenian, Hiburan Dan Rekreasi";
    } else if (selectedValue == "S. Aktivitas Jasa Lainnya") {
      kategori = "S";
      deskripsi = "Aktivitas Jasa Lainnya";
    } else if (selectedValue ==
        "T. Aktivitas Rumah Tangga Sebagai Pemberi Kerja; Aktivitas Yang Menghasilkan Barang Dan Jasa Oleh Rumah Tangga yang Digunakan untuk Memenuhi Kebutuhan Sendiri") {
      kategori = "T";
      deskripsi =
          "Aktivitas Rumah Tangga Sebagai Pemberi Kerja; Aktivitas Yang Menghasilkan Barang Dan Jasa Oleh Rumah Tangga yang Digunakan untuk Memenuhi Kebutuhan Sendiri";
    } else if (selectedValue ==
        "U. Aktivitas Badan Internasional Dan Badan Ekstra Internasional Lainnya") {
      kategori = "U";
      deskripsi =
          "Aktivitas Badan Internasional Dan Badan Ekstra Internasional Lainnya";
    }

    String tanggal = currentDateTime.toIso8601String().split('T')[0];
    String waktu =
        currentDateTime.toIso8601String().split('T')[1].split('.')[0];

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['kategori'] = kategori;
      request.fields['deskripsi'] = deskripsi;
      request.fields['kode_kbli'] = _kodeKBLIController.text;
      request.fields['deskripsi_kbli'] = _deskripsiKBLIController.text;
      request.fields['uraian_kegiatan'] = _uraianKegiatanController.text;
      request.fields['jenis_usaha'] = _jenisUsahaController.text;
      request.fields['tanggal'] = tanggal;
      request.fields['waktu'] = waktu;

      if (image != null) {
        var imageFile = await http.MultipartFile.fromPath('foto', image!.path);
        request.files.add(imageFile);
      }
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Data berhasil disimpan');
        showSuccessNotification();
        clearForm();
      } else {
        print('Gagal menyimpan data');
        showErrorNotification();
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
      showErrorNotification();
    }
  }

  void showSuccessNotification() {
    final snackBar = SnackBar(
      content: Text('Kasus Batas berhasil dikirimkan'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Kasus Batas gagal dikirimkan'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the screen
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> compressAndAddData() async {
    // Compress the image before uploading
    if (image != null) {
      try {
        // Read the image file as bytes
        List<int> imageBytes = await image!.readAsBytes();

        // Compress the image
        img.Image compressedImage =
            img.decodeImage(Uint8List.fromList(imageBytes))!;
        List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 25);

        // Create a new File with the compressed image
        File compressedFile = File(image!.path)
          ..writeAsBytesSync(compressedBytes);

        // Update the image variable
        image = compressedFile;
      } catch (e) {
        print("Error compressing image: $e");
      }
    }

    // Proceed to add data to the database
    addData();
  }

  void clearForm() {
    // Clear the form fields or reset any necessary state variables
    selectedValue = 'A. Pertanian, Kehutanan, dan Perikanan';
    _kodeKBLIController.clear();
    _deskripsiKBLIController.clear();
    _uraianKegiatanController.clear();
    _jenisUsahaController.clear();
    image = null;
    setState(() {});
  }

  File? image;
  Future getImageGalery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  Future getImageFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  Future<void> resetImageGalery() async {
    await getImageGalery(); // Buka galeri untuk memilih gambar
  }

  Future<void> resetImageFoto() async {
    await getImageFoto(); // Buka galeri untuk memilih gambar
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
      body: Container(
        color: const Color(0xFFEBE4D1),
        padding: EdgeInsets.only(
            top: mediaQueryHeight * 0.02,
            bottom: mediaQueryHeight * 0.02,
            left: mediaQueryWidth * 0.01,
            right: mediaQueryWidth * 0.01),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: mediaQueryHeight * 0.02),
                child: Text(
                  'TAMBAH KASUS BATAS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE55604),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.8,
                height: mediaQueryHeight * 0.2,
                child: Image.asset('images/tambah_kasus_batas.png'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    top: mediaQueryHeight * 0.05,
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Kategori',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.9,
                height: mediaQueryHeight * 0.07,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
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
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis, // Truncate long text
                        ),
                      );
                    }).toList(),
                    underline: Container(),
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Jenis Usaha',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.9,
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
                    controller: _jenisUsahaController, // Added controller
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Uraian Kegiatan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.9,
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
                    controller: _uraianKegiatanController, // Added controller
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Kode KBLI',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.9,
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
                    controller: _kodeKBLIController, // Added controller
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Deskripsi KBLI',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.9,
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
                    controller: _deskripsiKBLIController, // Added controller
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: mediaQueryWidth * 0.04,
                    bottom: mediaQueryHeight * 0.01),
                child: Text(
                  'Unggah Gambar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: mediaQueryWidth * 0.04,
                  right: mediaQueryWidth * 0.04,
                  bottom: mediaQueryHeight * 0.01,
                ),
                height: mediaQueryHeight * 0.3,
                width: mediaQueryWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFFFFFF),
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //       'assets/images/empty-image.jpg'),
                  //   fit: BoxFit.cover,
                  //   opacity: 0.5,
                ),
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                          image: DecorationImage(
                            image: AssetImage('images/empty-image.jpg'),
                            fit: BoxFit.cover,
                            opacity: 0.5,
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: mediaQueryHeight * 0.02,
                  left: mediaQueryWidth * 0.04,
                  right: mediaQueryWidth * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: const Color(0xFF26577C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        image != null
                            ? resetImageGalery()
                            : await getImageGalery();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                        child: Text("Dari Galeri",
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: mediaQueryHeight * 0.02,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                    MaterialButton(
                      color: const Color(0xFF26577C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        image != null ? resetImageFoto() : await getImageFoto();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(mediaQueryWidth * 0.03),
                        child: Text("Dari Camera",
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: mediaQueryHeight * 0.02,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQueryHeight * 0.03),
              Container(
                margin: EdgeInsets.only(
                  top: mediaQueryHeight * 0.04,
                  bottom: mediaQueryHeight * 0.03,
                ),
                width: mediaQueryWidth * 0.9,
                child: MaterialButton(
                  color: const Color(0xFFE55604),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: compressAndAddData,
                  child: Padding(
                    padding: EdgeInsets.all(mediaQueryWidth * 0.04),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'Poppins',
                        fontSize: mediaQueryHeight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
