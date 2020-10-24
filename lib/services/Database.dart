import 'dart:io';

import 'package:khojgurbani_music/models/Downloads.dart';
import 'package:khojgurbani_music/models/UserSetings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "khojgurbani.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Downloads ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "author TEXT,"
          "attachmentName TEXT,"
          "image TEXT,"
          // "shabad_id INTEGER,"
          // "page INTEGER,"
          "is_media INTEGER"
          // "author_id INTEGER,"
          ")");
      await db.execute("CREATE TABLE Lirycs ("
          "id INTEGER PRIMARY KEY,"
          "val INTEGER"
          ")");
    });
  }

  setingsForUser(UserSetings setingsForUser) async {
    final db = await database;
    var usersSetings = await db.insert(
      "Lirycs",
      setingsForUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return usersSetings;
  }

  var allSetings;

  Future<List<Map<String, dynamic>>> getUserSeting() async {
    final db = await database;
    var usersSetings = await db.query("Lirycs");
    return usersSetings;
  }

  newDownload(Downloads newDownload) async {
    final db = await database;
    // //get the biggest id in the table
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Downloads");
    // int id = table.first["id"];
    // //insert to the table using the new id
    // var raw = await db.rawInsert(
    //     "INSERT Into Downloads (id,title,artistName,attachmentName,image)"
    //     " VALUES (?,?,?,?,?)",
    //     [
    //       id,
    //       newDownload.title,
    //       newDownload.artistName,
    //       newDownload.attachmentName,
    //       newDownload.image
    //     ]);
    // return raw;
    var res = await db.insert("Downloads", newDownload.toMap());
    return res;
  }

  var downl;

  Future<List<Downloads>> getAllDownloads() async {
    final db = await database;
    var res = await db.query("Downloads");
    List<Downloads> list = res.isNotEmpty ? res.map((c) => Downloads.fromMap(c)).toList() : [];

    downl = list;
    return list;
  }

  Future<void> deleteDownload(int id) async {
    final db = await database;
    try {
      var res = await db.delete('Downloads', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('error while deleting from database [${e.toString()}]');
    }
  }
}
