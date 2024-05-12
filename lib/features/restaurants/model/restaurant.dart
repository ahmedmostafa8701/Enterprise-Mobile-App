import 'package:assign_1/features/restaurants/model/product.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant{
  Restaurant({required this.name, required this.location, required this.id});
  String name;
  LatLng location;
  String id;
  List<Product> ?products;
  static Restaurant fromJson(restaurant) {
    return Restaurant(
      name: restaurant['name'],
      location: LatLng(restaurant['lat'], restaurant['lng']),
      id: restaurant['id']
    );
  }
}