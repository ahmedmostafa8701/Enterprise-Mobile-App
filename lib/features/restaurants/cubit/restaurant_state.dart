import '../model/restaurant.dart';

class RestaurantState{}
class InitialState extends RestaurantState{}
class AddRestaurantState extends RestaurantState{}

class RestaurantsLoadingState extends RestaurantState{}


class RestaurantsUpdatedState extends RestaurantState{
  RestaurantsUpdatedState(this.restaurants);
  List<Restaurant> restaurants;
}

class RestaurantErrorState extends RestaurantState{
  RestaurantErrorState(this.message);
  String message;
}