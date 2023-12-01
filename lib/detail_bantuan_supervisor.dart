import 'package:sijaliproject/bantuan_supervisor.dart';
import 'package:sijaliproject/api_config.dart';
import 'package:sijaliproject/home_supervisor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBantuanSupervisor extends StatefulWidget {
  final Map<String, dynamic> detail;

  const DetailBantuanSupervisor({Key? key, required this.detail})
      : super(key: key);

  @override
  State<DetailBantuanSupervisor> createState() =>
      _DetailBantuanSupervisorState();
}

class _DetailBantuanSupervisorState extends State<DetailBantuanSupervisor> {
  TextEditingController balasan = TextEditingController();

  void addData() async {
    // Check if the response box is empty
    if (balasan.text.isEmpty) {
      showEmptyResponseError();
      return;
    } else {
      var url = Uri.parse("https://${IpConfig.serverIp}/update-bantuan.php");

      try {
        var request = http.MultipartRequest('POST', url);
        request.fields['id'] = widget.detail['id'];
        request.fields['jenis_bantuan'] = widget.detail['jenis_bantuan'];
        request.fields['balasan'] = balasan.text;

        var response = await request.send();

        // Check if the data insertion was successful
        if (response.statusCode == 200) {
          // Show success notification
          showSuccessNotification();

          // Clear the form or perform any other actions as needed
          clearForm();

          // Navigate back to the BantuanSupervisor page
          Navigator.pop(context);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeSupervisor(
                      initialScreen: BantuanSupervisor(),
                      initialTab: 3,
                    )),
          );
        } else {
          // Show error notification
          showErrorNotification();
        }
      } catch (error) {
        // Handle network or other errors
        print("Error: $error");
        showErrorNotification();
      }
    }
  }

  void showSuccessNotification() {
    final snackBar = SnackBar(
      content: Text('Tanggapan berhasil dikirimkan. Silakan cek pesan masuk'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorNotification() {
    final snackBar = SnackBar(
      content: Text('Tanggapan gagal dikirimkan. Silakan coba kembali'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    // show notification on the top of the screen
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmptyResponseError() {
    final snackBar = SnackBar(
      content: Text(
          'Tanggapan tidak boleh kosong. Silakan isi tanggapan terlebih dahulu.'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void clearForm() {
    // Clear the form fields or reset any necessary state variables
    balasan.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE55604),
        title: Text(
          'SiJali BPS',
          style: TextStyle(
              color: Color(0xFFEBE4D1), fontSize: mediaQueryWidth * 0.06),
        ),
      ),
      body: Container(
        height: mediaQueryHeight,
        color: Color(0xFFEBE4D1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQueryWidth * 0.05,
            vertical: mediaQueryHeight * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'DETAIL BANTUAN',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: mediaQueryHeight * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE55604),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01,
                        ),
                        child: Text(
                          'Jenis Bantuan',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26577C),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.01),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: mediaQueryHeight * 0.05,
                        width: mediaQueryWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQueryWidth * 0.04),
                              child: Text(
                                widget.detail['jenis_bantuan'],
                                style: TextStyle(
                                  fontSize: mediaQueryWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01,
                        ),
                        child: Text(
                          'Deskripsi Bantuan',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26577C),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.01),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: mediaQueryHeight * 0.3,
                        width: mediaQueryWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: mediaQueryHeight * 0.01,
                            left: mediaQueryWidth * 0.01,
                            right: mediaQueryWidth * 0.01,
                            bottom: mediaQueryHeight * 0.01,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQueryWidth * 0.04),
                            child: Text(
                              widget.detail['deskripsi'] ??
                                  'Tidak ada deskripsi',
                              style: TextStyle(
                                fontSize: mediaQueryWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.detail['jenis_bantuan'] == 'Usulan Kasus Batas')
                  // tampilkan longitude
                  Padding(
                    padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            left: mediaQueryWidth * 0.01,
                            bottom: mediaQueryHeight * 0.01,
                          ),
                          child: Text(
                            'Longitude',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: mediaQueryHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26577C),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQueryHeight * 0.01),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: mediaQueryHeight * 0.05,
                          width: mediaQueryWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQueryWidth * 0.04),
                                child: Text(
                                  widget.detail['longitude'],
                                  style: TextStyle(
                                    fontSize: mediaQueryWidth * 0.04,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // tampilkan latitude
                if (widget.detail['jenis_bantuan'] == 'Usulan Kasus Batas')
                  Padding(
                    padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            left: mediaQueryWidth * 0.01,
                            bottom: mediaQueryHeight * 0.01,
                          ),
                          child: Text(
                            'Latitude',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: mediaQueryHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26577C),
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQueryHeight * 0.01),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: mediaQueryHeight * 0.05,
                          width: mediaQueryWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQueryWidth * 0.04),
                                child: Text(
                                  widget.detail['latitude'],
                                  style: TextStyle(
                                    fontSize: mediaQueryWidth * 0.04,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01,
                        ),
                        child: Text(
                          'Gambar',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26577C),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.01),
                      if (widget.detail['foto'] != null)
                        Center(
                          // alignment: Alignment.centerLeft,
                          // height: mediaQueryHeight * 0.2,
                          // width: mediaQueryWidth * 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius as needed
                            child: Image.network(
                              'http://${IpConfig.serverIp}/${widget.detail['foto']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://via.placeholder.com/150', // Replace with your empty image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.05),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          bottom: mediaQueryHeight * 0.01,
                        ),
                        child: Text(
                          'Tanggapan',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: mediaQueryHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26577C),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight * 0.01),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: balasan,
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Tanggapan...',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: mediaQueryWidth * 0.04,
                                  vertical: mediaQueryHeight * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQueryHeight * 0.09),
                  child: SizedBox(
                    width: mediaQueryWidth * 0.9,
                    child: MaterialButton(
                      color: const Color(0xFFE55604),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        addData();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(mediaQueryHeight * 0.02),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: mediaQueryWidth * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
