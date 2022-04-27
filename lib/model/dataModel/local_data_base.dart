// ignore_for_file: use_rethrow_when_possible

import 'package:bmi_app/model/constants/constant_data.dart';
import 'package:bmi_app/model/dataModel/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBase {
  LocalDataBase._();

  static LocalDataBase db = LocalDataBase._();

  static Database? _database;

  Future<Database>? get dataBase async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String? path = join(databasePath, 'userInfo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $conTableName (id INTEGER PRIMARY KEY, $conuserAge TEXT,  $conuserTall TEXT , $conuserWeight TEXT)',
        );
      },
    );
  }

  Future<int> inserData(DataModel data) async {
    try {
      var _db = await dataBase;
      return await _db!.insert(conTableName!, data.toJason());
    } catch (e) {
      throw e;
    }
  }

  Future<int> updateData(DataModel data) async {
    var _db = await dataBase;
    return _db!.update(
      conTableName!,
      data.toJason(),
    );
  }

  Future<DataModel> getUserData() async {
    var _db = await dataBase;
    List<DataModel> userData = [];
    try {
      List<Map<String, dynamic>> userMap = await _db!.query(conTableName!);

      userMap.isNotEmpty
          ? userData = userMap.map((e) => DataModel.fromJason(e)).toList()
          : [];

      // ignore: unnecessary_null_comparison, prefer_if_null_operators

      return userData.last;
    } catch (e) {
      final data =
          DataModel(ageValues: '0.0', weightValues: '0.0', tallValues: '100.0');
      return data;
    }
  }

  Future<int> deleteAllData() async {
    var _db = await dataBase;
    try {
      return _db!.delete(conTableName!);
    } catch (e) {
      throw (e);
    }
  }
}
