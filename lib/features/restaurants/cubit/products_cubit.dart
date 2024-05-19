
import 'package:assign_1/features/restaurants/cubit/products_state.dart';
import 'package:assign_1/features/restaurants/repostories/products_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';
import '../repostories/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState>{
  List<Product> products = [];
  ProductsRepository productsRepository = ProductsApi();
  ProductsCubit() : super(InitialState());
  Future<void> getProducts(int restaurantsID) async {
    emit(ProductsLoadingState());
    products = [];
    productsRepository.getAllProducts(restaurantsID).then((value) {
      products = value;
      products.sort((a, b) => a.id.compareTo(b.id));
      emit(ProductsUpdatedState(products));
    });
  }
}