import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/hire_customize_bus.dart';
import 'package:new_app/phone_verification_screen.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './home_screen_customlist.dart';
import './login_screen.dart';
import './profile_edit_screen.dart';
import './seat_booking_screen.dart';
import './store_seat_booked_value.dart';
import './গাবতলী_bus_scheduleList_screen.dart';
// import './available_bus_schedule_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import './google_map_screen.dart';
import './signUp_screen.dart';
import './personal_info_setup_screen.dart';
import './myProfile_screen_List.dart';
import 'bus_schedule_screen.dart';
import 'gabtoli_bus_start_time_test.dart';

class NewHomeScreen extends StatefulWidget {
  static const routeName = '/homeNew';

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  CollectionReference usersProfile =
      FirebaseFirestore.instance.collection('profile');
  CollectionReference usersPhone =
      FirebaseFirestore.instance.collection('UserPhoneNumber');

  Map userPersonalData = {'firstName': '', 'lastName': ''};
  Map userPhoneNumber = {'PhoneNumber': ''};


  late String getLastNameFirebase ='';
  late String getFirstNameFirebase = '' ;
  late String getPhoneNumber = '';

  // signOut method..
  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = (await _firebaseAuth.currentUser)!;
  }

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


  // User pick-up location and destination show front page...


  @override
  void initState() {
    showUserData();
    showUserPhone();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Bus'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Icon(Icons.settings)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(GabtoliBusTimeShow.routeName);

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


            //My Profile Page link....
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
                  // _signOut(),

                }
            ),

          ],
        ),
      ),
     body: GoogleMapApp(title: '',),
    );
  }
}
