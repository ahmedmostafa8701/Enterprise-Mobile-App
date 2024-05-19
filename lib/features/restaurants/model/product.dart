class Product{
  Product({required this.name, required this.id});
  String name;
  int id;
  static Product fromJson(product) {
    return Product(
      name: product['name'],
      id: product['id']
    );
  }
}