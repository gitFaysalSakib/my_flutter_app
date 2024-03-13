import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String text) async {

  http.Response response;


  response = await http.post(

      Uri.parse("http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"),
    headers: {"Content-Type": "application/json"},
  );
  print(text);

  final responseData = json.decode(response.body);

  print('vale show'+ response.body);
  //print('sakibbbbbbbbbbb');

  return response;
}