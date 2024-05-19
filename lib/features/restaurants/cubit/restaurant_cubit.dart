
import 'dart:math';

import 'package:assign_1/features/restaurants/cubit/restaurant_state.dart';
import 'package:assign_1/features/restaurants/repostories/restaurant_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/restaurant.dart';
import '../repostories/restaurants_api.dart';

class RestaurantCubit extends Cubit<RestaurantState>{
  List<Restaurant> restaurants = [];
  RestaurantCubit() : super(InitialState());
  void getRestaurants() async{
    emit(RestaurantsLoadingState());
    Dio dio = Dio();
    RestaurantsRepository restaurantsApi = RestaurantsApi();
    restaurantsApi.getAllRestaurants().then((value) {
      restaurants = value;
      emit(RestaurantsUpdatedState(restaurants));
    });
  }
}