import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class LocalStorage extends StatefulWidget {
  _LocalStorageState createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Write"),
            onPressed: () {
              writeContent();
            },
          ),
          RaisedButton(
            child: Text("Read"),
            onPressed: () {
              readcontent();
            },
          )
        ],
      ),
    );
  }

  //finding localpath
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
    return directory.path;
  }

  //referencePath
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  //Write Content
  Future<File> writeContent() async {
    final file = await _localFile;
    // Write the file
    print("writting content");
    return file.writeAsString('Hello Folks');
  }

  //ReadContentFunction
  Future<String> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }
}
