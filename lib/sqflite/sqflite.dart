import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../features/restaurants/model/restaurant.dart';

class LocalDb {

  static Database? _db;
  String lat = "lat";
  String lng = "lng";
  String storeName = "storeName";
  String storeId = "storeId";
  String restaurants = "restaurants";
  String favoriterestaurants = 'favoriterestaurants';
  String favFlag = "favFlag";
  Future<Database?> get db async {
    if (_db == null){
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "enterpriseDatabase.db");
    Database enterpriseDb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return enterpriseDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "accounts" (
        "studId" TEXT NOT NULL PRIMARY KEY,
        "email" TEXT NOT NULL,
        "name" TEXT NOT NULL,
        "gender" TEXT,
        "level" TEXT,
        "password" TEXT NOT NULL,
        "image" TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE "$restaurants"(
        "$storeName" TEXT NOT NULL,
        "$storeId" TEXT Not NULL,
        "$favFlag" INTEGER DEFAULT 0,
        "$lat" TEXT NOT NULL,
        "$lng" TEXT NOT NULL
      )
      '''
    );
    log("=================== Database Created ===================");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    log("=================== Database Upgraded ===================");
  }

  getData(String sql) async {
    Database? appDb = await db;
    List<Map> response = await appDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? appDb = await db;
    int response = await appDb!.rawInsert(sql);
    return response;
  }
  addStore(Restaurant store){
    insertData('''
      INSERT INTO '$restaurants' ('$storeName', '$storeId', '$lat','$lng')
      VALUES ('${store.name}', '${store.id}', '${store.location.latitude.toString()}', '${store.location.longitude.toString()}')
    ''');
  }
  updateData(String sql) async {
    Database? appDb = await db;
    int response = await appDb!.rawUpdate(sql);
    return response;
  }
  deleteRaw(String sql) async {
    Database? appDb = await db;
    int response = await appDb!.rawDelete(sql);
    return response;
  }

  fav(String id) async {
    Database? appDb = await db;
    int response = await appDb!.update(restaurants, {favFlag: 1}, where: "$storeId = ?", whereArgs: [id]);
    return response;
  }
  unFav(String id) async {
    Database? appDb = await db;
    int response = await appDb!.update(restaurants, {favFlag: 0}, where: "$storeId = ?", whereArgs: [id]);
    return response;
  }
  deleteAllData() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "enterpriseDatabase.db");
    await deleteDatabase(path);
  }

  void removerestaurants() {
    deleteRaw('''
      DELETE FROM '$restaurants'
    ''');
  }
}