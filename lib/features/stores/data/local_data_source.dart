import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../sqflite/sqflite.dart';
import '../model/store.dart';

class LocalDataSource{
  final LocalDb _localDb = LocalDb();
  Future<void> addStore(Store store) async{
    _localDb.addStore(store);
  }
  Future<List<Store>> getStores() async {
    List<Map> stores = await _localDb.getData('''
      SELECT * FROM '${_localDb.stores}'
    ''');
    List<Store> storeList = [];
    for (var item in stores) {
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
  Future<void> addToFavorite(Store store) async{
    _localDb.fav(store.id);
  }
  Future<void> removeFromFavorite(Store store) async{
    _localDb.unFav(store.id);
  }
  Future<void> removeStores()async {
    _localDb.removeStores();
  }
  Future<void> addStores(List<Store> stores) async{
    for (var store in stores) {
      _localDb.addStore(store);
    }
  }
}