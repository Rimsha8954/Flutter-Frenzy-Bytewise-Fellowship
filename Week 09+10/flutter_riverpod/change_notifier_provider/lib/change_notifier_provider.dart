import 'package:change_notifier_provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<User>((ref) {
  return User();
});

class CNP_Screen extends ConsumerWidget {
  const CNP_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Consumer(builder: (context, ref, child){
        var data = ref.watch(userProvider);
        return Center(child: Text(data.UserName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.deepOrangeAccent),),);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(userProvider.notifier).changeName();
        },
        child: Icon(Icons.add_alert_sharp),
      ),
    );
  }
}
