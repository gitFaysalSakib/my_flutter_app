import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/services/cloude_firestore.dart';
import 'package:new_app/viewsModel/steam_view_model.dart';
import 'package:stacked/stacked.dart';
class StreamView extends StatefulWidget {
  static const routeName = '/streamView';

  const StreamView({Key? key}) : super(key: key);

  @override
  _StreamViewState createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {



  @override
  void initState() {

    super.initState();
  }
  final StreamViewExampleModel streamModel = StreamViewExampleModel();
  final FirestoreService fire = FirestoreService();




  late int i;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamViewExampleModel>.reactive(
        viewModelBuilder: () => StreamViewExampleModel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(),
          body: StreamBuilder<QuerySnapshot>(
            stream: model.stream,
            builder: (context, snapshot)=> ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) => ListTile(
                  title: Text(documentSnapshot ['firstName']),
                  subtitle: Text(documentSnapshot['lastName']),
                )).toList(),
              )
          ),
        ));

  }
}
