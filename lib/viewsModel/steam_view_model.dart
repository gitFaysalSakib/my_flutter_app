import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/services/cloude_firestore.dart';
import 'package:stacked/stacked.dart';

class StreamViewExampleModel extends StreamViewModel<QuerySnapshot>{
  final FirestoreService fire = FirestoreService();

  @override
  Stream<QuerySnapshot> get stream =>  getStreamFrom();
 // Stream<QuerySnapshot> get stream1 =>  getStreamUserPhone();


  Stream<QuerySnapshot> getStreamFrom(){

    return fire.getData();
  }

  // Stream<QuerySnapshot> getStreamUserPhone(){
  //   return fire.getDataUserPhone();
  // }

  // Future<void> getStreamSave(){
  //   return fire.saveData();
  // }



}