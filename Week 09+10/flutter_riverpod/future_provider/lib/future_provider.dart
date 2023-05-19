import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_provider/weather_model.dart';

final weatherProvider = FutureProvider.autoDispose<String>((ref) => fetchWeatherReport());

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todays Weather'),
      ),
      body: ref.watch(weatherProvider).when(data: (data){
        return Center(child: Text(data, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.blue),),);
      }, error: (error, StackTrace){
        return Center(child: Text(error.toString(), style: TextStyle(fontSize: 20, color: Colors.red),),);
      }, loading: (){
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
