import 'package:assign_1/features/restaurants/model/restaurant.dart';

abstract class RestaurantsRepository {
  Future<List<Restaurant>> getAllRestaurants();
}