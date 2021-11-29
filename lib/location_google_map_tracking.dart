// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// //import 'package:google_map_live/mymap.dart';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
//
// import 'location_google_map_tracking2.dart';
//
// class LocationTracking extends StatefulWidget {
//   static const routeName = '/locationtracking';
//
//   const LocationTracking({Key? key}) : super(key: key);
//
//   @override
//   _LocationTrackingState createState() => _LocationTrackingState();
// }
//
// class _LocationTrackingState extends State<LocationTracking> {
//   final loc.Location location = loc.Location();
//   StreamSubscription<loc.LocationData>? _locationSubscription;
//
//   _getLocation() async {
//     try {
//       final loc.LocationData _locationResult = await location.getLocation();
//       await FirebaseFirestore.instance.collection('location').doc('user1').set({
//         'latitude': _locationResult.latitude,
//         'longitude': _locationResult.longitude,
//         'name': 'john'
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _listenLocation() async {
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print(onError);
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((loc.LocationData currentlocation) async {
//       await FirebaseFirestore.instance.collection('location').doc('user1').set({
//         'latitude': currentlocation.latitude,
//         'longitude': currentlocation.longitude,
//         'name': 'john'
//       }, SetOptions(merge: true));
//     });
//   }
//
//   _stopListening() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }
//
//   _requestPermission() async{
//     var state = await Permission.location.request();
//     if(state.isGranted){
//       print('done');
//     }else if(state.isDenied){
//       _requestPermission();
//
//     } else if(state.isPermanentlyDenied){
//       openAppSettings();
//     }
//   }
//   @override
// void initState() {
//     super.initState();
//     _requestPermission();
//     location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
//     location.enableBackgroundMode(enable: true);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('live location tracker'),
//       ),
//       body:Column(
//         children: [
//           TextButton(
//               onPressed: () {
//                _getLocation();
//               },
//               child: Text('add my location')),
//           TextButton(
//               onPressed: () {
//                _listenLocation();
//               },
//               child: Text('enable live location')),
//           TextButton(
//               onPressed: () {
//                _stopListening();
//               },
//               child: Text('stop live location')),
//           Expanded(
//               child: StreamBuilder(
//                 stream:
//                 FirebaseFirestore.instance.collection('location').snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   return ListView.builder(
//                       itemCount: snapshot.data?.docs.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title:
//                           Text(snapshot.data!.docs[index]['name'].toString()),
//                           subtitle: Row(
//                             children: [
//                               Text(snapshot.data!.docs[index]['latitude']
//                                   .toString()),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(snapshot.data!.docs[index]['longitude']
//                                   .toString()),
//                             ],
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.directions),
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) =>
//                                       LocationTrackingView(snapshot.data!.docs[index].id)));
//                             },
//                           ),
//                         );
//                       });
//                 },
//               )
//
//
//
//           ),
//         ],
//       ),
//     );
//   }
// }
