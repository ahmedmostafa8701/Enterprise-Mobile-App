
import '../model/product.dart';

class ProductsState{}
class InitialState extends ProductsState{}
class AddProductState extends ProductsState{}

class ProductsLoadingState extends ProductsState{}

class ProductsUpdatedState extends ProductsState{
  ProductsUpdatedState(this.products);
  List<Product> products;
}
class ProductErrorState extends ProductsState{
  ProductErrorState(this.message);
  String message;
}