import 'package:flutter/cupertino.dart';
import 'package:go_ride/Models/address.dart';

class AppData extends ChangeNotifier
{
   Address? pickUpLocation, dropOffLocation;

  void updatePickUpLocation(Address PickUpAddress)
  {
    pickUpLocation = PickUpAddress;
    notifyListeners();
  }

   void updateDropOffLocation(Address DropOffAddress)
   {
     dropOffLocation = DropOffAddress;
     notifyListeners();
   }
}