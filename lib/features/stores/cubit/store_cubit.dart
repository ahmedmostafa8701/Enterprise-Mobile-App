import 'package:assign_1/features/stores/cubit/store_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../data/local_data_source.dart';
import '../data/remote_data_source.dart';
import '../model/store.dart';

class StoreCubit extends Cubit<StoreState>{
  LocalDataSource localDataSource = LocalDataSource();
  RemoteDataSource remoteDataSource = RemoteDataSource();
  List<Store> stores = [];
  List<Store> favoriteStores = [];
  int mode = 0;
  StoreCubit() : super(InitialState());
  void addStore(Store store) async{
    await remoteDataSource.addStore(store);
    await localDataSource.addStore(store);
    stores.add(store);
    emit(StoresUpdatedState(stores));
  }
  void getStores() async{
    if(FirebaseAuth.instance.currentUser == null){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: "ahmed@stud.fci-cu.edu.eg", password: "12345678");
    }
    stores = await localDataSource.getStores();
    if(stores.isEmpty){
      emit(InitialState());
      return;
    }
    emit(StoresUpdatedState(stores));
    stores = await remoteDataSource.getAllStores();
    if(stores.isNotEmpty){
      emit(StoresUpdatedState(stores));
    }
  }
  void getFavoriteStores() async{
    favoriteStores = [];
    for(Store store in stores){
      if(store.favFlag == 1){
        favoriteStores.add(store);
      }
    }
    emit(StoresUpdatedState(favoriteStores));
  }
  void switchMode() async{
    mode = mode == 0 ? 1 : 0;
    if(mode == 0){
      emit(StoresUpdatedState(stores));
    }
    else{
      favoriteStores = [];
      for(Store store in stores){
        if(store.favFlag == 1){
          favoriteStores.add(store);
        }
      }
      emit(StoresUpdatedState(favoriteStores));
    }
  }
  void changeFavorite(Store store, bool status) async{
    if(status == true){
      await remoteDataSource.addToFavorite(store);
      await localDataSource.addToFavorite(store);
      store.favFlag = 1;
    }else{
      await remoteDataSource.removeFromFavorite(store);
      await localDataSource.removeFromFavorite(store);
      store.favFlag = 0;
    }
    if(mode == 1) {
      getFavoriteStores();
      emit(StoresUpdatedState(favoriteStores));
    }
  }

  Future<void> sync() async {
    await localDataSource.removeStores();
    stores = await remoteDataSource.getAllStores();
    await localDataSource.addStores(stores);
    if(mode == 1){
      emit(StoresUpdatedState(favoriteStores));
    }
    else{
      emit(StoresUpdatedState(stores));
    }
  }
}