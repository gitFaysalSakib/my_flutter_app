import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

import 'location_service.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';


class LocationController extends GetxController{
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    print('valu ok');

    if(text != null && text.isNotEmpty) {
      print('valu ok 1');

      http.Response response = await getLocationData(text);
      print('valu ok 2');

      var data = jsonDecode(response.body.toString());
      print('valu ok 3');

      print(data);
      print("my status is "+data["status"]);
      if ( data['status']== 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction)
        => _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        print('valu null');
        // ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

}