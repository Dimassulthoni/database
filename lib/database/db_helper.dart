import 'package:database/model/kontak.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class Dbhelper {
  static final Dbhelper _instance = Dbhelper._internal();
  static Database? _database;

  final String tableName = 'tableKontak';
  final String coloumId = 'id';
  final String coloumName = 'name';
  final String coloumMobileNo = 'mobileNo';
  final String coloumEmail = 'email';
  final String coloumCompany = 'company';

  Dbhelper._internal();
  factory Dbhelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');
    return await openDatabase(path, version: 1, onCreate: _onCrate);
  }

  Future<void> _onCrate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($coloumId INTEGER PRIMARY KEY, "
        "$coloumName TEXT, "
        "$coloumMobileNo TEXT, "
        "$coloumEmail TEXT, "
        "$coloumCompany TEXT)";
    await db.execute(sql);
  }

  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      coloumId,
      coloumName,
      coloumCompany,
      coloumMobileNo,
      coloumEmail
    ]);
    return result.toList();
  }

  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(),
        where: '$coloumId = ?', whereArgs: [kontak.id]);
  }

  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$coloumId', whereArgs: [id]);
  }

  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }
}
