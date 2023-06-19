import 'package:flutter/material.dart';
import 'package:go_ride/AllWidgets/divider.dart';
import 'package:go_ride/AllWidgets/progress_dialog.dart';
import 'package:go_ride/Assistant/request_assistant.dart';
import 'package:go_ride/Models/address.dart';
import 'package:go_ride/Models/place_predictions.dart';
import 'package:provider/provider.dart';

import '../DataHandler/app_data.dart';
import '../config_maps.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    String placeAdress =
        Provider.of<AppData>(context).pickUpLocation?.placeName ?? "";
    pickUpTextEditingController.text = placeAdress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 6,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7))
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 25),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                        child: Text(
                          "Set Drop off",
                          style:
                              TextStyle(fontFamily: "Brand Bold", fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                              hintText: "PickUp Location",
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, bottom: 8, top: 8),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/desticon.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            onChanged: (val) {
                              findPlace(val);
                            },
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Drop off Location",
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, bottom: 8, top: 8),
                            ),
                          ),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 10,),
          //Tile for Displaying Predictions
          (placePredictionList.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                   padding: EdgeInsets.all(0),
                    itemBuilder: (context,index){
                     return PredictionTile(placePredictions: placePredictionList[index], key: UniqueKey(),);
                    },
                    separatorBuilder: (BuildContext context, int index) => DividerWidget(),
                    itemCount: placePredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:pk";

      var res = await RequestAssistant.getRequest(autoCompleteURL);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  PredictionTile({
    required Key key,
    required this.placePredictions,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Icon(Icons.add_location_alt_outlined),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async{

    showDialog(context: context, builder: (BuildContext context) => ProgressDialog(message: 'Setting DropOff, Please wait...',));
    
    String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);
    Navigator.pop(context);
    if(res == "failed")
      {
        return;
      }
    if(res["status"]=="OK"){
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.PlaceId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
   
      Provider.of(context, listen: false).updateDropOffLocationAddress(address);
      print("This is drop off Location::");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
