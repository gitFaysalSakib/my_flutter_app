

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/phone_verification_screen.dart';
import './profile_edit_screen.dart';
import 'package:http/http.dart' as http;
import './home_screen.dart';
import 'package:new_app/new_home_screen.dart';

import 'myProfile_screen_List.dart';

class MyBookedTicket extends StatefulWidget {
  static const routeName = '/myBookingTicket';
  // Call NewHomeScreen Class as a Object..

  @override
  _MyBookedTicketState createState() => _MyBookedTicketState();
}

class _MyBookedTicketState extends State<MyBookedTicket> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Call query for profile edit data show on app page..
  //Query _query;
  //

  //Controller for text field..
  late TextEditingController pickUplocation;
  late TextEditingController destination;
  late TextEditingController pickupTime;
  late TextEditingController seatQuantity;
  late TextEditingController busNumber;
  late TextEditingController ticketNumber;




  //Gender group value variable..
  // String genderRadioGroup = '';

  //Create new function for data store in firebase..
  late DatabaseReference _ref;

  //firebase Auth for user get..
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;
  // late String getPhoneNumber;

// create a Map for retrieve data..
  Map userBookingInfo = {
    'pick_location': '',
    'destination': '',
    'pick_time':'',
    'booked_quantity':'',
    'bus_number':'',
    'ticket_number':'',
  };

  final firebaseStore = FirebaseFirestore.instance;

  //Call firebase  store user profile table...
  CollectionReference userBookedTable =
  FirebaseFirestore.instance.collection('bookedUsers');




  late String getPickLocationFirebase;
  late String getDestinationFirebase;
  late String getPickTimeFirebase;
  late String getSeatQuantityFirebase;
  late String getBusNumberFirebase;
  late String getTicketNumberFirebase;




  //method for personal data retrieve from firebase and show personal form...
  Future<void> getUserBookingTIcket() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;

    getPickLocationFirebase = pickUplocation.text;
    getDestinationFirebase = destination.text;
    getPickTimeFirebase = pickupTime.text;
    getSeatQuantityFirebase = seatQuantity.text;
    getBusNumberFirebase = busNumber.text;
    getTicketNumberFirebase = ticketNumber.text;




    try {
      var response =
      await userBookedTable.where('userID', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getPickLocationFirebase =
          userBookingInfo['pick_location'] = response.docs[0]['pick_location'];
          getDestinationFirebase =
          userBookingInfo['destination'] = response.docs[0]['destination'];
          getPickTimeFirebase =
          userBookingInfo['pick_time'] = response.docs[0]['pick_time'];
          getSeatQuantityFirebase =
          userBookingInfo['booked_quantity'] = response.docs[0]['booked_quantity'];
          getBusNumberFirebase =
          userBookingInfo['bus_number'] = response.docs[0]['bus_number'];
          getTicketNumberFirebase =
          userBookingInfo['ticket_number'] = response.docs[0]['ticket_number'];

          //if logic check database null value and set database value in TextField..
          if (getPickLocationFirebase == null) {
            pickUplocation = TextEditingController(text: '');
          } else {
            pickUplocation = TextEditingController(text: '$getPickLocationFirebase');
          }

          if (getDestinationFirebase == null) {
            destination = TextEditingController(text: '');
          } else {
            destination = TextEditingController(text: '$getDestinationFirebase');
          }

          if (getPickTimeFirebase == null) {
            pickupTime = TextEditingController(text: '');
          } else {
            pickupTime = TextEditingController(text: '$getPickTimeFirebase');
          }

          if (getSeatQuantityFirebase == null) {
            seatQuantity = TextEditingController(text: '');
          } else {
            seatQuantity = TextEditingController(text: '$getSeatQuantityFirebase');
          }

          if (getBusNumberFirebase == null) {
            busNumber = TextEditingController(text: '');
          } else {
            busNumber = TextEditingController(text: '$getBusNumberFirebase');
          }
          if (getTicketNumberFirebase == null) {
            ticketNumber = TextEditingController(text: '');
          } else {
            ticketNumber = TextEditingController(text: '$getTicketNumberFirebase');
          }
        });
      }
      print(getBusNumberFirebase);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  //submit button method..


  @override
  void initState() {
    pickUplocation = TextEditingController();
    destination = TextEditingController();
    pickupTime = TextEditingController();
    seatQuantity = TextEditingController();
    busNumber = TextEditingController();
    ticketNumber = TextEditingController();






    super.initState();

    setState(() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is null!');
        } else {
          print('User is signed in!');
          String id = user.uid;
          print(id);
        }
      });

      getUserBookingTIcket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(MyProfileScreenList.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        title: Text('My Ticket Report'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "My Ticket Card",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.pexels.com/photo/stylish-focused-woman-leaned-on-hand-at-table-in-countryside-5368679/"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            //color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.teal),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //First Name field...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Pick-Up Location'),
                      keyboardType: TextInputType.name,
                      controller: pickUplocation,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),

                    //Last Name...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Destination'),
                      keyboardType: TextInputType.name,
                      controller: destination,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Pick-Up Time'),
                      keyboardType: TextInputType.name,
                      controller: pickupTime,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Seat Quantity'),
                      keyboardType: TextInputType.name,
                      controller: seatQuantity,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Bus Number'),
                      keyboardType: TextInputType.name,
                      controller: busNumber,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Ticket Number'),
                      keyboardType: TextInputType.name,
                     controller: ticketNumber,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
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
