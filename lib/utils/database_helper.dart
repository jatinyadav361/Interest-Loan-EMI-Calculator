import 'package:simple_interest_calculator/models/emi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper ;
  static Database _database;

  String historyTable = 'history_table';
  String colId = 'id';
  String colAmount = 'amount';
  String colRoi = 'roi' ;
  String colTime = 'time';

  DatabaseHelper._createInstance();

  factory DatabaseHelper () {
    if(_databaseHelper == null) {
        _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+ 'login.db';

    // open or create the database at the above path
    var loginDatabase = await openDatabase(path , version: 1 , onCreate: _createDb);
    return loginDatabase;
  }

  void _createDb(Database db, int newVersion) async {
      await  db.execute("CREATE TABLE $historyTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
          " $colAmount TEXT,"
          "$colRoi TEXT, $colTime TEXT)");
  }


  //INSERT OPERATION: function to save a new history
  Future<int> insertHistory(EMIHistory emiHistory) async {
    Database db = await this.database;

    var result = db.insert(historyTable, emiHistory.toMap());
    return result ;
  }
  
  //DELETE OPERATION: function to delete any history
  Future<int> deleteHistory(int id) async {
    Database db = await this.database;
    
    var result = await db.rawDelete("DELETE FROM $historyTable WHERE $colId = $id");
    return result ;
  }

  //UPDATE OPERATION : update history table
  Future<int> updateHistory(EMIHistory emiHistory) async {
    Database db = await this.database;
    
    var result = await db.update(historyTable, emiHistory.toMap(), where: '$colId = ?',whereArgs:[emiHistory.id]);
    return result;
  }

  //FETCH OPERATION: fetch history list from database in form of map object
  Future<List<Map<String , dynamic>>> getHistoryMapList() async {
    Database db = await this.database;

    var result = await db.query(historyTable);
    return result ;
  }

  //Convert fetched map object into history object
  Future<List<EMIHistory>> getHistoryList() async {
    Database db = await this.database;

    var historyMapList = await getHistoryMapList();
    var count = historyMapList.length;

    List<EMIHistory> historyList = List<EMIHistory>();

    for(int i=0;i< count ; i++) {
      historyList.add(EMIHistory.fromMapObject(historyMapList[i]));
    }
    return historyList;
  }
}