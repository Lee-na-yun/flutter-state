import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider -> 공급자
// provider는 창고(Repository)에 데이터를 공급
final numProvider = Provider((_) => 2);

void main() {
  runApp(
    // 위젯에서 프로바이더를 사용하고 읽기위해
    // 앱 전체적으로 "ProviderScope" 위젯을 감싸줘야 합니다.
    // 여기에 프로바이더의 상태가 저장됩니다.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 1;

  void increase() {
    setState(() {
      num++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double screenSize = size * 0.8;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: AComponent(num)),
          Expanded(child: BComponent(increase)),
        ],
      ),
    );
  }
}

// a컴포넌트 // 컨슈머(데이터 소비자) - 상태를 가지고 그림을 그림
// StatelessWidget 대신에 Riverpod의 ConsumerWidget을 상속받아 사용합니다. (다시 그리고싶은 것에 사용)
class AComponent extends ConsumerWidget {
  final int num;
  const AComponent(this.num, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef ref로 provider에 접근 가능 (= 공급자에게 접근 -> 공급자가 데이터 가져옴)
    // 소비를 한번만 할 때 read 사용!
    int num = ref.read(numProvider);

    return Container(
      color: Colors.yellow,
      child: Column(
        children: [
          Text("AComponent"),
          Expanded(
            // TEXT를 Expanded하면 text가 커지니까 align으로 정렬 후 확장!
            child: Align(
              child: Text(
                "${num}", // num 바인딩
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// b컴포넌트 // 서플라이어(공급자)
class BComponent extends StatelessWidget {
  final increase; //function타입 (타입을 안붙여도 됨)
  const BComponent(this.increase, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Text("BComponent"),
          Expanded(
            child: Align(
              //Container로 하면 버튼이 커짐!
              child: ElevatedButton(
                onPressed: () {
                  increase();
                },
                child: Text(
                  "숫자증가",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
