part of 'restaurants_bloc.dart';


sealed class RestaurantsEvent {}
final class RestaurantsEventInitial {}


final class FetchRestaurantsEvent extends RestaurantsEvent {}
