import 'package:Check/objects/database.dart';
import 'package:flutter/material.dart';

class Sr extends StatefulWidget {
  _SrState createState() => _SrState();
}

class _SrState extends State<Sr> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("insert"),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text("get"),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text("delete"),
              onPressed: () {
                _delete();
              },
            ),
          ],
        ),
      ),
    );
  }

   void _insert() async {
     DateTime date = DateTime.now();
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAmount  : 23.0,
      DatabaseHelper.columnStatus  : 1,
      DatabaseHelper.columnDate  : date.toString(),
      
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    DateTime date = DateTime.now();
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAmount  : 23.0,
      DatabaseHelper.columnStatus  : 0,
      DatabaseHelper.columnDate  : date,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
