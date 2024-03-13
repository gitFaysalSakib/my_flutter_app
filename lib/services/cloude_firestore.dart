
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/next_seat_booking_screen.dart';
import 'package:new_app/seat_booking_screen.dart';

late String getLastNameFirebase = '';
late String getFirstNameFirebase = '';
late String getPhoneNumber = '';




class FirestoreService {

  String groupValue1 = '';
  String groupValue2 = '';

  String getDuration = '';
  String getPassType = '';

  String get getgroupValue1 => groupValue1;

  final CollectionReference reference =
      FirebaseFirestore.instance.collection('profile');
  final CollectionReference usersPhone =
      FirebaseFirestore.instance.collection('UserPhoneNumber');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 final CollectionReference bookedUsersTypeFireStore =
  FirebaseFirestore.instance.collection('userBookingTypeInfo');

  late User user;

  Map userPersonalData = {'firstName': '', 'lastName': ''};
  Map userPhoneNumber = {'PhoneNumber': ''};
  List dataStore = [];

  Stream<QuerySnapshot> getData() {
    // if(reference.snapshots['firstName']== ''){
    //
    // }else{
    //
    // }
    dataStore.add(reference.snapshots());

   print(dataStore);

    return reference.snapshots();
  }

  Stream<QuerySnapshot> getDataUserPhone() {
    return usersPhone.snapshots();
  }

  Future<void> getUserAcess() async {
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    print(getUserID);
    print("clude fire Store");
  }

  Future<void> showUserData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    try {
      var response =
          await reference.where('LogInUserID', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        getFirstNameFirebase =
            userPersonalData['firstName'] = response.docs[0]['firstName'];
        getLastNameFirebase =
            userPersonalData['lastName'] = response.docs[0]['lastName'];
      }
      print(getFirstNameFirebase);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Future<void> showUserPhone() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    print(userId);
    try {
      var response = await usersPhone.where('UserId', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        getPhoneNumber =
            userPhoneNumber['PhoneNumber'] = response.docs[0]['PhoneNumber'];
      }
      print(getPhoneNumber);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
  final SeatBooking _seatBooking = SeatBooking();

  //seat booking page store data on button click...
  void saveData() {
    if (groupValue1 == '' || groupValue2 == '') {
      print('no data');
    } else {
      user = _firebaseAuth.currentUser!;
      String userId = user.uid;
      radioTimetextController.text  = groupValue1;
      radioTypetextController.text = groupValue2;

      getDuration = radioTimetextController.text;
      getPassType = radioTypetextController.text;
      // String getUserEmail = '$finalEmailget';

      Map<String, String> storeBookingType = {
        'booking_duration': getDuration,
        'booking_type': getPassType,
        'userID': userId
      };
      bookedUsersTypeFireStore
          .add(storeBookingType)
          .then((value) => print('add'))
          .catchError((error) => print('fail:$error'));

      print('ok cloude fire store');
    }
  }

  Future<void> updateUserBookingType() async {
    String storeDocumentID;
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;

    radioTimetextController.text = groupValue1;
    radioTypetextController.text = groupValue2;

    getDuration = radioTimetextController.text;
    getPassType = radioTypetextController.text;

    var response = await bookedUsersTypeFireStore
        .where('userID', isEqualTo: getUserID)
        .get()
        .then((QuerySnapshot snapshot) => {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        storeDocumentID = doc.id;

        Map<String, String> storeBookingType = {
          'booking_duration': getDuration,
          'booking_type': getPassType,
          'userID': getUserID
        };

        bookedUsersTypeFireStore
            .doc(storeDocumentID)
            .set(storeBookingType, SetOptions(merge: true))
            .then((value) => print('Update'))
            .catchError((error) => print('fail:$error'));

        // Navigator.of(context)
        //     .pushReplacementNamed(NextSeatBooking.routeName);
      })
    });

    print(response);

    print('ok done');
  }

}
