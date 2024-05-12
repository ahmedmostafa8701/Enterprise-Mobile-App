import '../model/restaurant.dart';

class RestaurantState{}
class InitialState extends RestaurantState{}
class AddRestaurantState extends RestaurantState{}

class RestaurantsUpdatedState extends RestaurantState{
  RestaurantsUpdatedState(this.restaurants);
  List<Restaurant> restaurants;
}