import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_ride/Assistant/request_assistant.dart';
import 'package:go_ride/Models/address.dart';
import 'package:go_ride/Models/direct_details.dart';
import 'package:go_ride/config_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position, context) async{
    String placeAddress = "";
    String st1,st2,st3,st4;
    String Uri = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(Uri);

    if(response != "failed"){
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = st1 + " , " + st2 + " ," + st3 + " ,"+ st4;

      Address userPickUpAddress = new Address(placeFormattedAddress: '', longitude: '', latitude: '', placeName: '', PlaceId: '');
      userPickUpAddress.longitude = position.latitude as String;
      userPickUpAddress.latitude = position.longitude as String;
      userPickUpAddress.placeName = placeAddress;
    
      Provider.of(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails?> obtainDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);
    if(res == "failed"){
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =  res["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText =  res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =  res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =  res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;

  }
  static int calculateFares(DirectionDetails directionDetails){
    double timeTraveledFare = (directionDetails.durationValue / 60) * 0.20;
    double distanceTraveledFare = (directionDetails.durationValue / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distanceTraveledFare;

    //Local Currency
    double totalLocalAmount  = totalFareAmount*300;

    return totalLocalAmount.truncate();

  }

}