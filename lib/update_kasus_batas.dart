import 'package:flutter/material.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/home_supervisor.dart';
import 'package:sijaliproject/searching.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';

class UpdateKasusBatas extends StatefulWidget {
  final Map<String, dynamic> data;
  const UpdateKasusBatas({Key? key, required this.data}) : super(key: key);

  @override
  State<UpdateKasusBatas> createState() => _UpdateKasusBatasState();
}

class _UpdateKasusBatasState extends State<UpdateKasusBatas> {
  // TextEditingController _kodeKBLIController = TextEditingController();
  // TextEditingController _deskripsiKBLIController = TextEditingController();
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

  @override
  void initState() {
    super.initState();

    // Set initial values for text fields
    _kodeKBLIController.text = widget.data['kd_kbli'] ?? '';
    _deskripsiKBLIController.text = widget.data['deskripsi_kbli'] ?? '';
    _uraianKegiatanController.text = widget.data['uraian_kegiatan'] ?? '';
    _jenisUsahaController.text = widget.data['jenis_usaha'] ?? '';

    // Get the category from the data map
    String category = widget.data['kd_kategori'];

    // Map the category to the corresponding dropdown item
    selectedValue = getCategoryDropdownValue(category);
  }

  String getCategoryDropdownValue(String category) {
    switch (category) {
      case "A":
        return 'A. Pertanian, Kehutanan, dan Perikanan';
      case "B":
        return 'B. Pertambangan dan Penggalian';
      case "C":
        return 'C. Industri Pengolahan';
      case "D":
        return 'D. Pengadaan Listrik, Gas, Uap/Air Panas, dan Udara Dingin';
      case "E":
        return 'E. Treatment Air, Treatment Air Limbah, Treatment dan Pemulihan Material Sampah, dan Aktivitas Remediasi';
      case "F":
        return 'F. Konstruksi';
      case "G":
        return 'G. Perdagangan Besar dan Eceran; Reparasi dan Perawatan Mobil dan Sepeda Motor';
      case "H":
        return 'H. Pengangkutan dan Pergudangan';
      case "I":
        return 'I. Penyediaan Akomodasi Dan Penyediaan Makan Minum';
      case "J":
        return 'J. Informasi Dan Komunikasi';
      case "K":
        return 'K. Aktivitas Keuangan dan Asuransi';
      case "L":
        return 'L. Real Estat';
      case "M":
        return 'M. Aktivitas Profesional, Ilmiah Dan Teknis';
      case "N":
        return 'N. Aktivitas Penyewaan dan Sewa Guna Usaha Tanpa Hak Opsi, Ketenagakerjaan, Agen Perjalanan dan Penunjang Usaha Lainnya';
      case "O":
        return 'O. Administrasi Pemerintahan, Pertahanan Dan Jaminan Sosial Wajib';
      case "P":
        return 'P. Pendidikan';
      case "Q":
        return 'Q. Aktivitas Kesehatan Manusia Dan Aktivitas Sosial';
      case "R":
        return 'R. Kesenian, Hiburan Dan Rekreasi';
      case "S":
        return 'S. Aktivitas Jasa Lainnya';
      case "T":
        return 'T. Aktivitas Rumah Tangga Sebagai Pemberi Kerja; Aktivitas Yang Menghasilkan Barang Dan Jasa Oleh Rumah Tangga yang Digunakan untuk Memenuhi Kebutuhan Sendiri';
      case "U":
        return 'U. Aktivitas Badan Internasional Dan Badan Ekstra Internasional Lainnya';

      // Add cases for other categories...
      default:
        return 'A. Pertanian, Kehutanan, dan Perikanan';
    }
  }

  String kategori = "";
  String deskripsi = "";

  final TextEditingController _kodeKBLIController = TextEditingController();
  final TextEditingController _deskripsiKBLIController =
      TextEditingController();
  final TextEditingController _uraianKegiatanController =
      TextEditingController();
  final TextEditingController _jenisUsahaController = TextEditingController();

  void updateData() async {
    var url =
        Uri.parse("http://${IpConfig.serverIp}/sijali/update-kasus-batas.php");

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

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['id'] = widget.data['id'];
      request.fields['kategori'] = kategori;
      request.fields['deskripsi'] = deskripsi;
      request.fields['kode_kbli'] = _kodeKBLIController.text;
      request.fields['deskripsi_kbli'] = _deskripsiKBLIController.text;
      request.fields['uraian_kegiatan'] = _uraianKegiatanController.text;
      request.fields['jenis_usaha'] = _jenisUsahaController.text;

      if (image != null) {
        var imageFile = await http.MultipartFile.fromPath('foto', image!.path);
        request.files.add(imageFile);
      }
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Kasus batas berhasil diperbarui');
        showSuccessNotification();
        clearForm();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeSupervisor(
              initialScreen: const Searching(),
              initialTab: 4,
            ),
          ),
        );
      } else {
        print('Kasus batas gagal diperbarui');
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
      content: Text('Kasus Batas berhasil diperbarui.'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Kasus Batas gagal diperbarui.'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the screen
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> compressAndUpdateData() async {
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
    updateData();
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

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF26577C),
        title: Text(
          'SiJali BPS',
          style: TextStyle(
              color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.06),
        ),
      ),
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
                  'PERBARUI KASUS BATAS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: mediaQueryHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF26577C),
                  ),
                ),
              ),
              Container(
                width: mediaQueryWidth * 0.8,
                height: mediaQueryHeight * 0.3,
                child: Image.asset('images/update_kasus_batas.png'),
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
                        child: Text(item),
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
                      color: const Color(0xFFE55604),
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
                      color: const Color(0xFFE55604),
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
                  color: const Color(0xFF26577C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: compressAndUpdateData,
                  child: Padding(
                    padding: EdgeInsets.all(mediaQueryWidth * 0.04),
                    child: Text(
                      "Update",
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
