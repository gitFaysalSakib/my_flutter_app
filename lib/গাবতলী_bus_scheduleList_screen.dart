import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/bus_schedule_screen.dart';
import 'package:new_app/new_home_screen.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import './home_screen_customlist.dart';
import './profile_edit_screen.dart';
import './seat_booking_screen.dart';
import './store_seat_booked_value.dart';
import './login_screen.dart';
import './home_screen.dart';
import './myProfile_screen_List.dart';

class PriceList extends StatefulWidget {
  static const routeName = '/priceList';

  @override
  _PriceListState createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;
  CollectionReference usersProfile =
      FirebaseFirestore.instance.collection('profile');
  Map userPersonalData = {'firstName': '', 'lastName': ''};
  String getFirstNameFirebase ='';
  String getLastNameFirebase ='';


  // User data show on dashboard...
  Future<void> showUserData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    try {
      var response =
          await usersProfile.where('LogInUserID', isEqualTo: userId).get();

      if (response.docs.length > 0) {
        getFirstNameFirebase =
            userPersonalData['firstName'] = response.docs[0]['firstName'];
        getLastNameFirebase =
            userPersonalData['lastName'] = response.docs[0]['lastName'];
      }
      print(getFirstNameFirebase);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = await _firebaseAuth.currentUser!;
    // String id = user.uid;
  }

  @override
  void initState() {
    showUserData();
    super.initState();
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
                  .pushReplacementNamed(NewBusSchedule.routeName);
            },
          ),

          title: Text('গাবতলী - Bus Schedule'),
          backgroundColor: Colors.teal,
          actions: <Widget>[

          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: <Widget>[
        //       DrawerHeader(
        //           decoration: BoxDecoration(
        //               gradient: LinearGradient(colors: <Color>[
        //             Colors.teal,
        //             Colors.teal
        //           ])),
        //           child: Text('$logEmail')),
        //
        //       //My Profile Page link....
        //       CustomListTile(
        //           Icons.person,
        //           '    My',
        //           ' Profile',
        //           () => {
        //                 Navigator.of(context).pushReplacementNamed(
        //                     MyProfileScreenList.routeName),
        //               }),
        //
        //       //My bus sit booking....
        //       CustomListTile(
        //           Icons.directions_bus_sharp,
        //           '    Bus',
        //           '  Pass',
        //           () => {
        //                 Navigator.of(context)
        //                     .pushReplacementNamed(SeatBooking.routeName),
        //
        //                 // Navigator.of(context).pushReplacementNamed(SeatBooking.routeName),
        //                 // Navigator.push(context,
        //                 //     MaterialPageRoute(builder: (context) =>SeatBooking(storeBookedData: newStoreBooked,))
        //                 // )
        //               }),
        //
        //       CustomListTile(
        //           Icons.money_sharp,
        //           '    Check',
        //           ' Price' ' List',
        //           () => {
        //                 Navigator.of(context)
        //                     .pushReplacementNamed(PriceList.routeName),
        //               }),
        //
        //       CustomListTile(
        //           Icons.av_timer_sharp,
        //           '    Bus Schedule',
        //           '',
        //           () => {
        //                 Navigator.of(context)
        //                     .pushReplacementNamed(BusSchedule.routeName),
        //               }),
        //
        //
        //       CustomListTile(
        //           Icons.logout,
        //           '    LogOut  ',
        //           '',
        //           () => {
        //                 _signOut(),
        //                 Navigator.of(context)
        //                     .pushReplacementNamed(LoginScreen.routeName),
        //               }),
        //     ],
        //   ),
        // ),
        body: ListView(
          children: <Widget>[
            // Container(
            //   color: Colors.grey[850],
            //   height: 40,
            //   // child: ListView(
            //   //   scrollDirection: Axis.horizontal,
            //   //   children: [
            //   //     'গাবতলী',
            //   //     'Saymoli',
            //   //     'Dhanmondi',
            //   //     'Kalabanga',
            //   //     'Science Lab',
            //   //     'New Market'
            //   //   ]
            //   //       .map((e) => Container(
            //   //             margin: EdgeInsets.symmetric(
            //   //                 vertical: 8.0, horizontal: 10.0),
            //   //             decoration: BoxDecoration(
            //   //               color: Colors.white,
            //   //               borderRadius: BorderRadius.circular(10),
            //   //             ),
            //   //             child: OutlinedButton(
            //   //               onPressed: () {
            //   //                 if(e =='Saymoli'){
            //   //                   // Navigator.of(context).pushReplacementNamed(
            //   //                   //     MyProfileScreenList.routeName);
            //   //                   ListTile(
            //   //                     title: Text('Gabtoli  To Saymoli'),
            //   //                     subtitle: Text('50'),
            //   //                   );
            //   //                 }else{
            //   //                   print(' nooooooooo');
            //   //                 }
            //   //
            //   //               },
            //   //               child: Text(
            //   //                 e,
            //   //                 style: TextStyle(fontSize: 18),
            //   //               ),
            //   //             ),
            //   //           ))
            //   //       .toList(),
            //   // ),
            // ),
            Container(
              color: Colors.teal[100],
              child: Column(
                children: <Widget>[

                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                         // blurRadius: 10,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                        Icon(Icons.bus_alert,color: Colors.white, size: 30.0),
                      title: Text('7.00 am - 7.15 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0,),
                      title: Text('7.30 am - 7.45 am',
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size:30.0,),
                      title: Text('8.00 am - 8.15 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0 ),
                      title: Text('8.30 am - 8.45 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0),
                      title: Text('9.00 am - 9.15 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0),
                      title: Text('9.30 am - 9.45 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0),
                      title: Text('10.00 am - 10.15 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal[900]!,
                          offset: Offset(3, 4),
                        )
                      ],
                    ),
                    child: ListTile(
                      trailing:
                         Icon(Icons.bus_alert,color: Colors.white, size: 30.0),
                      title: Text('10.30 am - 10.45 am',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
