import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../sqflite/sqflite.dart';
import '../model/store.dart';

class LocalDataSource{
  final LocalDb _localDb = LocalDb();
  Future<void> addStore(Store store) async{
    _localDb.addStore(store);
  }
  Future<List<Store>> getRestaurants() async {
    List<Map> restaurants = await _localDb.getData('''
      SELECT * FROM '${_localDb.restaurants}'
    ''');
    List<Store> storeList = [];
    for (var item in restaurants) {
      Store store = Store(
          name: item[_localDb.storeName],
          location: LatLng(double.parse(item[_localDb.lat]), double.parse(item[_localDb.lng])),
          id: item[_localDb.storeId],
          favFlag: item[_localDb.favFlag]
      );
      storeList.add(store);
    }
    return storeList;
  }

  Future<void> removerestaurants()async {
    _localDb.removerestaurants();
  }
  Future<void> addrestaurants(List<Store> restaurants) async{
    for (var store in restaurants) {
      _localDb.addStore(store);
    }
  }
}