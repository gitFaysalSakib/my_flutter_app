import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import './signUp_screen.dart';
import 'dart:convert';
import './http_exception.dart';

class Authentication with ChangeNotifier {

  //Sign up data...
  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBlVM_laV1SmOEw7Fj_PhLPYmUKXVv2uKw';

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      //print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }





//Log in data...
  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBlVM_laV1SmOEw7Fj_PhLPYmUKXVv2uKw';

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      // print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //personal info input
  // Future<void> personalInfo(String firstName, String lastName, String gender) async {
  //   const url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBlVM_laV1SmOEw7Fj_PhLPYmUKXVv2uKw';
  //
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         body: json.encode({
  //           'firstName': firstName,
  //           'lastName': lastName,
  //           'gender': gender,
  //           'returnSecureToken': true,
  //         }));
  //
  //     final responseData = json.decode(response.body);
  //     // print(responseData);
  //
  //     if (responseData['error'] != null) {
  //       throw HttpException(responseData['error']['message']);
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }








}
