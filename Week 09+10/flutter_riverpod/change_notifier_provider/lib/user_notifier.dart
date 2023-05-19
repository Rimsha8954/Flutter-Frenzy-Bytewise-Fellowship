import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier{
  String UserName = "Rimsha";


  void changeName(){
    UserName = 'Sahiba';
    notifyListeners();
  }
}