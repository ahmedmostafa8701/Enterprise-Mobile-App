import 'package:assign_1/features/restaurants/repostories/products_repo.dart';
import 'package:assign_1/utils/constants_string.dart';
import 'package:dio/dio.dart';

import '../model/product.dart';

class ProductsApi extends ProductsRepository {
  @override
  Future<List<Product>> getAllProducts(int id) async {
    List<Product> products = [];
    Dio dio = Dio();
    try {
      Response response = await dio.get('${ConstantStrings.baseUrl}$id');
      if (response.statusCode == 200) {
        response.data.forEach((element) {
          products.add(Product.fromJson(element));
        });
      }
    } catch (e) {
      print(e);
    }
    return products;
  }
}
