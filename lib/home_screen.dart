// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'authentication.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import './home_screen_customlist.dart';
// import './login_screen.dart';
// import './profile_edit_screen.dart';
// import './seat_booking_screen.dart';
// import './store_seat_booked_value.dart';
// import './গাবতলী_bus_scheduleList_screen.dart';
// import './available_bus_schedule_screen.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import './google_map_screen.dart';
// import './signUp_screen.dart';
// import './available_day_schedule_screen.dart';
// import './personal_info_setup_screen.dart';
// import './myProfile_screen_List.dart';
//
// class HomeScreen extends StatelessWidget {
//   static const routeName = '/home';
//
//   //Login info show from database
//   // Query _logRef;
//
//   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User user;
//
//   CollectionReference usersProfile =
//       FirebaseFirestore.instance.collection('profile');
//   Map userPersonalData = {'firstName': '', 'lastName': ''};
//   String getFirstNameFirebase;
//   String getLastNameFirebase;
//
//   // signOut method..
//   Future<void> _signOut() async {
//     await _firebaseAuth.signOut();
//     user = await _firebaseAuth.currentUser;
//   }
//
//   // User data show on dashboard...
//   Future<void> showUserData() async {
//     user = _firebaseAuth.currentUser;
//     String userId = user.uid;
//     try {
//       var response =
//           await usersProfile.where('LogInUserID', isEqualTo: userId).get();
//
//       if (response.docs.length > 0) {
//         getFirstNameFirebase =
//             userPersonalData['firstName'] = response.docs[0]['firstName'];
//         getLastNameFirebase =
//             userPersonalData['lastName'] = response.docs[0]['lastName'];
//       }
//       print(getFirstNameFirebase);
//     } on FirebaseException catch (e) {
//       print(e);
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   @override
//    initState() async {
//
//     user = _firebaseAuth.currentUser;
//     String userId = user.uid;
//     try {
//       var response =
//           await usersProfile.where('LogInUserID', isEqualTo: userId).get();
//
//       if (response.docs.length > 0) {
//         getFirstNameFirebase =
//         userPersonalData['firstName'] = response.docs[0]['firstName'];
//         getLastNameFirebase =
//         userPersonalData['lastName'] = response.docs[0]['lastName'];
//       }
//       print(getFirstNameFirebase);
//     } on FirebaseException catch (e) {
//       print(e);
//     } catch (error) {
//       print(error);
//     }
//
//     print('j');
//
//    // super.initState();
//
//   }
//
//   //new Widget for show user name...
//   // Widget _buildPassvalue({Map passInfo}) {
//   //   print(passInfo['logEmail']);
//   //  // String store
//   //
//   //   return Container(
//   //     margin: EdgeInsets.symmetric(vertical: 10),
//   //     padding: EdgeInsets.all(10),
//   //     height: 130,
//   //     color: Colors.white,
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: <Widget>[
//   //         Row(
//   //           children: [
//   //             Icon(
//   //               Icons.date_range,
//   //              // color: Theme.of(context).primaryColor,
//   //               size: 20,
//   //             ),
//   //             SizedBox(
//   //               width: 6,
//   //             ),
//   //             Text(
//   //               passInfo['logEmail'],
//   //               style: TextStyle(
//   //                   fontSize: 16,
//   //                  // color: Theme.of(context).primaryColor,
//   //                   fontWeight: FontWeight.w600),
//   //             ),
//   //           ],
//   //         ),
//   //
//   //         SizedBox(
//   //           height: 10,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // _logRef = FirebaseDatabase.instance.reference().child('daily-bus-912ad-default-rtdb/Login');
//     // final newStoreBooked = new StoreBookedData(null);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Daily Bus'),
//         backgroundColor: Colors.teal,
//         actions: <Widget>[
//           FlatButton(
//             child: Row(
//               children: <Widget>[Text('Home'), Icon(Icons.home)],
//             ),
//             textColor: Colors.white,
//             onPressed: () {
//               Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
//             },
//           )
//         ],
//       ),
//       drawer: Drawer(
//
//         child: ListView(
//           children: <Widget>[
//             DrawerHeader(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: <Color>[Colors.teal, Colors.teal])),
//                 //child: Text('This is Drawer Header')),
//                 child: Text('$getFirstNameFirebase')),
//
//             //My Profile Page link....
//             CustomListTile(
//                 Icons.person,
//                 '    My',
//                 ' Profile',
//                 () => {
//                       Navigator.of(context)
//                           .pushReplacementNamed(MyProfileScreenList.routeName),
//                     }),
//
//             //My bus sit booking....
//             CustomListTile(
//                 Icons.directions_bus_sharp,
//                 '    Booking',
//                 '   Bus Pass',
//                 () => {
//                       Navigator.of(context)
//                           .pushReplacementNamed(SeatBooking.routeName),
//                       // Navigator.push(context,
//                       //   MaterialPageRoute(builder: (context) =>SeatBooking(storeBookedData: newStoreBooked,))
//                       // )
//                     }),
//
//             CustomListTile(
//                 Icons.money_sharp,
//                 '    Check',
//                 ' Price' ' List',
//                 () => {
//                       Navigator.of(context)
//                           .pushReplacementNamed(PriceList.routeName),
//                     }),
//             CustomListTile(
//                 Icons.av_timer_sharp,
//                 '    Morning Bus Schedule',
//                 '',
//                 () => {
//                       Navigator.of(context)
//                           .pushReplacementNamed(BusSchedule.routeName),
//                     }),
//             CustomListTile(
//                 Icons.av_timer_sharp,
//                 '    Day Bus Schedule',
//                 '',
//                 () => {
//                       // FirebaseAuth.instance
//                       //     .authStateChanges()
//                       //     .listen((User user) {
//                       // if (user == null) {
//                       // print('User is null!');
//                       // } else {
//                       // print('User is signed in!');
//                       // String id = user.uid;
//                       // print(id);
//                       // }
//                       // }),
//
//                       Navigator.of(context)
//                           .pushReplacementNamed(DayBusSchedule.routeName),
//                     }),
//             CustomListTile(
//                 Icons.logout,
//                 '    LogOut  ',
//                 '',
//                 () async => {
//                       _signOut(),
//                       Navigator.of(context)
//                           .pushReplacementNamed(LoginScreen.routeName)
//                       // if(user == null){
//                       //   print('sing out'),
//                       //   Navigator.of(context).pushReplacementNamed(SignupScreen.routeName),
//                       //
//                       //
//                       // }else{
//                       //   Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
//                       //
//                       //
//                       //
//                       //
//                       // }
//                     }),
//           ],
//         ),
//       ),
//       body: GoogleMapApp(),
//     );
//   }
// }
