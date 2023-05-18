import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateProvider = StateProvider<int>(
  (ref) => 0,
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          int count = ref.watch(counterStateProvider);
          return Center(
              child: Text(
            count.toString(),
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterStateProvider.notifier).state++;
        },
        child: Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
