import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../sqflite/sqflite.dart';
import '../model/store.dart';

class LocalDataSource{
  final LocalDb _localDb = LocalDb();
  void addStore(Store store) async{
    _localDb.insertData('''
      INSERT INTO '${_localDb.stores}' ('${_localDb.storeName}', '${_localDb.lat}','${_localDb.lng}')
      VALUES ('${store.name}', '${store.location.latitude.toString()}', '${store.location.longitude.toString()}')
    ''');
  }
  Future<List<Store>> getStores() async {
    List<Map> stores = await _localDb.getData('''
      SELECT * FROM '${_localDb.stores}'
    ''');
    List<Store> storeList = [];
    for (var store in stores) {
      storeList.add(
          Store(
              name: store[_localDb.storeName],
              location: LatLng(double.parse(store[_localDb.lat]), double.parse(store[_localDb.lng]))
          )
      );
    }
    return storeList;
  }
}