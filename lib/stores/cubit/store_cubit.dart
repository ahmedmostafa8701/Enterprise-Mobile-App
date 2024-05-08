import 'package:assign_1/stores/cubit/store_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/store.dart';
import '../model/store_data_source.dart';

class StoreCubit extends Cubit<StoreState>{
  StoreDataSource storeDataSource = StoreDataSource();
  List<Store> stores = [];
  StoreCubit() : super(InitialState());
  void addStore(Store store){
    storeDataSource.addStore(store);
    stores.add(store);
    emit(StoresUpdatedState(stores));
  }
  void getStores() async{
    stores = await storeDataSource.getStores();
    emit(StoresUpdatedState(stores));
  }
}