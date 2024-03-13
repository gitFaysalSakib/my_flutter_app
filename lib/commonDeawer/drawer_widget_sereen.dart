//drewer class....
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_app/new_home_screen.dart';
import 'package:new_app/services/cloude_firestore.dart';
import 'package:new_app/signUp_screen.dart';

import '../bus_schedule_screen.dart';
import '../google_sigin_provider.dart';
import '../hire_customize_bus.dart';
import '../login_screen.dart';
import '../myProfile_screen_List.dart';
import '../seat_booking_screen.dart';

class DrawerTest extends StatefulWidget {
  const DrawerTest({Key? key}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  final googleSignIn = GoogleSignIn();

  Future logOut() async {
    FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();



  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              leading: const Icon(
                Icons.person,
                size: 28.0,
              ),
              title: const Text(
                "MY PROFILE",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => {
                    Navigator.of(context)
                        .pushReplacementNamed(MyProfileScreenList.routeName),
                  }),
          ListTile(
              leading: const Icon(
                Icons.bus_alert,
                size: 28.0,
              ),
              title: const Text(
                "BUY BUSS PASS",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => {
                    Navigator.of(context)
                        .pushReplacementNamed(SeatBooking.routeName),
                  }),
          ListTile(
              leading: const Icon(
                Icons.schedule,
                size: 28.0,
              ),
              title: const Text(
                "BUS SCHEDULE",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => {
                    Navigator.of(context)
                        .pushReplacementNamed(NewBusSchedule.routeName),
                  }),
          ListTile(
              leading: const Icon(
                Icons.bus_alert,
                size: 28.0,
              ),
              title: const Text(
                "Hire A Bus",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => {
                    Navigator.of(context)
                        .pushReplacementNamed(HireCustomBus.routeName),
                  }),
          ListTile(
              leading: const Icon(
                Icons.logout,
                size: 28.0,
              ),
              title: const Text(
                "LOG OUT",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () => {
                    logOut(),
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is null!');
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      } else {
                        print('User is signed in!');
                        String id = user.uid;
                        print(id);
                        Navigator.of(context)
                            .pushReplacementNamed(NewHomeScreen.routeName);
                      }
                    }),
                    // Navigator.of(context)
                    //     .pushReplacementNamed(LoginScreen.routeName),

                    // _signOut(),
                  }),
        ],
      ),
    );
  }
}
