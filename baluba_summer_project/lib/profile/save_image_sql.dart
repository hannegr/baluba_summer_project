//import 'dart:html';
/*

//import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static String tableName = 'pics';
  //insert_into_database will
  // - get a location using getDatabasesPath
  // - open it
  // - create the table using dbExecute

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'profile.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE $tableName (id TEXT,  image TEXT)');
    }, version: 1);
  }

  static Future<void> insertIntoDatabase(
      String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    var q = await db.query(table);
    q.forEach((element) {
      print(element);
    });

    return db.query(table);
  }
}
*/