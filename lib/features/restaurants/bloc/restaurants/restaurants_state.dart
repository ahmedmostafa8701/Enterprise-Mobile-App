import '../../model/restaurant.dart';

abstract class RestaurantsState {}

class InitialState extends RestaurantsState {}

class AddRestaurantState extends RestaurantsState {
  final Restaurant restaurant;

  AddRestaurantState(this.restaurant);
}

class RestaurantsLoadingState extends RestaurantsState {}

class RestaurantsUpdatedState extends RestaurantsState {
  final List<Restaurant> restaurants;

  RestaurantsUpdatedState(this.restaurants);
}

class RestaurantErrorState extends RestaurantsState {
  final String message;

  RestaurantErrorState(this.message);
}