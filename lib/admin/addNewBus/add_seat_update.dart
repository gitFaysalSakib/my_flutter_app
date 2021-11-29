import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';
import '../responsive.dart';

class SeatUpdateScreen extends StatefulWidget {
  static const routeName = '/seatUpdate';

  const SeatUpdateScreen({Key? key}) : super(key: key);

  @override
  _SeatUpdateScreenState createState() => _SeatUpdateScreenState();
}

class _SeatUpdateScreenState extends State<SeatUpdateScreen> {
  //Controller for text field..
  late TextEditingController busNumber;
  late TextEditingController busTotalSeats;

  //Call firebase  store user profile table...

  CollectionReference busSeatUpdateTable =
      FirebaseFirestore.instance.collection('busSeatUpdate');

  Map getBusNumberData = {
    'bus_number': '',
  };

  String busNumberFirestore = '';

  Future<void> updateBusSeat() async {
    String storeDocumentID;

    String getBusNumber = busNumber.text;
    String getBusSeatUpdate = busTotalSeats.text;

    try {
      var response = await busSeatUpdateTable
          .where('bus_number', isEqualTo: getBusNumber)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((DocumentSnapshot doc) {
                  storeDocumentID = doc.id;
                  print(storeDocumentID);

                  busNumberFirestore = getBusNumberData['bus_number'] =
                      snapshot.docs[0]['bus_number'];

                  Map<String, String> data = <String, String>{
                    'bus_number': busNumberFirestore,
                    'current_seat': getBusSeatUpdate,
                  };

                  busSeatUpdateTable
                      .doc(storeDocumentID)
                      .set(data, SetOptions(merge: true))
                      .then((value) => print('Update'))
                      .catchError((error) => print('fail:$error'));
                })
              });
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }

    //print(firstName);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully Updated'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Check Bus Seat Update Page'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(LoginScreenAdmin.routeName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));

  void initState() {
    busNumber = TextEditingController();
    busTotalSeats = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(
              height: 30,
              child: Text(
                'Update Bus Seat',
                style: TextStyle(fontSize: 20),
              ),
            ),

            // const Text("User Booking Details"),

            // const Text("User Booking"),
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: ListView(
                  children: [
                    Text(
                      "",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Form(
                        //key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Bus Number'),
                                keyboardType: TextInputType.name,
                                controller: busNumber,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Input Bus Seat'),
                                keyboardType: TextInputType.name,
                                controller: busTotalSeats,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () {
                                  updateBusSeat();
                                  _showMyDialog();
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add New"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
