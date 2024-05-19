import '../model/product.dart';
import '../model/restaurant.dart';

class RestaurantState{}
class InitialState extends RestaurantState{}
class AddRestaurantState extends RestaurantState{}

class RestaurantsLoadingState extends RestaurantState{}

class ProductsLoadingState extends RestaurantState{}
class RestaurantsUpdatedState extends RestaurantState{
  RestaurantsUpdatedState(this.restaurants);
  List<Restaurant> restaurants;
}
class ProductsUpdatedState extends RestaurantState{
  ProductsUpdatedState(this.products);
  List<Product> products;
}
class RestaurantErrorState extends RestaurantState{
  RestaurantErrorState(this.message);
  String message;
}