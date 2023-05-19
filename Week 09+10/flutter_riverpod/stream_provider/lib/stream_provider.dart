import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider/fetch_number.dart';

final numbersProvider = StreamProvider<int>((ref){
  return fetchNumbers();
});

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var Value = ref.watch(numbersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetched Number'),
      ),
      body: Value.when(data: (data){
        return Center(child: Text(data.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.blue),),);
      }, error: (error, StackTrace){
        return Center(child: Text(error.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),),);
      }, loading: (){
        return Center(child: CircularProgressIndicator(),);
      }),

    );
  }
}
