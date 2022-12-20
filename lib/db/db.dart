// ignore_for_file: unused_import
import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:study_app/models/study_model.dart';

const int _databaseVersion = 1;
Database? _database;

//db使用をAndroidとiOSで分ける
Future<String> _getDbDirectory() async {
  if (Platform.isAndroid) {
    return await getDatabasesPath();
  } else if (Platform.isIOS) {
    return (await getLibraryDirectory()).path;
  } else {
    throw Exception('Unable to determine platform.');
  }
}

//dbがなければ作る、あれば更新する
Future<Database> _getDatabase() async {
  final dbPath = join(await _getDbDirectory(), 'local.db');
  return _database ??= await openDatabase(
    dbPath,
    version: _databaseVersion,
    onCreate: (db, version) async => await _initDatabase(db, -1, version),
    onUpgrade: (db, oldVersion, newVersion) async =>
        await _initDatabase(db, oldVersion, newVersion),
  );
}

Future<void> _initDatabase(Database db, int oldVersion, int newVersion) async {
  await SqliteLocalDatabase.studyDatabse._initialize(db);
}

abstract class SqliteLocalDatabase {
  static const studyDatabse = StudyDatabase();
}

class StudyDatabase implements SqliteLocalDatabase {
  const StudyDatabase();

//dbがない時にtableを作る
  Future<void> _initialize(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS studyDatabase (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT)
  ''');
  }

  Future<void> onCreate(Database db) async {
    await _initialize(db);
  }

  Future<void> insert(StudyModel studyModel) async {
    final db = await _getDatabase();

    await db.insert(
      'studyDatabase',
      studyModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("insert studyDatabase: $studyModel");
  }

  Future<List<StudyModel>> getAll() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('studyDatabase');
    return List.generate(
      maps.length,
      (i) {
        return StudyModel(
          id: maps[i]['id'],
          title: maps[i]['title'],
        );
      },
    );
  }

  Future<StudyModel> getOne(int id) async {
    final db = await _getDatabase();
    final maps =
        await db.rawQuery('SELECT * FROM studyDatabase WHERE id = ?', [id]);
    return StudyModel.fromMap(maps[0]);
  }

  Future<void> update(int id, StudyModel studyModel) async {
    final db = await _getDatabase();
    await db.update("studyDatabase", studyModel.toMap(),
        where: "id = ?", whereArgs: [id]);

    print("update studyDatabase: $studyModel");
  }

  Future<void> delete(int id) async {
    final db = await _getDatabase();
    await db.delete("studyDatabase", where: 'id = ?', whereArgs: [id]);
  }
}
