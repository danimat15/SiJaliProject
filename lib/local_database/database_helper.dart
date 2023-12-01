import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:sijaliproject/api_config.dart';
import 'dart:convert';

class DatabaseHelper {
  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

  final String table = 'kasusbatas';
  final String id = 'id';
  final String jenis_usaha = 'jenis_usaha';
  final String uraian_kegiatan = 'uraian_kegiatan';
  final String kd_kategori = 'kd_kategori';
  final String rincian_kategori = 'rincian_kategori';
  final String kd_kbli = 'kd_kbli';
  final String deskripsi_kbli = 'deskripsi_kbli';

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $jenis_usaha TEXT, $uraian_kegiatan TEXT, $kd_kategori TEXT, $rincian_kategori TEXT, $kd_kbli TEXT, $deskripsi_kbli TEXT)');
  }

  Future<bool> isDatabaseNull() async {
    // Buka atau buat database
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'my_database.db'),
      version: 1,
    );

    // Cek apakah database null
    return database == null;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await _initDatabase();
    return await db.query(table);
  }

  // Future<List<Map<String, dynamic>>> searchData(String query) async {
  //   final db = await database;
  //   return await db.rawQuery('SELECT * FROM your_table WHERE name LIKE ?', ['%$query%']);
  // }

  Future<void> syncDataToLocalDatabase() async {
    final response = await http.get(
        Uri.parse('https://${IpConfig.serverIp}/searching-kasus-batas.php'));

    if (response.statusCode == 200) {
      print('berhasil masuk kedatabase');
    } else {
      print('gagal masuk ke database');
    }

    // Proses dan simpan data ke database lokal
    List<Map<String, dynamic>> dataToInsert = processData(response.body);

    Database? db = await database;

    // Bersihkan tabel sebelum menyimpan data baru
    await db!.delete(table);

    // Simpan data ke tabel lokal
    await db.transaction((txn) async {
      for (var record in dataToInsert) {
        await txn.insert(
            table, record); // Ganti 'my_database.db' dengan 'table'
      }
    });

    // Tutup koneksi database jika perlu
    // db.close();
  }

  List<Map<String, dynamic>> processData(String responseBody) {
    // Proses data dari respons HTTP (ubah dari JSON ke List<Map>)
    List<Map<String, dynamic>> processedData = [];

    try {
      // Decode respons JSON
      List<dynamic> jsonData = json.decode(responseBody);

      // Proses setiap elemen dalam data JSON
      for (var item in jsonData) {
        // Misalnya, asumsikan data JSON memiliki kunci 'id' dan 'name'
        String id = item['id'];
        String jenis_usaha = item['jenis_usaha'];
        String uraian_kegiatan = item['uraian_kegiatan'];
        String kd_kategori = item['kd_kategori'];
        String rincian_kategori = item['rincian_kategori'];
        String kd_kbli = item['kd_kbli'];
        String deskripsi_kbli = item['deskripsi_kbli'];

        // Tambahkan data ke dalam List<Map>
        processedData.add({
          'id': id,
          'jenis_usaha': jenis_usaha,
          'uraian_kegiatan': uraian_kegiatan,
          'kd_kategori': kd_kategori,
          'rincian_kategori': rincian_kategori,
          'kd_kbli': kd_kbli,
          'deskripsi_kbli': deskripsi_kbli,
          // Tambahkan kunci dan nilai lainnya sesuai kebutuhan
        });
      }
    } catch (e) {
      // Tangani kesalahan jika parsing JSON gagal
      print('Error parsing JSON: $e');
    }

    return processedData;
  }
}
