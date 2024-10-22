import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'location_controller_search_location.dart';
class LocationSearchDialog extends StatefulWidget {
   final GoogleMapController? mapController;

  const LocationSearchDialog({Key? key,  required this.mapController}) : super(key: key);

  @override
  State<LocationSearchDialog> createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  late final TextEditingController _controller;
@override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top : 150),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(width: 350, child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'search_location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0)

                ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: 16, color: Theme.of(context).disabledColor,
                  ),
                filled: true, fillColor: Theme.of(context).cardColor,
              ),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,

                ),
            ),
          suggestionsCallback: ( pattern) async {
            return await Get.find<LocationController>().searchLocation(context, pattern);

          },
          itemBuilder: (context, Prediction suggestion) {
              return Padding(padding: EdgeInsets.all(10),
                child: Row(children: [
                  Icon(Icons.location_on),
                  Expanded(child: Text(
                      suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
                      )
                  )
                  )
                ],),
              );
          },
          onSuggestionSelected: (Prediction suggestion) {
            print("My location is "+suggestion.description!);
            //Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);

            Get.back();

          },
        )),
      ),
    );
  }
}
