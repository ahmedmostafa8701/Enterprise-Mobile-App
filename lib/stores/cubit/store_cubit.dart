import 'package:assign_1/stores/cubit/store_state.dart';
import 'package:assign_1/stores/data/local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/store.dart';

class StoreCubit extends Cubit<StoreState>{
  LocalDataSource localDataSource = LocalDataSource();
  List<Store> stores = [];
  StoreCubit() : super(InitialState());
  void addStore(Store store){
    localDataSource.addStore(store);
    stores.add(store);
    emit(StoresUpdatedState(stores));
  }
  void getStores() async{
    stores = await localDataSource.getStores();
    if(stores.isEmpty){
      emit(InitialState());
      return;
    }
    emit(StoresUpdatedState(stores));
  }
}