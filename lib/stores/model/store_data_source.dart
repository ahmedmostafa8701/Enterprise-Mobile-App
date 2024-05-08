import 'dart:async';

import 'package:assign_1/stores/model/store.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../sqflite/sqflite.dart';
class StoreDataSource{
  LocalDb localDb = LocalDb();
  void addStore(Store store) async{
    localDb.insertData('''
      INSERT INTO '${localDb.stores}' ('${localDb.storeName}', '${localDb.lat}','${localDb.lng}')
      VALUES ('${store.name}', '${store.location.latitude.toString()}', '${store.location.longitude.toString()}')
    ''');
  }
  Future<List<Store>> getStores() async {
    List<Map> stores = await localDb.getData('''
      SELECT * FROM '${localDb.stores}'
    ''');
    List<Store> storeList = [];
    for (var store in stores) {
      storeList.add(
        Store(
          name: store[localDb.storeName],
          location: LatLng(double.parse(store[localDb.lat]), double.parse(store[localDb.lng]))
        )
      );
    }
    return storeList;
  }
}