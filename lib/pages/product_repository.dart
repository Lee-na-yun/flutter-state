import 'package:flutter_riverpod/flutter_riverpod.dart';

// 리턴하려면 product dto가 필요함
class Product {
  int id;
  String name;
  int price;

  //생성자 만들기 alt+insert
  Product(this.id, this.name, this.price);
}

final productProvider =
    StateNotifierProvider<ProductRepository, Product>((ref) {
  return ProductRepository();
});

//Product를 관리하겠다.
class ProductRepository extends StateNotifier<Product> {
  // 데이터
  /*Product fetch() {
    return Product(1, "바나나", 1000);
  }*/

  ProductRepository() : super(Product(1, "바나나", 1000));
}
