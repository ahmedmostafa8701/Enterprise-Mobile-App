import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../sqflite/sqflite.dart';
import '../model/restaurant.dart';

class LocalDataSource{
  final LocalDb _localDb = LocalDb();
  Future<void> addStore(Restaurant store) async{
    _localDb.addStore(store);
  }
  Future<List<Restaurant>> getRestaurants() async {
    List<Map> restaurants = await _localDb.getData('''
      SELECT * FROM '${_localDb.restaurants}'
    ''');
    List<Restaurant> storeList = [];
    for (var item in restaurants) {
      Restaurant store = Restaurant(
          name: item[_localDb.storeName],
          location: LatLng(double.parse(item[_localDb.lat]), double.parse(item[_localDb.lng])),
          id: item[_localDb.storeId],
      );
      storeList.add(store);
    }
    return storeList;
  }

  Future<void> removerestaurants()async {
    _localDb.removerestaurants();
  }
  Future<void> addrestaurants(List<Restaurant> restaurants) async{
    for (var store in restaurants) {
      _localDb.addStore(store);
    }
  }
}