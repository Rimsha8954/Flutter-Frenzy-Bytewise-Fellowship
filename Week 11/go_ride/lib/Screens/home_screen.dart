import 'dart:async';
import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_ride/AllWidgets/divider.dart';
import 'package:go_ride/AllWidgets/progress_dialog.dart';
import 'package:go_ride/Models/direct_details.dart';
import 'package:go_ride/Screens/login_screen.dart';
import 'package:go_ride/Screens/search_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Assistant/assistant_methods.dart';
import '../DataHandler/app_data.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late DirectionDetails tripDirectionDetails;
  List<LatLng> plineCoordinates = [];
  Set<Polyline> polylineSet = {};

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double requestrideDetailsContainerHeight = 0;
  double searchContainerHeight = 300;

  bool drawerOpen = true;

  List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.pink,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.green,

  ];

  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 55.0,
    fontFamily: 'Signatra',
  );

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 300;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230;

      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      plineCoordinates.clear();
    });

    locatePosition();
  }
  void displayRequestRideContainer(){
    setState(() {
      requestrideDetailsContainerHeight = 250;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230;
      drawerOpen = true;
    });
  }

  void displayRideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 240;
      bottomPaddingOfMap = 230;
      drawerOpen = false;
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng LatLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: LatLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address::" + address);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/main_logo.png',
              scale: 5,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Route Scout",
              style: TextStyle(fontFamily: 'Signatra', fontSize: 30),
            ),
          ],
        ),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/user_icon.png',
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 16, fontFamily: "Brand Bold"),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text("Visit Profile"),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              SizedBox(
                height: 12,
              ),
              //Drawer Buttons
              //Body
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300;
              });

              locatePosition();
            },
          ),

          //Button for Drawer
          Positioned(
            top: 38,
            left: 22,
            child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState?.openDrawer();
                } else {
                  resetApp();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black54,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    (drawerOpen) ? Icons.menu : Icons.close,
                    color: Colors.black54,
                  ),
                  radius: 20,
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: AnimatedSize(
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                  height: searchContainerHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Hi, there",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Where to go?",
                          style:
                              TextStyle(fontSize: 20, fontFamily: "Brand Bold"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                            if (res == "obtainDirection") {
                              displayRideDetailsContainer();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7, 0.7),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.blueAccent),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Search Drop off"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    // ignore: unnecessary_null_comparison
                                    Provider.of<AppData>(context)
                                                .pickUpLocation !=
                                            null
                                        ? Provider.of<AppData>(context)
                                            .pickUpLocation
                                            ?.placeName
                                        : "Add Home"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Add current Location",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DividerWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add Destination"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Add your Destination route",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),

          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSize(
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                  height: rideDetailsContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.cyan,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/taxi.png",
                                  height: 70,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Car",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Brand Bold"),
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? tripDirectionDetails.distanceText
                                          : ""),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
                                  ((tripDirectionDetails != null)
                                      ? '\$${AssistantMethods.calculateFares(tripDirectionDetails)}'
                                      : ''),
                                  style: TextStyle(fontFamily: "Brand Bold"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.moneyCheck,
                                size: 18,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text("Cash"),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black54,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                             displayRideDetailsContainer();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Request",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.taxi,
                                    color: Colors.white,
                                    size: 26,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: requestrideDetailsContainerHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black54,
                      offset: Offset(0.7, 0.7),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
    SizedBox(
    width: double.infinity,
    child: AnimatedTextKit(
    animatedTexts: [
    ColorizeAnimatedText(
    'Requesting a Ride',
    textStyle: colorizeTextStyle,
    colors: colorizeColors,
      textAlign: TextAlign.center,
    ),
    ColorizeAnimatedText(
    'Please wait',
    textStyle: colorizeTextStyle,
    colors: colorizeColors,
      textAlign: TextAlign.center,
    ),
    ColorizeAnimatedText(
    'Finding a Driver',
    textStyle: colorizeTextStyle,
    colors: colorizeColors,
      textAlign: TextAlign.center,
    ),
    ],
    isRepeatingAnimation: true,
    onTap: () {
    print("Tap Event");
    },
    ),
    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(width: 2, color: Colors.grey),

                      ),
                      child: Icon(Icons.close_rounded, size: 26,),
                    ),

                    SizedBox(
                      height: 22.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text("Cancel Ride", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                    ),
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPosition =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPosition =
        Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng =
        LatLng(initialPosition?.latitude, initialPosition?.longitude);
    var dropOffLatLng =
        LatLng(finalPosition?.latitude, finalPosition?.longitude);

    showDialog(
        context: context,
        builder: (BuildContext) => ProgressDialog(message: 'Please Wait...'));

    var details = await AssistantMethods.obtainDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    setState(() {
      tripDirectionDetails = details!;
    });

    Navigator.pop(context);
    print("These are Encoded Points::");
    print(details?.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details?.encodedPoints);

    plineCoordinates.clear();
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        plineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.red,
        jointType: JointType.round,
        polylineId: PolylineId("PolylineID"),
        points: plineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });
    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
            title: initialPosition?.placeName, snippet: "My Location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickupId"));

    Marker dropOffLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: finalPosition?.placeName, snippet: "Drop Off Location"),
        position: dropOffLatLng,
        markerId: MarkerId("pickupId"));

    setState(() {
      markersSet.add(pickUpLocationMarker);
      markersSet.add(dropOffLocationMarker);
    });

    Circle pickUpCircle = Circle(
      circleId: CircleId("pickUpId"),
      fillColor: Colors.purple,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.purpleAccent,
    );

    Circle dropOffCircle = Circle(
      circleId: CircleId("pickUpId"),
      fillColor: Colors.deepOrange,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepOrangeAccent,
    );

    setState(() {
      circlesSet.add(pickUpCircle);
      circlesSet.add(dropOffCircle);
    });
  }
}
