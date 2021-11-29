// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:location_platform_interface/location_platform_interface.dart';
//
// import 'google_map_api_screen.dart';
//
//
// class LocationTracking extends StatefulWidget {
//   static const routeName = '/locationTrack';
//
//   @override
//   _LocationTrackingState createState() => _LocationTrackingState();
// }
//
// class _LocationTrackingState extends State<LocationTracking> {
//
//   LatLng sourceLocation = LatLng(23.804812, 90.3530069);
//   LatLng destinationLatlng = LatLng(28.431626, 77.002475);
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   Set<Marker> _marker = Set<Marker>();
//
//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   late PolylinePoints polylinePoints;
//
//   late StreamSubscription<LocationData> subscription;
//   LocationData? currentLocation;
//
//   late LocationData destinationLocation;
//   late Location location;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     location = Location();
//     polylinePoints = PolylinePoints();
//
//     subscription =location.onLocationChanged.listen((clocation) {
//       currentLocation = clocation;
//     });
//
//     setInitialLocation();
//
//   }
//
//
//
//   void setInitialLocation() async {
//     currentLocation = await location.getLocation();
//
//     destinationLocation = LocationData.fromMap({
//       "latitude": destinationLatlng.latitude,
//       "longitude": destinationLatlng.longitude,
//     });
//   }
//
//
//   void showLocationPins(){
//     var sourceposition = LatLng(
//         currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);
//
//     var destinationPosition =
//     LatLng(destinationLatlng.latitude, destinationLatlng.longitude);
//
//     _marker.add(Marker(
//       markerId: MarkerId('sourcePosition'),
//       position: sourceposition,
//     ));
//
//     _marker.add(
//       Marker(
//         markerId: MarkerId('destinationPosition'),
//         position: destinationPosition,
//       ),
//     );
//
//     setPolylinesInMap();
//
//   }
//
//
//   void setPolylinesInMap() async{
//     var result = await polylinePoints.getRouteBetweenCoordinates(
//       GoogleMapApi().url,
//       PointLatLng(
//           currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
//       PointLatLng(destinationLatlng.latitude, destinationLatlng.longitude),
//     );
//
//
//     if (result.points.isNotEmpty){
//       result.points.forEach((pointLatLng){
//         polylineCoordinates
//             .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
//       });
//     }
//
//     setState(() {
//       _polylines.add(Polyline(
//         width: 5,
//         polylineId: PolylineId('polyline'),
//         color: Colors.blueAccent,
//         points: polylineCoordinates,
//       ));
//     });
//   }
//
//
//   void updatePinsOnMap() async{
//     CameraPosition cameraPosition = CameraPosition(
//       zoom: 20,
//       tilt: 80,
//       bearing: 30,
//       target: LatLng(
//           currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
//     );
//
//
//     final GoogleMapController controller = await _controller.future;
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//
//     var sourcePosition = LatLng(
//         currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);
//
//
//     setState(() {
//       _marker.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');
//       _marker.add(Marker(
//         markerId: MarkerId('sourcePosition'),
//         position: sourcePosition,
//       ));
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     CameraPosition initialCameraPosition = CameraPosition(
//       zoom: 20,
//         tilt: 80,
//         bearing: 30,
//         target: currentLocation != null
//             ? LatLng(currentLocation!.latitude ?? 0.0,
//             currentLocation!.longitude ?? 0.0)
//             : LatLng(0.0, 0.0),
//     );
//
//
//     return SafeArea(
//       child: Scaffold(
//         body: GoogleMap(
//           markers: _marker,
//           polylines: _polylines,
//           mapType: MapType.normal,
//           initialCameraPosition: initialCameraPosition,
//             onMapCreated: (GoogleMapController controller){
//               _controller.complete(controller);
//
//               showLocationPins();
//             }
//         ),
//       ),
//
//     );
//   }
// }
