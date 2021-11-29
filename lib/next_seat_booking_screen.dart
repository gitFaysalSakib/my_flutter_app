//import 'dart:html';
// import 'package:flutter_dropdown/flutter_dropdown.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import 'package:new_app/seat_booking_screen.dart';
import 'package:new_app/seat_booking_screen.dart';
import 'package:new_app/seat_booking_screen.dart';
import 'package:new_app/seat_booking_screen.dart';
import './home_screen_customlist.dart';
import './profile_edit_screen.dart';
import './seat_booking_screen.dart';
// import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_database/firebase_database.dart';
import './home_screen.dart';
// import './available_bus_schedule_screen.dart';
import './login_screen.dart';
import 'new_home_screen.dart';
import 'dart:math';


class NextSeatBooking extends StatefulWidget {
  static const routeName = '/nextseatbook';

  @override
  _NextSeatBookingState createState() => _NextSeatBookingState();
}

class _NextSeatBookingState extends State<NextSeatBooking> {
  //controller..
  String dayMoringRadio = '';
  String paymentRadioButton = '';
  late TextEditingController suggestionTextfieldController;
  late TextEditingController suggestionTextfieldControllerDestination;
  late TextEditingController paymentRadioStoreDatabse;
  late TextEditingController dayMorningDatabse;
  late TextEditingController busScheduleDropDown;
  late TextEditingController seatRadioButtonText;

  String seatRadio1 = '';

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late User user;

  //create 2 dropdown variable for store One value from List value..

  //Call firebase  store user profile table...
  CollectionReference busTimeTableFireStore =
      FirebaseFirestore.instance.collection('busTimeTable');

  // create a Map for retrieve data bustimetable..
  Map busTimeTableData = {'bus_number': ''};

  CollectionReference busTimeTableUpdateFireStore =
      FirebaseFirestore.instance.collection('busSeatUpdate');

  CollectionReference bookedUsersFireStore =
      FirebaseFirestore.instance.collection('bookedUsers');


  void randomNumber(){
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    print(randomNumber);
  }

  Map busTimeTableUpdateData = {
    'bus_number': '',
    'current_seat': '',
  };

  String userPickupLocation = '';
  late String userDestination;
  late String userSelectBusTime;
  int userBusSeatsQuantity = 0;
  String busNumberFromFireStore = '';
  String busNumberUpdateFireStore = '';
  int busCurrentSeatUpdate = 0;
  String currentSeatTest = '';
  int userInputSeats = 0;

  void sucessfullMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Successfully Booked Your Seat'),
            content: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(NewHomeScreen.routeName);
                    },
                    child: Text('ok'))
              ],
            ),
          );
        });
  }

  Future<void> addUserBookingInfo() async {

    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    String randomString = randomNumber.toString();
    print(randomNumber);

    String userPickupLocation = suggestionTextfieldController.text;

    print(userPickupLocation);
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    String conStringUserInputSeat = userInputSeats.toString();

    Map<String, String> userBusBookedInfo = {
      'booked_quantity': conStringUserInputSeat,
      'bus_number': busNumberUpdateFireStore,
      'destination': userDestination,
      'pick_location': userPickupLocation,
      'pick_time': userSelectBusTime,
      'ticket_number': randomString,
      'userID': getUserID
    };
    bookedUsersFireStore
        .add(userBusBookedInfo)
        .then((value) => print('add'))
        .catchError((error) => print('fail:$error'));
    print(userBusBookedInfo);
    print(getUserID);

  }

  Future<void> checkBusSeatCorrect() async {
    if (newSelectedLocationNew == null ||
        newSelectedDestinationNew == null ||
        newSelectedPickUpTime == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Please Input Your Data'),
              content: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(NextSeatBooking.routeName);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            );
          });
    } else {
      suggestionTextfieldController.text = newSelectedLocationNew!;
      busScheduleDropDown.text = newSelectedPickUpTime!;
      suggestionTextfieldControllerDestination.text =
          newSelectedDestinationNew!;

      userPickupLocation = suggestionTextfieldController.text;
      userSelectBusTime = busScheduleDropDown.text;
      userDestination = suggestionTextfieldControllerDestination.text;

      // print(userPickupLocation);

      String storeDocumentID;

      // userPickupLocation = suggestionTextfieldController.text;

      int setUpdateSeatFireStore = 0;
      userInputSeats = int.parse(seatRadio1);
      String id;
      try {
        // this code query for check user location and bus schedule....
        var response = await busTimeTableFireStore
            .where('pick_up_location', isEqualTo: userPickupLocation)
            .where('pick_up_time', isEqualTo: userSelectBusTime)
            .get();
       print(userPickupLocation);
        print(userSelectBusTime);

        if (response.docs.length > 0) {
          setState(() async {
            busNumberFromFireStore =
                busTimeTableData['bus_number'] = response.docs[0]['bus_number'];
            print(busNumberFromFireStore);

            var responseNew = await busTimeTableUpdateFireStore
                .where('bus_number', isEqualTo: busNumberFromFireStore)
                .get()
                .then((QuerySnapshot snapshot) => {
                      snapshot.docs.forEach((DocumentSnapshot doc) {
                        storeDocumentID = doc.id;
                        print(storeDocumentID);

                        busNumberUpdateFireStore =
                            busTimeTableUpdateData['bus_number'] =
                                snapshot.docs[0]['bus_number'];
                        print(busNumberUpdateFireStore);

                        // busCurrentSeatUpdate =
                        //     busTimeTableUpdateData['current_seat'] =
                        //         snapshot.docs[0]['current_seat'];

                        //new..
                        // currentSeatTest =
                        //     busTimeTableUpdateData['total_bus_seats'] =
                        //         snapshot.docs[0]['total_bus_seats'];

                        currentSeatTest =
                        busTimeTableUpdateData['current_seat'] =
                        snapshot.docs[0]['current_seat'];

                        //new..
                        busCurrentSeatUpdate = int.parse(currentSeatTest);

                        //new..
                        print(currentSeatTest);
                        print(busCurrentSeatUpdate);



                        if (busCurrentSeatUpdate >= userInputSeats) {
                          setUpdateSeatFireStore =
                              busCurrentSeatUpdate - userInputSeats;

                          //new..
                          String updateSeatConTOString = setUpdateSeatFireStore.toString();
                          print(updateSeatConTOString);

                          // Map<String, int> data = <String, int>{
                          //   'current_seat': setUpdateSeatFireStore,
                          // };

                         // new..
                          Map<String, String> dataTest = <String, String>{
                            'current_seat': updateSeatConTOString,
                          };
                         // print(dataTest);

                          // busTimeTableUpdateFireStore
                          //     .doc(storeDocumentID)
                          //     .set(data, SetOptions(merge: true))
                          //     .then((value) => print('Update'))
                          //     .catchError((error) => print('fail:$error'));


                          //new..
                          busTimeTableUpdateFireStore
                              .doc(storeDocumentID)
                              .set(dataTest, SetOptions(merge: true))
                              .then((value) => print('Update'))
                              .catchError((error) => print('fail:$error'));

                          //after booking user booking info store ....
                          addUserBookingInfo();
                          sucessfullMessage();
                        } else {

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sorry seats or Schedule not unavailable'"\n"
                                      'please choose another Schedule '),
                                  content: Column(
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigator.of(context)
                                          //     .pushReplacementNamed(NextSeatBooking.routeName);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              });


                        }

                        print(busNumberUpdateFireStore);
                        print(busCurrentSeatUpdate);
                        print(setUpdateSeatFireStore);
                      })
                    });
          });
          // print(busNumberFromFireStore);

          // print('hhhhhiiiiiiiiii');


        }
      } on FirebaseException catch (e) {
        print(e);
      } catch (error) {
        print(error);
      }
    }
  }

  String selectLocation = '';
  String selectDestination = '';
  List<String> _mySelectedLocation = [
    'গাবতলী বাস স্ট্যান্ড',
    'শ্যামলী বাস স্ট্যান্ড',
    'কলেজ গেট বাস স্ট্যান্ড',
    'ধানমন্ডি বাস স্ট্যান্ড',
    'কলাবাগান বাস স্ট্যান্ড',
    'সাইন্স ল্যাব বাস স্ট্যান্ড',
    'নিউ মার্কেট বাস স্ট্যান্ড',
    'আজিমপুর বাস স্ট্যান্ড',
    'গুলিস্তান বাস স্ট্যান্ড',
  ];

  String? newSelectedLocationNew;
  String? newSelectedDestinationNew;
  String? newSelectedPickUpTime;

  // final _mySelectedLocationNew = [
  //   'গাবতলী বাস স্ট্যান্ড',
  //   'শ্যামলী বাস স্ট্যান্ড',
  // ];

  String selectBusSchedule = '';
  List<String> _myBusSchedule = [
    '7.00 - 7.15am',
    '7.30 - 7.45 am',
    '8.00 - 8.15 am',
    '8.30 - 8.45 am',
    '9.00 - 9.15 am',
    '9.30 - 9.45 am',
  ];

  void count() {
    _mySelectedLocation[0] = 's';
    print(_mySelectedLocation[0]);
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = await _firebaseAuth.currentUser!;
    // String id = user.uid;
  }

//Create new function for store value in firebase..
  late DatabaseReference _ref;

  void saveCustomerPass() {
    print(suggestionTextfieldController.text);
    if (suggestionTextfieldController.text == null ||
        suggestionTextfieldControllerDestination.text == null ||
        paymentRadioButton == '' ||
        paymentRadioButton == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Please Input Your Data'),
              content: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(NextSeatBooking.routeName);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            );
          });
    } else {
      String pickLocation = suggestionTextfieldController.text;
      String destination = suggestionTextfieldControllerDestination.text;
      paymentRadioStoreDatabse.text = paymentRadioButton;
      String StorePaymentValue = paymentRadioStoreDatabse.text;
      dayMorningDatabse.text = dayMoringRadio;
      String storeDayMorningValue = dayMorningDatabse.text;
      String getUserEmail = '$finalEmailget';

      //print(pickLocation);
      //print("pickLocation");

      Map<String, String> storeCustomerData = {
        'pickLocation': pickLocation,
        'destination': destination,
        'StorePaymentValue': StorePaymentValue,
        'getUserEmail': getUserEmail,
        'storeDayMoringValue': storeDayMorningValue,

        // 'getDayBusTime':getDayBusTime,
      };
      _ref.push().set(storeCustomerData);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Your Successfully Booked Your Seat'),
              content: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(NewHomeScreen.routeName);
                      },
                      child: Text('ok'))
                ],
              ),
            );
          });

      print(storeCustomerData);
    }
  }

  @override
  void initState() {
    suggestionTextfieldController = TextEditingController();
    suggestionTextfieldControllerDestination = TextEditingController();
    paymentRadioStoreDatabse = TextEditingController();
    dayMorningDatabse = TextEditingController();
    busScheduleDropDown = TextEditingController();
    seatRadioButtonText = TextEditingController();

    seatRadioButtonText.text = seatRadio1;

    _ref = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/Location');

    // showUserData();
    // showUserPhone();
    super.initState();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));

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
              Navigator.of(context).pushReplacementNamed(SeatBooking.routeName);
            },
          ),
          title: Text('Booked Your Seat'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Icon(Icons.home)],
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(NewHomeScreen.routeName);
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Your Pickup Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ),

                //textAlign: TextAlign.center,),
                SizedBox(
                  height: 5.0,
                ),

                Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: DropdownButton<String>(
                      value: newSelectedLocationNew,
                      hint: Text('Pick-Up Point'),
                      isExpanded: true,
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: _mySelectedLocation.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          newSelectedLocationNew = value;
                         // print(newSelectedLocationNew);
                        });
                      }),
                ),

                SizedBox(
                  height: 10.0,
                ),
                Text('Your Destination',
                    style: TextStyle(fontSize: 16, color: Colors.teal)),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: DropdownButton<String>(
                      value: newSelectedDestinationNew,
                      hint: Text('Destination'),
                      isExpanded: true,
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: _mySelectedLocation.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        // setState(() {
                        //   if (suggestionTextfieldController.text ==
                        //       suggestionTextfieldControllerDestination.text) {
                        //     // selectDestination =null;
                        //     // print('hiii');
                        //     showDialog(
                        //         context: context,
                        //         builder: (context) {
                        //           return AlertDialog(
                        //             title:
                        //                 Text('Please Input Correct Location'),
                        //             content: Column(
                        //               children: <Widget>[
                        //                 ElevatedButton(
                        //                     onPressed: () {
                        //                       Navigator.of(context)
                        //                           .pushReplacementNamed(
                        //                               NextSeatBooking
                        //                                   .routeName);
                        //                     },
                        //                     child: Text('ok'))
                        //               ],
                        //             ),
                        //           );
                        //         });
                        //   } else {
                        //     newSelectedDestinationNew = value;
                        //     print('hi');
                        //   }
                        // });

                        // if (suggestionTextfieldControllerDestination.text
                        //         == suggestionTextfieldController.text) {
                        //   // selectDestination =null;
                        //   // print('hiii');
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) {
                        //         return AlertDialog(
                        //           title:
                        //           Text('Please Input Correct Location'),
                        //           content: Column(
                        //             children: <Widget>[
                        //               ElevatedButton(
                        //                   onPressed: () {
                        //                     Navigator.of(context)
                        //                         .pushReplacementNamed(
                        //                         NextSeatBooking
                        //                             .routeName);
                        //                   },
                        //                   child: Text('ok'))
                        //             ],
                        //           ),
                        //         );
                        //       });
                        // } else {
                        //   newSelectedDestinationNew = value;
                        //   print('hi');
                        // }
                        setState(() {
                          newSelectedDestinationNew = value;
                        });
                        // newSelectedDestinationNew = value;
                      }),
                ),

                SizedBox(
                  height: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Your Suitable Bus Schedule',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, color: Colors.teal),
                  ),
                ),
                SizedBox(
                  width: 90,
                ),

                Container(
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: DropdownButton<String>(
                      value: newSelectedPickUpTime,
                      hint: Text('Pick-up Time'),
                      isExpanded: true,
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: _myBusSchedule.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          newSelectedPickUpTime = value;
                        });
                      }),
                ),



                SizedBox(
                  height: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'How Many Seats Do You Need',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16.0, color: Colors.teal),
                  ),
                ),

                SizedBox(
                  height: 0.0,
                ),

                Row(
                  children: <Widget>[
                    Radio(
                        value: '1',
                        groupValue: seatRadio1,
                        onChanged: (value) {
                          setState(() {
                            this.seatRadio1 = value.toString();
                            // int a = 1;
                            // var  s= int.parse(value);
                            // print(s+a);
                            // storeBookedData2.duration =groupValue1;
                            // print(storeBookedData2.duration);
                          });
                        }),
                    Text(
                      '1',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      width: 40,
                    ),

                    //
                    Radio(
                        value: '2',
                        groupValue: seatRadio1,
                        onChanged: (value) {
                          setState(() {
                            this.seatRadio1 = value.toString();
                            print(this.seatRadio1);
                          });
                        }),
                    Text(
                      '2',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Radio(
                        value: '3',
                        groupValue: seatRadio1,
                        onChanged: (value) {
                          setState(() {
                            this.seatRadio1 = value.toString();
                            print(this.seatRadio1);
                          });
                        }),
                    Text(
                      '3',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        //  saveCustomerPass();
                        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                        // checkBusSeat();
                        print('hiiiiiiii');

                        checkBusSeatCorrect();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'BOOK',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      )),
                )

                //FloatingActionButton(onPressed: _checkDestination),
                //Text(selectLocation, style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,
              ],
            ),
          ),
        )

        );
  }
}
