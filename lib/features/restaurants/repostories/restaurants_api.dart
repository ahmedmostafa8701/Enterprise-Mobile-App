import 'package:assign_1/features/restaurants/model/restaurant.dart';
import 'package:assign_1/features/restaurants/repostories/restaurant_repo.dart';
import 'package:dio/dio.dart';

class RestaurantsApi extends RestaurantsRepository {
  final dio = Dio();
  @override
  Future<List<Restaurant>> getAllRestaurants() async {
    List<Restaurant> restaurants = [];
    try {
      var response = await dio.get('http://192.168.1.38:8080/api/v1/store');
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        var list = await response.data as List;
        restaurants =
            list.map((e) => Restaurant.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return restaurants;
  }
}
