import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_app/hire_customize_bus.dart';
import 'package:new_app/new_home_screen.dart';
// import 'package:new_app/personal_info_setup_screen.dart';
// import './home_screen_customlist.dart';
// import './profile_edit_screen.dart';
import './next_seat_booking_screen.dart';
// import './store_seat_booked_value.dart';
// import './available_bus_schedule_screen.dart';
import './login_screen.dart';
// import './home_screen.dart';
// import './available_day_schedule_screen.dart';
import './myProfile_screen_List.dart';
import 'bus_schedule_screen.dart';

class SeatBooking extends StatefulWidget {
  static const routeName = '/seatbook';

  //store vale into databse so using some variable and use class storebooked...
  // final StoreBookedData storeBookedData;
  //
  //SeatBooking({Key key, @required this.getDuration}) : super(key: key);

  @override
  _SeatBookingState createState() => _SeatBookingState();
}

class _SeatBookingState extends State<SeatBooking> {
  late TextEditingController radioTimetextController;
  late TextEditingController radioTypetextController;

  late DatabaseReference ref;
  late DatabaseReference ref2;

  //Query _logRef;
  final fireStore = FirebaseDatabase.instance.reference().child('Login');
  var retriveEmail = "";
  String logEmail1 = "";

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  CollectionReference usersProfile =
      FirebaseFirestore.instance.collection('profile');
  CollectionReference usersPhone =
      FirebaseFirestore.instance.collection('UserPhoneNumber');

  CollectionReference bookedUsersTypeFireStore =
      FirebaseFirestore.instance.collection('userBookingTypeInfo');

  Map userPersonalData = {'firstName': '', 'lastName': ''};
  Map userPhoneNumber = {'PhoneNumber': ''};

  String getFirstNameFirebase = '';
  String getLastNameFirebase = '';
  String getPhoneNumber = '';

  String groupValue1 = '';
  String groupValue2 = '';

  // String getPassType;
  String getDuration = '';
  String getPassType = '';

  // User data show on dashboard...
  Future<void> showUserData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    try {
      var response =
          await usersProfile.where('LogInUserID', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getFirstNameFirebase =
              userPersonalData['firstName'] = response.docs[0]['firstName'];
          getLastNameFirebase =
              userPersonalData['lastName'] = response.docs[0]['lastName'];
        });
      }
      print(getFirstNameFirebase);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  // User Phone Number show on dashboard...
  Future<void> showUserPhone() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    print(userId);
    try {
      var response = await usersPhone.where('UserId', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getPhoneNumber =
              userPhoneNumber['PhoneNumber'] = response.docs[0]['PhoneNumber'];
        });
      }
      print(getPhoneNumber);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  // StoreBookedData storeBookedData2;

  //this saveData function work for store value in database..
  void saveData() {
    if (groupValue1 == null || groupValue2 == null) {
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
                          .pushReplacementNamed(SeatBooking.routeName);
                    },
                    child: Text('Ok'),
                  ),
                ],
              ),
            );
          });
      print('no data');
    } else {
      user = _firebaseAuth.currentUser!;
      String userId = user.uid;
      radioTimetextController.text = groupValue1;
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

      // ref.push().set(storeBookingType);
      print(storeBookingType);
      // print(getDuration);
      // Navigator.of(context).pushReplacementNamed(NextSeatBooking.routeName);
    }
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = await _firebaseAuth.currentUser!;
    // String id = user.uid;
  }

  @override
  void initState() {
    radioTimetextController = TextEditingController();
    radioTypetextController = TextEditingController();
    ref = FirebaseDatabase.instance.reference().child('StoreValue');
    ref2 = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/Login');

    //final reff = fireStore.reference().child('daily-bus-912ad-default-rtdb/Login');

    showUserData();
    showUserPhone();
    super.initState();
  }

  void Checkvalue() {
    // reff.child('logEmail').once().then((DataSnapshot data){
    //   retriveEmail =data.value;
    //   print(retriveEmail);
    //
    // });
  }

  //

  @override
  Widget build(BuildContext context) {
    //  groupValue1 = storeBookedData2.duration;
    final reff = fireStore.reference().child('Login');

    //print(retriveEmail);

    return Scaffold(
      appBar: AppBar(
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.cyan[900]!, Colors.cyan[900]!])),
              child: Text(
                '$getFirstNameFirebase' +
                    '$getLastNameFirebase' +
                    '\n$getPhoneNumber',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),

            ListTile(
                leading: const Icon(Icons.person, size: 28.0,),
                title: const Text("MY PROFILE", style: TextStyle(fontSize: 18.0),),
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacementNamed(MyProfileScreenList.routeName),
                }
            ),
            ListTile(
                leading: const Icon(Icons.bus_alert, size: 28.0,),
                title: const Text("BUY BUSS PASS", style: TextStyle(fontSize: 18.0),),
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacementNamed(SeatBooking.routeName),
                }
            ),
            ListTile(
                leading: const Icon(Icons.schedule, size: 28.0,),
                title: const Text("BUS SCHEDULE", style: TextStyle(fontSize: 18.0),),
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacementNamed(NewBusSchedule.routeName),
                }
            ),
            ListTile(
                leading: const Icon(Icons.bus_alert, size: 28.0,),
                title: const Text("Hire A Bus", style: TextStyle(fontSize: 18.0),),
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacementNamed(HireCustomBus.routeName),
                }
            ),
            ListTile(
                leading: const Icon(Icons.logout, size: 28.0,),
                title: const Text("LOG OUT", style: TextStyle(fontSize: 18.0),),
                onTap: () => {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName),
                }
            ),


          ],
        ),
      ),
      body: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Select Your Booking Duration',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 0.0,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: '1 WEEK',
                      groupValue: groupValue1,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue1 = value.toString();
                          print(this.groupValue1);
                          // storeBookedData2.duration =groupValue1;
                          // print(storeBookedData2.duration);
                        });
                      }),
                  Text(
                    '1 WEEK',
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
                      value: '1 MONTH',
                      groupValue: groupValue1,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue1 = value.toString();
                          print(this.groupValue1);
                        });
                      }),
                  Text(
                    '1 MONTH',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //Select Your Booking Category design
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Select Your Booking Category',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              Row(
                children: <Widget>[
                  Radio(
                      value: 'Student Pass',
                      groupValue: groupValue2,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue2 = value.toString();
                          print(this.groupValue2);
                        });
                      }),
                  Text(
                    'Student Pass',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  Radio(
                      value: 'General Pass',
                      groupValue: groupValue2,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue2 = value.toString();
                          print(this.groupValue2);
                        });
                      }),
                  Text(
                    'General Pass',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  Radio(
                      value: 'Disabled Pass',
                      groupValue: groupValue2,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue2 = value.toString();
                          print(this.groupValue2);
                        });
                      }),
                  Text(
                    'Disabled Pass',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(NextSeatBooking.routeName);
                      saveData();
                      Checkvalue();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    )),
              ),

              // ElevatedButton(onPressed: ()
              // {
              //   // reff.child('logEmail').once().then((DataSnapshot data){
              //   //   setState(() {
              //   //     retriveEmail = data.value;
              //   //   });
              //   //   print(data.value);
              //   // });
              //   //Navigator.of(context).pushReplacementNamed(NextSeatBooking.routeName);
              //  // saveData();
              //  // Checkvalue();
              //
              //   fireStore.child('logEmail').once().then((DataSnapshot snap){
              //     retriveEmail = snap.value;
              //    // print('logEmail :${snap.value}');
              //
              //   });
              // },
              //
              //
              //     child: Text('Next'),),
              // Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
