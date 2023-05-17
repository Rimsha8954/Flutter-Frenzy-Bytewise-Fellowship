import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/list_provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key,}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumbersListProvider>(
      builder: ((context,numbersListProvider, child) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          numbersListProvider.add();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("State Management using Provider"),
      ),
      body:  SizedBox(
          child: Column(
            children: [
              Text(numbersListProvider.numbers.last.toString(),style: TextStyle(fontSize: 30),),
              Container(
                height: 200,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: numbersListProvider.numbers.length,
                  itemBuilder: (context, index){
                    return Text(numbersListProvider.numbers[index].toString(),style: TextStyle(fontSize: 30),);
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
