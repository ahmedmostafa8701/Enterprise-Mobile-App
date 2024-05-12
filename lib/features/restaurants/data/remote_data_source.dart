import 'package:assign_1/features/restaurants/data/fire_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/restaurant.dart';

class RemoteDataSource{
  Future<void> addStore(Restaurant store) async{
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return;
    }
    await FirebaseDatabase.instance.ref('${FireRefs.restaurants}/${store.id}').set({
      'name': store.name,
      'id' : store.id,
      'lng': store.location.longitude,
      'lat': store.location.latitude,
    });
    await FirebaseDatabase.instance.ref('${FireRefs.users}/${user.uid}/${FireRefs.restaurants}/${store.id}').set({'id': store.id});

  }
  Future<List<Restaurant>> getRestaurants(DatabaseReference ref) async {
    DataSnapshot snapshot = await ref.get();
    if(!snapshot.exists){
      return [];
    }
    var value = snapshot.value;
    if(value != null){
      List<Restaurant> storeList = [];
      (value as Map).forEach((key, value) {
        storeList.add(Restaurant.fromJson(value));
      });
      return storeList;
    }
    return [];
  }
}