import '../model/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts(int id);
}