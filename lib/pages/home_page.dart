import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/pages/counter_provider.dart';
import 'package:riverpod_test/pages/product.dart';
import 'package:riverpod_test/pages/product_list_repository.dart';
import 'package:riverpod_test/pages/product_repository.dart';

// Provider에게 의존함
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final product = ref.watch(productProvider);
    final productList = ref.watch(productListProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // ListView는 높이가 없어서 설정해줘야 보임
              itemCount: productList.length, //리스트 크기
              itemBuilder: (context, index) {
                return ListTile(
                  // ListTile:리스트를 예쁘게 스타일 할 수 있는 위젯
                  title: Text("${productList[index].name}"),
                  subtitle: Text("${productList[index].price}"),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final p1 = ref.read(productListProvider
                    .notifier); // 데이터를 변경하고싶은 곳에서 read로 읽고 notifier만 붙여주면 됨
                p1.state = [...p1.state, Product(4, "고구마", 5000)];
              },
              // final repo = ref.read(counterProvider.notifier);
              // repo.increment(); 로 써도 됨!
              child: Text(
                "상품추가",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              )),
          Text(
            "${count}",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
          ),
          Text(
            "${product.name}",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(counterProvider.notifier)
                    .increment(); // 데이터를 변경하고싶은 곳에서 read로 읽고 notifier만 붙여주면 됨
              },
              // final repo = ref.read(counterProvider.notifier);
              // repo.increment(); 로 써도 됨!
              child: Text(
                "클릭",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
