import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:tutorial/global/constants.dart' as constants;

class WordInfo {
  final int id;
  final String word;
  final String meaning;

  WordInfo({this.id, this.word, this.meaning});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'meaning': meaning,
    };
  }
}

DBProvider DBClient;

class DBProvider {
  Database db;

  DBProvider() {
    print("aaaaa");
  }

  Future init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDirectory.path, 'tutorial.db');

    db = await openDatabase(
      dbPath,
      version: constants.VERSION,
      onCreate: (Database newDB, int version) {
        newDB.execute(constants.DB_INIT_QUERY);
      },
    );
  }

  void insertWord(WordInfo wordInfo) async {
    try {
      await db.insert("tutorial", wordInfo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.fail);
    } catch (e) {
      print(e);
    }
  }
}
