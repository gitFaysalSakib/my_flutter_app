// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:new_app/login_screen.dart';
// import 'package:new_app/phone_verification_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import './authentication.dart';
// import './home_screen_customlist.dart';
// import './seat_booking_screen.dart';
// import './গাবতলী_bus_scheduleList_screen.dart';
// import './available_bus_schedule_screen.dart';
// import './available_day_schedule_screen.dart';
// import 'package:firebase_database/firebase_database.dart';
// import './home_screen.dart';
// import './phone_verification_screen.dart';
// import './personal_info_setup_screen.dart';
// import './myProfile_screen_List.dart';
//
//
// class ProfileEditing extends StatefulWidget {
//   static const routeName = '/profileEdit';
//
//   @override
//   _ProfileEditingState createState() => _ProfileEditingState();
// }
//
// class _ProfileEditingState extends State<ProfileEditing> {
//   //final GlobalKey<FormState> _formKey = GlobalKey();
//   TextEditingController _phoneController;
//   //TextEditingController _pinController = TextEditingController();
//   DatabaseReference _ref;
//
//   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//
//
//   Future<void> _signOut() async {
//     print('sing ount');
//     await _firebaseAuth.signOut();
//   }
//
//   @override
//   void initState() {
//     Firebase.initializeApp();
//
//     _phoneController = TextEditingController();
//     // _ref = FirebaseDatabase.instance
//     //     .reference()
//     //     .child('daily-bus-912ad-default-rtdb/Phone');
//
//     super.initState();
//
//     //Firebase.initializeApp();
//   }
//
//   void _inputPhoneDatabase() {
//     String storePhone = _phoneController.text;
//     String StoreEmailUser = '$finalEmailget';
//     Map<String, String> storePhoneVale = {
//       'storePhone': storePhone,
//       'StoreEmailUser': StoreEmailUser
//     };
//     _ref.push().set(storePhoneVale);
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Sucessfully update your Phone Number'),
//             content: Column(
//               children: <Widget>[
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pushReplacementNamed(HomeScreen.routeName);
//                   },
//                   child: Text('Ok'),
//                 ),
//               ],
//             ),
//           );
//         });
//
//     print(storePhone);
//   }
//
//   Future<void> _continue() async {
//     //await Firebase.initializeApp();
//     print(_phoneController.text);
//
//     // WidgetsFlutterBinding.ensureInitialized();
//     //  await Firebase.initializeApp();
//     //
//
//     // if(!_formKey.currentState.validate())
//     // {
//     //   return;
//     // }
//     // _formKey.currentState.save();
//     // print('hi');
//
//     // await FirebaseAuth.instance.verifyPhoneNumber(
//     //     phoneNumber: _phoneController.text,
//     //     timeout: const Duration(minutes: 2),
//     //     verificationCompleted: (PhoneAuthCredential credential) async {
//     //       // var result =await FirebaseAuth.instance.signInWithCredential(credential);
//     //       // User user = result.user;
//     //       // if(user != null)
//     //       //   {
//     //       //     Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
//     //       //     print('hii');
//     //       //
//     //       //   }
//     //     },
//     //     verificationFailed: (FirebaseException exception) {
//     //       print(exception);
//     //     },
//     //     codeSent: (String verificationId, int resendToken) {
//     //       showDialog(
//     //           context: context,
//     //           builder: (context) {
//     //             return AlertDialog(
//     //               title: Text('Enter the code'),
//     //               content: Column(
//     //                 children: <Widget>[
//     //                   TextField(
//     //                     controller: _pinController,
//     //                   ),
//     //                   ElevatedButton(
//     //                       onPressed: () async {
//     //                         var smsCode = _pinController.text;
//     //                         print(smsCode);
//     //                         PhoneAuthCredential _phnAuth =
//     //                             PhoneAuthProvider.credential(
//     //                                 verificationId: verificationId,
//     //                                 smsCode: smsCode);
//     //
//     //                         var result = await FirebaseAuth.instance
//     //                             .signInWithCredential(_phnAuth);
//     //
//     //                         User user = result.user;
//     //                         if (user != null) {
//     //                           Navigator.of(context)
//     //                               .pushReplacementNamed(LoginScreen.routeName);
//     //                           print('hii');
//     //                         }
//     //                       },
//     //                       child: Text('ok')),
//     //                 ],
//     //               ),
//     //             );
//     //           });
//     //     },
//     //     codeAutoRetrievalTimeout: (String verificationId) {});
//
//     // await FirebaseAuth.instance.verifyPhoneNumber
//     //   (
//     //     phoneNumber: _phoneController.text,
//     //     timeout: Duration(seconds: 30),
//     //     verificationCompleted: (PhoneAuthCredential credential) async
//     //     {
//     //       var result = await FirebaseAuth.instance.signInWithCredential(credential);
//     //       User user = result.user;
//     //       if(user != null)
//     //       {
//     //         //Navigator.of(context).pushReplacementNamed(routeName)
//     //         print('hi');
//     //       }
//     //
//     //
//     //     },
//     //     verificationFailed: (FirebaseException excption)
//     //     {
//     //       print(excption);
//     //     },
//     //     codeSent: (String VerificationId, int resendToken)
//     //     {
//     //
//     //     },
//     //     codeAutoRetrievalTimeout: (String VerificationId)
//     //     {
//     //
//     //     },
//     //     );
//
//     // if(!_formKey.currentState.validate())
//     // {
//     //   return;
//     // }
//     // _formKey.currentState.save();
//     // print('hi');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: (){
//             Navigator.of(context).pushReplacementNamed(PersonalInfo.routeName);
//             },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               color: Colors.white,
//             ),
//             onPressed: (){
//             },
//           ),
//         ],
//
//         title: Text('Phone Authentication'),
//         backgroundColor: Colors.teal,
//         // actions: <Widget>[
//         //   FlatButton(
//         //     child: Row(
//         //       children: <Widget>[Text('Home'), Icon(Icons.home)],
//         //     ),
//         //     textColor: Colors.white,
//         //     onPressed: () {
//         //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
//         //     },
//         //   )
//         // ],
//       ),
//       // drawer: Drawer(
//       //   child: ListView(
//       //     children: <Widget>[
//       //       DrawerHeader(
//       //           decoration: BoxDecoration(
//       //               gradient: LinearGradient(colors: <Color>[
//       //             Colors.deepOrange,
//       //             Colors.orangeAccent
//       //           ])),
//       //           child: Text('$logEmail')),
//       //
//       //       //My Profile Page link....
//       //       CustomListTile(
//       //           Icons.person,
//       //           '    My',
//       //           ' Profile',
//       //           () => {
//       //             Navigator.of(context).pushReplacementNamed(PersonalInfo.routeName),
//       //
//       //           }),
//       //
//       //       //My bus sit booking....
//       //       CustomListTile(
//       //           Icons.directions_bus_sharp,
//       //           '    Booking',
//       //           '   Bus Pass',
//       //           () => {
//       //                 Navigator.of(context)
//       //                     .pushReplacementNamed(SeatBooking.routeName),
//       //                 // Navigator.push(context,
//       //                 //   MaterialPageRoute(builder: (context) =>SeatBooking(storeBookedData: newStoreBooked,))
//       //                 // )
//       //               }),
//       //
//       //       CustomListTile(
//       //           Icons.money_sharp,
//       //           '    Check',
//       //           ' Price' ' List',
//       //           () => {
//       //                 Navigator.of(context)
//       //                     .pushReplacementNamed(PriceList.routeName),
//       //               }),
//       //       CustomListTile(
//       //           Icons.av_timer_sharp,
//       //           '    Morning Bus Schedule',
//       //           '',
//       //           () => {
//       //                 Navigator.of(context)
//       //                     .pushReplacementNamed(BusSchedule.routeName),
//       //               }),
//       //
//       //       CustomListTile(
//       //           Icons.person,
//       //           '    Day Bus Schedule',
//       //           '',
//       //           () => {
//       //                 Navigator.of(context)
//       //                     .pushReplacementNamed(DayBusSchedule.routeName),
//       //               }),
//       //       CustomListTile(
//       //           Icons.logout,
//       //           '    LogOut  ',
//       //           '',
//       //           () async  =>  {
//       //         //  await _signOut()
//       //
//       //
//       //
//       //             Navigator.of(context)
//       //                     .pushReplacementNamed(HomeScreen.routeName),
//       //
//       //               }),
//       //     ],
//       //   ),
//       // ),
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//       Column(children: [
//       Container(
//       margin: EdgeInsets.only(top: 60),
//       child: Center(
//         child: Text(
//           'Verify Phone Number',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//         ),
//       ),
//     ),
//            Container(
//              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//             child: TextField(
//               //key: _formKey,
//               decoration: InputDecoration(
//                 hintText: 'Phone number',
//                 prefix: Padding(
//                   padding: EdgeInsets.all(4),
//                   child: Text('+88'),
//
//                 ),
//               ),
//               maxLength: 11,
//               keyboardType: TextInputType.number,
//               controller: _phoneController,
//             ),
//           )
//     ]),
//
//             Container(
//               margin: EdgeInsets.all(10),
//               width: double.infinity,
//               child: ElevatedButton(
//                // color: Colors.blue,
//                 onPressed: () {
//                   // Navigator.of(context).push(MaterialPageRoute(
//                   //     builder: (context) => PhoneOtp(_phoneController.text)));
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.teal,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ) ,
//                 ),
//                 child: Text(
//                   'VERIFY',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//     ]
//     )
//     );
//   }
// }
