import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/hire_customize_bus.dart';
import 'package:new_app/phone_verification_screen.dart';
import 'package:new_app/services/cloude_firestore.dart';
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
import 'commonDeawer/drawer_widget_sereen.dart';
import 'gabtoli_bus_start_time_test.dart';

class NewHomeScreen extends StatefulWidget {
  static const routeName = '/homeNew';

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService fire = FirestoreService();
  late User user;

  // signOut method..
  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = (await _firebaseAuth.currentUser)!;
  }

  @override
  void initState() {
    fire.showUserData();
    fire.showUserPhone();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Bus'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          TextButton(
            child: Row(
              children: <Widget>[Icon(Icons.settings)],
            ),
            style:TextButton.styleFrom(textStyle: TextStyle(color: Colors.white)),
            onPressed: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(GabtoliBusTimeShow.routeName);
            },
          )
        ],
      ),
      drawer: DrawerTest(),
      body: GoogleMapApp(
        title: '',
      ),
    );
  }
}
