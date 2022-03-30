import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/model.dart';

class dbHelper{

  static dbHelper? _dbHelper;
  static Database? _database;

  dbHelper._createObject();

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'items.db';

    var iitemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    return iitemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      '''
        Create table item(
          id integer primary key autoincrement,
          name text,
          price integer 
        )
      '''
    );
  }

  Future<List <Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var maplist = await db.query('item', orderBy: 'name');

    return maplist;
  }

  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert(('item'), object.toMap());

    return count;
  }

  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db.update('item',
      object.toMap(), where: 'id=?', whereArgs: [object.id]
    );
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;

    List<Item> itemList = <Item>[];
    for (int i = 0; i < count; i++) {
      itemList.add(Item.froMap(itemMapList[i]));
    }
    return itemList;
  }

  factory dbHelper() {
    if (_dbHelper == null) {
      _dbHelper = dbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

}