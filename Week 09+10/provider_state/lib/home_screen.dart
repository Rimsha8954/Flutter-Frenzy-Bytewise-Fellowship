import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/list_provider.dart';
import 'package:provider_state/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<NumbersListProvider>(
      builder: ((context, numbersProviderModel, child) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          numbersProviderModel.add();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("State Management using Provider"),
      ),
      body:  SizedBox(
          child: Column(
            children: [
              Text(numbersProviderModel.numbers.last.toString(),style: TextStyle(fontSize: 30),),
              Expanded(
                child: ListView.builder(itemCount: numbersProviderModel.numbers.length,
                itemBuilder: (context, index){
                  return Text(numbersProviderModel.numbers[index].toString(),style: TextStyle(fontSize: 30),);
                },
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SecondScreen()));
              }, child: Text('Press Button')),
            ],
          ),
        ),
      )),
    );
  }
}
