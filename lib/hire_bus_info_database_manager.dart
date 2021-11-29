



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final CollectionReference collectionRef =
FirebaseFirestore.instance.collection("hireBusInfo");


class FireStoreDataBase {
  List hireBusinfoData = [];
  // final CollectionReference collectionRef =
  // FirebaseFirestore.instance.collection("profile");

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          hireBusinfoData.add(result.data());
        }
      });

      return hireBusinfoData;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}