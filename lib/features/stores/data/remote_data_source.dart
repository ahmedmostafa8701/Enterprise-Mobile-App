import 'package:assign_1/features/stores/data/fire_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/store.dart';

class RemoteDataSource{
  Future<void> addStore(Store store) async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return;
    }
    await FirebaseDatabase.instance.ref('${FireRefs.stores}/${store.id}').set({
      'name': store.name,
      'id' : store.id,
      'lng': store.location.longitude,
      'lat': store.location.latitude,
    });
    await FirebaseDatabase.instance.ref('${FireRefs.users}/${user.uid}/${FireRefs.stores}/${store.id}').set({'id': store.id});
  }
  Future<List<Store>> getStores(DatabaseReference ref) async {
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
      return [];
    }
    var value = snapshot.value;
    if(value != null){
      List<Store> storeList = [];
      (value as Map).forEach((key, value) {
        storeList.add(Store.fromJson(value));
      });
      return storeList;
    }
    return [];
  }
  Future<List<Store>> getAllStores() async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return [];
    }
    List<Store> stores = await getStores(FirebaseDatabase.instance.ref(FireRefs.stores));
    List<String> favoriteStoresIds = await getFavoriteStores();
    for (var store in stores) {
      if(favoriteStoresIds.any((element) => element == store.id)){
        store.favFlag = 1;
      }
    }
    return stores;
  }
  Future<List<String>> getFavoriteStores() async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return [];
    }
    List<String> ids = [];
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref('${FireRefs.users}/${user.uid}/${FireRefs.favorites}').get();
    if(!snapshot.exists){
      return [];
    }
    var value = snapshot.value;
    if(value != null){
      (value as Map).forEach((key, value) {
        ids.add(value['id']);
      });
      return ids;
    }
    return [];
  }
  Future<void> addToFavorite(Store store) async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return;
    }
    FirebaseDatabase.instance.ref('${FireRefs.users}/${user.uid}/${FireRefs.favorites}/${store.id}').set({
      'id' : store.id
    });
  }
  Future<void> removeFromFavorite(Store store) async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return;
    }
    DatabaseReference ref = FirebaseDatabase.instance.ref('${FireRefs.users}/${user.uid}/${FireRefs.favorites}');
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
      return;
    }
    var value = snapshot.value;
    if(value != null){
      (value as Map).forEach((key, value) {
        if(value['id'] == store.id){
          ref.child(key).remove();
        }
      });
    }
  }
}