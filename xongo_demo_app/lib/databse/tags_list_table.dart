import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'package:xongo_demo_app/bloc/xongo_bloc.dart';
import 'dart:io';
import 'dart:async';

import 'package:xongo_demo_app/models/response_model.dart';
import 'package:xongo_demo_app/utils/utility.dart';

class MemoDbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "tag.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE TagData(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          tag TEXT)""");
    });
  }

  Future<int> addItem(TagModel item) async {
    final db = await init();
    var bb = await fetchMemos();
    if (bb.length != 0) {
      for (var i = 0; i < bb.length; i++) {
        if (bb[i].tag != item.tag) {
          Utility.showToast(
              "Added to WishList SuccessFully", Toast.LENGTH_LONG);
          return db.insert(
            "TagData",
            item.toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        } else {
          Utility.showToast("Already Exist", Toast.LENGTH_LONG);
        }
      }
    } else {
      Utility.showToast("Added to WishList SuccessFully", Toast.LENGTH_LONG);
      return db.insert(
        "TagData", item.toMap(), //toMap() function from TagModel
        conflictAlgorithm: ConflictAlgorithm
            .ignore, //ignores conflicts due to duplicate entries
      );
    }
  }

  Future<List<TagModel>> fetchMemos() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("TagData"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return TagModel(tag: maps[i]['tag']);
    });
  }

  Future<void> DropTableIfExistsThenReCreate() async {
    //here we get the Database object by calling the openDatabase meth
    final db = await init();
    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS TagData");

    //and finally here we recreate our beloved "tableName" again which needs
    //some columns initialization
    await db.execute("""
          CREATE TABLE TagData(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          tag TEXT)""");
  }

  Future<int> deleteTag(String tag) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("TagData", //table name
        where: "tag = ?",
        whereArgs: [tag] // use whereArgs to avoid SQL injection
        );
    xongo.fetchTableData();
    Utility.showToast("Remove From WishList SuccessFully", Toast.LENGTH_LONG);
    return result;
  }

  Future<int> updateTag(int id, TagModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result = await db
        .update("TagData", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
