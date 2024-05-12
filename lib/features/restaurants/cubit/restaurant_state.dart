import '../model/store.dart';

class RestaurantState{}
class InitialState extends RestaurantState{}
class AddRestaurantState extends RestaurantState{}

class RestaurantsUpdatedState extends RestaurantState{
  RestaurantsUpdatedState(this.restaurants);
  List<Store> restaurants;
}