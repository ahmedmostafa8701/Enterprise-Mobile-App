import '../model/store.dart';

class StoreState{}
class InitialState extends StoreState{}
class AddStoreState extends StoreState{}
class FavoriteStoreState extends StoreState{
  FavoriteStoreState(this.stores);
  List<Store> stores;
}
class UnFavoriteStoreState extends StoreState{}
class StoresUpdatedState extends StoreState{
  StoresUpdatedState(this.stores);
  List<Store> stores;
}