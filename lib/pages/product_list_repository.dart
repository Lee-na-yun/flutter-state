import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  int id;
  String name;
  int price;

  //생성자 만들기 alt+insert
  Product(this.id, this.name, this.price);
}

final productListProvider =
    StateNotifierProvider<ProductListRepository, List<Product>>((ref) {
  return ProductListRepository();
});

//Product를 관리하겠다.
class ProductListRepository extends StateNotifier<List<Product>> {
  ProductListRepository()
      : super([
          Product(1, "바나나", 1000),
          Product(2, "딸기", 2000),
          Product(3, "참외", 3000),
        ]) {}
}
