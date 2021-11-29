import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
final CollectionReference collectionRef =
FirebaseFirestore.instance.collection("profile");
final CollectionReference collectionRef2 =
FirebaseFirestore.instance.collection("UserPhoneNumber");
final CollectionReference collectionRef3 =
FirebaseFirestore.instance.collection("userBookingTypeInfo");
final CollectionReference collectionRef4 =
FirebaseFirestore.instance.collection("bookedUsers");

final CollectionReference collectionRef5 =
FirebaseFirestore.instance.collection("busTimeTable");

final CollectionReference collectionRef6 =
FirebaseFirestore.instance.collection("busSeatUpdate");

final CollectionReference collectionRef7 =
FirebaseFirestore.instance.collection("busTimeTable");

final CollectionReference collectionRef8 =
FirebaseFirestore.instance.collection("hireBusInfo");




class FireStoreDataBase {
  List profileList = [];
  // final CollectionReference collectionRef =
  // FirebaseFirestore.instance.collection("profile");

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          profileList.add(result.data());
        }
      });

      return profileList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}

class FirestoreUserPhone{
  List userPhoneNumberList = [];
  // final CollectionReference collectionRef =
  // FirebaseFirestore.instance.collection("profile");

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef2.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          userPhoneNumberList.add(result.data());
        }
      });

      return userPhoneNumberList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }


}

class FirestoreUsersBookingType{

  List bookingType = [];
  // final CollectionReference collectionRef =
  // FirebaseFirestore.instance.collection("profile");

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef3.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          bookingType.add(result.data());
        }
      });

      return bookingType;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}

class FirestoreUserBookingDetails{

  List bookingDetails = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef4.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          bookingDetails.add(result.data());
        }
      });

      return bookingDetails;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}

class FirestoreBusDetails{
  List busDetails = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef5.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          busDetails.add(result.data());
        }
      });

      return busDetails;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }


}
class FirestoreBusSeatUpdate{

  List busSeatUpdate = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef6.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          busSeatUpdate.add(result.data());
        }
      });

      return busSeatUpdate;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}


class FirestoreAllBussSchedule{

  List busScheduleList = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef7.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          busScheduleList.add(result.data());
        }
      });

      return busScheduleList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}
class FirestoreHireBusData {

  List hireBusData = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef8.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          hireBusData.add(result.data());
        }
      });

      return hireBusData;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}

class FirestoreGabtoliTimeShow{

  List gabtoliTimeList = [];
  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef5.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          gabtoliTimeList.add(result.data());
        }
      });

      return gabtoliTimeList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

}