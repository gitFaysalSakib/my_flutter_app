import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:new_app/location_controller_search_location.dart';
import '../utils/core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import '../requests/google_maps_request.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';

import 'location_search_dialogue.dart';

class GoogleMapApp extends StatefulWidget {
  static const routeName = '/googleMap';

  GoogleMapApp({Key? key, required this.title}) : super(key: key);

  //
  final String title;

  // static const routeName = '/googleMap';

  //new implement..

  @override
  _GoogleMapAppState createState() => _GoogleMapAppState();
}

class _GoogleMapAppState extends State<GoogleMapApp> {
  //new implement..
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GMap(),
    );
  }
}

//new implemented class..Map
class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  var start_currentPostion;
  late bool loading;

  late GoogleMapController mapController;
  late LocationController locaConGetx;

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  late TextEditingController locationController;
  late TextEditingController destinationController;
  late TextEditingController myCurrentLocation;
  late TextEditingController locationControllerName;
  late TextEditingController locationControllerLocality;
  late TextEditingController locationControllerPostalCode;
  late TextEditingController locationControllerCountry;


  static const _initialPosition = LatLng(23.804812, 90.3530069);
  //static LatLng _initialPosition;
  LatLng lastPosition = _initialPosition;

  //final Set<Marker> _marker = {};
  final List<Marker> markers = [];

  //final Set<Polyline> f =set();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  CollectionReference usersBookedTable =
      FirebaseFirestore.instance.collection('bookedUsers');

  Map userBookedEntity = {'pick_location': '', 'destination': ''};

  late String pickUp;
  late String destination;
  // late String mylocationVaribale;

  // User pick-up location and destination show front page...
  Future<void> showPickupDestination() async {
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    try {
      var response =
          await usersBookedTable.where('userID', isEqualTo: getUserID).get();
      if (response.docs.length > 0) {
        setState(() {
          pickUp = userBookedEntity['pick_location'] =
              response.docs[0]['pick_location'];
          locationController.text = pickUp;

          destination =
              userBookedEntity['destination'] = response.docs[0]['destination'];
          destinationController.text = destination;
        });
      }
      print(pickUp);
      print(destination);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      lastPosition = position.target;
    });
  }

  // print('${locaConGetx.pickPlaceMark.country}');

  @override
  void initState() {
    locationController = TextEditingController();
    destinationController = TextEditingController();
    myCurrentLocation = TextEditingController();
    locaConGetx = LocationController();
    locationControllerName = locaConGetx.pickPlaceMark.name as TextEditingController;
    locationControllerCountry = locaConGetx.pickPlaceMark.country as TextEditingController;
    locationControllerLocality= locaConGetx.pickPlaceMark.locality as TextEditingController;
    locationControllerPostalCode = locaConGetx.pickPlaceMark.postalCode as TextEditingController;
    print(locationControllerName);

    // locaConGetx = LocationController();
    //print('${locaConGetx.pickPlaceMark.country}');
    print('ddddjjjjjeeee fdddddddjjj sssss');

    // mylocationVaribale = myCurrentLocation.text;

    loading = false;
    showPickupDestination();
    // print(pickUp);
    //print(destination);
    print('hiiiii');

    // getCurrentLocation();
    _getUserLocation();
    print(locationControllerName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ffff');

    print(locationControllerName);

      return Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 10.0),
            onMapCreated: onCreated,

            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
            //  markers: _marker,
            onCameraMove: _onCameraMove,

            //marker try to set
            // markers: markers.toSet(),
            // onTap: (coordinate)
            // {
            //   _addMarker(coordinate);
            // },
          ),

          Positioned(
            top: 20.0,
            right: 70.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: 3)
                ],
              ),
              child: TextField(
                cursorColor: Colors.black,
                controller: locationController,
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'pick up',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                ),
              ),
            ),
          ),

          Positioned(
            top: 80.0,
            right: 70.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ]),
              child: TextField(
                cursorColor: Colors.black,
                controller: destinationController,
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.local_taxi,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'Destination?',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                ),
              ),
            ),
          ),

          Positioned(
            //top: 200.0,
            right: 70.0,
            left: 15.0,
            bottom: 50.0,


            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ]),
              child:

              TextField(
                cursorColor: Colors.black,
                controller: myCurrentLocation,
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'My Current Location',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                ),
              ),

            ),
          ),


        ],
      );



    // return GetBuilder<LocationController>(builder: (locationCon){
    //   return Stack(
    //     children: <Widget>[
    //       GoogleMap(
    //         initialCameraPosition:
    //         CameraPosition(target: _initialPosition, zoom: 10.0),
    //         onMapCreated: onCreated,
    //
    //         myLocationEnabled: true,
    //         mapType: MapType.normal,
    //         compassEnabled: true,
    //         //  markers: _marker,
    //         onCameraMove: _onCameraMove,
    //
    //         //marker try to set
    //         // markers: markers.toSet(),
    //         // onTap: (coordinate)
    //         // {
    //         //   _addMarker(coordinate);
    //         // },
    //       ),
    //
          // Positioned(
          //   top: 20.0,
          //   right: 70.0,
          //   left: 15.0,
          //   child: Container(
          //     height: 50.0,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(3.0),
          //       color: Colors.black,
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey,
          //             offset: Offset(1.0, 5.0),
          //             blurRadius: 10,
          //             spreadRadius: 3)
          //       ],
          //     ),
          //     child: TextField(
          //       cursorColor: Colors.black,
          //       controller: locationController,
          //       decoration: InputDecoration(
          //         icon: Container(
          //           margin: EdgeInsets.only(left: 20, top: 5),
          //           width: 10,
          //           height: 10,
          //           child: Icon(
          //             Icons.location_on,
          //             color: Colors.blue,
          //           ),
          //         ),
          //         hintText: 'pick up',
          //         border: InputBorder.none,
          //         contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
          //       ),
          //     ),
          //   ),
          // ),
          //
    //       // Positioned(
    //       //   top: 80.0,
    //       //   right: 70.0,
    //       //   left: 15.0,
    //       //   child: Container(
    //       //     height: 50.0,
    //       //     width: double.infinity,
    //       //     decoration: BoxDecoration(
    //       //         borderRadius: BorderRadius.circular(3.0),
    //       //         color: Colors.black,
    //       //         boxShadow: [
    //       //           BoxShadow(
    //       //               color: Colors.grey,
    //       //               offset: Offset(1.0, 5.0),
    //       //               blurRadius: 10,
    //       //               spreadRadius: 3)
    //       //         ]),
    //       //     child: TextField(
    //       //       cursorColor: Colors.black,
    //       //       controller: destinationController,
    //       //       decoration: InputDecoration(
    //       //         icon: Container(
    //       //           margin: EdgeInsets.only(left: 20, top: 5),
    //       //           width: 10,
    //       //           height: 10,
    //       //           child: Icon(
    //       //             Icons.local_taxi,
    //       //             color: Colors.blue,
    //       //           ),
    //       //         ),
    //       //         hintText: 'Destination?',
    //       //         border: InputBorder.none,
    //       //         contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    //       //       ),
    //       //     ),
    //       //   ),
    //       // ),
    //
    //       // Positioned(
    //       //   //top: 200.0,
    //       //   right: 70.0,
    //       //   left: 15.0,
    //       //   bottom: 50.0,
    //       //
    //       //
    //       //   child: Container(
    //       //     height: 50.0,
    //       //     width: double.infinity,
    //       //     decoration: BoxDecoration(
    //       //         borderRadius: BorderRadius.circular(3.0),
    //       //         color: Colors.black,
    //       //         boxShadow: [
    //       //           BoxShadow(
    //       //               color: Colors.grey,
    //       //               offset: Offset(1.0, 5.0),
    //       //               blurRadius: 10,
    //       //               spreadRadius: 3)
    //       //         ]),
    //       //     child:
    //       //
    //       //     TextField(
    //       //       cursorColor: Colors.black,
    //       //       controller: myCurrentLocation,
    //       //       decoration: InputDecoration(
    //       //         icon: Container(
    //       //           margin: EdgeInsets.only(left: 20, top: 5),
    //       //           width: 10,
    //       //           height: 10,
    //       //           child: Icon(
    //       //             Icons.location_on,
    //       //             color: Colors.blue,
    //       //           ),
    //       //         ),
    //       //         hintText: 'My Current Location',
    //       //         border: InputBorder.none,
    //       //         contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    //       //       ),
    //       //     ),
    //       //
    //       //   ),
    //       // ),
    //
    //       Positioned(
    //         //top: 200.0,
    //         top: 100,
    //         left: 10, right: 20,
    //
    //         child: GestureDetector(
    //           onTap: () {
    //             Get.dialog(LocationSearchDialog(mapController: mapController));
    //           },
    //           child: Container(
    //               height: 50,
    //               padding: EdgeInsets.symmetric(horizontal: 5),
    //               decoration: BoxDecoration(color: Theme.of(context).cardColor,
    //                   borderRadius: BorderRadius.circular(10)),
    //               child: Row(
    //                 children: [
    //                   Icon(Icons.location_on,
    //                       size: 25, color: Theme.of(context).primaryColor),
    //                   SizedBox(width: 5),
    //                   Expanded(
    //                     child: Text(
    //                       '${locationCon.pickPlaceMark.name ?? ''}'
    //                           // ' ${locationControllerLocality ?? ''} '
    //                           // '${locationControllerPostalCode ?? ''} '
    //                           // '${locationControllerCountry ?? ''}'
    //                       ,
    //                       style: TextStyle(fontSize: 20),
    //                       maxLines: 1, overflow: TextOverflow.ellipsis,
    //
    //                       // '${locaConGetx.pickPlaceMark.name ?? ''} '
    //                     ),
    //                   ),
    //                   SizedBox(width: 10),
    //                   Icon(Icons.search,
    //                       size: 25,
    //                       color: Theme.of(context).textTheme.bodyText1!.color),
    //                 ],
    //               )),
    //         ),
    //       ),
    //     ],
    //   );
    //
    // }
    // );


  }

//Google Marker
  _addMarker(coordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers
          .add(Marker(markerId: MarkerId(id.toString()), position: coordinate));
    });
  }

// !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    // change this line after android version update..
    // var lList = new List();
    //new line this
    var lList = [];

    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> place =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      double latitude = position.latitude;
      double longitude = position.longitude;
      //  _initialPosition = LatLng(latitude, longitude);
      // locationController.text = mylocationVaribale;

      //locationController.text = place[0].country!;
      myCurrentLocation.text = place[0].country!;
      loading = true;

      //print(locationController);
    });
  }
}
