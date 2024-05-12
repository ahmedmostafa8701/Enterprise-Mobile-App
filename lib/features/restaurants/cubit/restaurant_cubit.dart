
import 'package:assign_1/features/restaurants/cubit/restaurant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/local_data_source.dart';
import '../data/remote_data_source.dart';
import '../model/restaurant.dart';

class RestaurantCubit extends Cubit<RestaurantState>{
  LocalDataSource localDataSource = LocalDataSource();
  RemoteDataSource remoteDataSource = RemoteDataSource();
  List<Restaurant> restaurants = [];
  List<Restaurant> favoriteRestaurants = [];
  int mode = 0;
  RestaurantCubit() : super(InitialState());
  void addStore(Restaurant store) async{
    // await remoteDataSource.addStore(store);
    await localDataSource.addStore(store);
    restaurants.add(store);
    emit(RestaurantsUpdatedState(restaurants));
  }
  void getRestaurants() async{
    // if(FirebaseAuth.instance.currentUser == null){
    //   FirebaseAuth.instance.signInWithEmailAndPassword(email: "ahmed@stud.fci-cu.edu.eg", password: "12345678");
    // }
    restaurants = await localDataSource.getRestaurants();
    if(restaurants.isEmpty){
      emit(InitialState());
      return;
    }
    emit(RestaurantsUpdatedState(restaurants));
    // restaurants = await remoteDataSource.getAllrestaurants();
    // if(restaurants.isNotEmpty){
    //   emit(restaurantsUpdatedState(restaurants));
    // }
  }
  // void getFavoriterestaurants() async{
  //   favoriterestaurants = [];
  //   for(Store store in restaurants){
  //     if(store.favFlag == 1){
  //       favoriterestaurants.add(store);
  //     }
  //   }
  //   emit(restaurantsUpdatedState(favoriterestaurants));
  // }
  // void switchMode() async{
  //   mode = mode == 0 ? 1 : 0;
  //   if(mode == 0){
  //     emit(restaurantsUpdatedState(restaurants));
  //   }
  //   else{
  //     favoriterestaurants = [];
  //     for(Store store in restaurants){
  //       if(store.favFlag == 1){
  //         favoriterestaurants.add(store);
  //       }
  //     }
  //     emit(restaurantsUpdatedState(favoriterestaurants));
  //   }
  // }
  // void changeFavorite(Store store, bool status) async{
  //   if(status == true){
  //     await remoteDataSource.addToFavorite(store);
  //     await localDataSource.addToFavorite(store);
  //     store.favFlag = 1;
  //   }else{
  //     await remoteDataSource.removeFromFavorite(store);
  //     await localDataSource.removeFromFavorite(store);
  //     store.favFlag = 0;
  //   }
  //   if(mode == 1) {
  //     getFavoriterestaurants();
  //     emit(restaurantsUpdatedState(favoriterestaurants));
  //   }
  // }

  // Future<void> sync() async {
  //   await localDataSource.removerestaurants();
  //   restaurants = await remoteDataSource.getAllrestaurants();
  //   await localDataSource.addrestaurants(restaurants);
  //   if(mode == 1){
  //     emit(restaurantsUpdatedState(favoriterestaurants));
  //   }
  //   else{
  //     emit(restaurantsUpdatedState(restaurants));
  //   }
  // }
}