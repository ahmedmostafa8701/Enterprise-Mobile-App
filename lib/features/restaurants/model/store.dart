import 'package:google_maps_flutter/google_maps_flutter.dart';

class Store{
  Store({required this.name, required this.location, required this.id, this.favFlag = 0});
  String name;
  LatLng location;
  String id;
  int favFlag;
  static Store fromJson(store) {
    return Store(
      name: store['name'],
      location: LatLng(store['lat'], store['lng']),
      id: store['id']
    );
  }
}