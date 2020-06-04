
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:demo/models/models.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String  historyTable = 'history_table';
  String colId = 'id';
  String colAmount = 'amount';
  String colRoi = 'roi' ;
  String colTime = 'time' ;


  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper =  DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
      await db.execute("CREATE TABLE $historyTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAmount TEXT,"
          "$colRoi TEXT, $colTime TEXT)");
  }

  Future<Database> initialiseDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'history.db';

    var historyDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return historyDatabase ;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initialiseDatabase();
    }
    return _database;
  }

  //INSERT OPERATION: insert the history
  Future<int> insertHistory(History history) async {
    Database db = await this.database;

    int result = await db.insert(historyTable, history.toMap());
    return result;
  }

  //Update  operation
  Future<int> updateHistory (History history) async {
    Database db = await this.database;
    int result = await db.update(historyTable,history.toMap(), where: "$colId = ?" , whereArgs: [history.id]);
    return result ;
  }

  //delete operation
  Future<int> deleteHistory(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $historyTable WHERE $colId = id');
    return result;

  }

}
