// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// class GoogleMapGeoLocator extends StatefulWidget {
//   static const routeName = '/geoLocator';
//
//   @override
//   _GoogleMapGeoLocatorState createState() => _GoogleMapGeoLocatorState();
// }
//
// class _GoogleMapGeoLocatorState extends State<GoogleMapGeoLocator> {
//
//
//   void getGeolocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever){
//       print('permission not giver');
//     }else{
//       Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//       print("longitude:" + currentPosition.longitude.toString() );
//       print("latitude:" + currentPosition.latitude.toString() );
//
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: ElevatedButton(
//             onPressed: (){
//               getGeolocation();
//             },
//             child: Text('get Location'),
//           ),
//
//         ),
//       ),
//     );
//   }
// }
