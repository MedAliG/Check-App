import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "data.db";
  static final _databaseVersion = 1;

  static final table = 'activity';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAmount = 'amount';
  static final columnStatus = 'status';
  static final columnDate = 'deliverDate';
  static final columnTime = 'time';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAmount REAL NOT NULL,
            $columnStatus INTEGER,
            $columnDate DATETIME,
            $columnTime TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM $table ORDER BY $columnDate");
  }

  Future<List<Map<String, dynamic>>> queryActiveRows() async {
    Database db = await instance.database;
    return await db.rawQuery(
        "SELECT * FROM $table WHERE $columnStatus = 1 ORDER BY $columnDate");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> activeRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM $table where $columnStatus = 1'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateData(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $table SET $columnName = ?,$columnAmount = ?, $columnStatus = ?,$columnDate = ?,$columnTime = ? WHERE $columnId = ?",
        [
          row['name'],
          row['amount'],
          row['status'],
          row['deliverDate'],
          row['time'],
          id
        ]);
  }

  Future<int> changeState(int id) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        'Update $table SET $columnStatus = ? WHERE $columnId = ?', [0, id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List> autoUpdateActivity() async {
    List<int> ll =[];
    DateTime currentDate = DateTime.now();
    Database db = await instance.database;
    final data =
        await db.rawQuery('Select * FROM $table where $columnStatus = 1');
    data.forEach((row) async {
      print("delv date" + row["deliverDate"] + " & timer" + row["time"]);
      DateTime parsedDate =
          _makeValidDate(DateTime.parse(row["deliverDate"]), row["time"]);
      int currentId = row["_id"];
      print("parsed date :" + parsedDate.toIso8601String());

      if (currentDate.compareTo(parsedDate) > 0) {
        print("Row id :"+row["_id"].toString());
        ll.add(row["_id"]);
        //print(parsedDate.toIso8601String() + "     " + currentDate.toString());
        return await db.rawUpdate(
            'Update $table SET $columnStatus = ? WHERE $columnId = ?',
            [0, currentId]);
      }
    });
    return ll;
  }

  DateTime _makeValidDate(DateTime s, String time) {
    DateTime x = DateTime.parse(s.year.toString() +
        "-" +
        _setValidFormat(s.month) +
        "-" +
        _setValidFormat(s.day) +
        " " +
        time);
    //print("Mr. x" + x.toIso8601String());
    return x;
  }

  String _setValidFormat(int x) {
    if (x < 10) {
      return "0" + x.toString();
    } else {
      return x.toString();
    }
  }
}
