import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/pages/counter_provider.dart';
import 'package:riverpod_test/pages/product_repository.dart';

// Provider에게 의존함
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final product = ref.watch(productProvider);

    return Scaffold(
      body: Column(
        children: [
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
