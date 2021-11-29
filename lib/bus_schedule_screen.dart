import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/gabtoli_bus_start_time_test.dart';
import 'package:new_app/hire_customize_bus.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import 'package:new_app/গাবতলী_bus_scheduleList_screen.dart';
import 'package:new_app/seat_booking_screen.dart';

import 'home_screen_customlist.dart';
import 'login_screen.dart';
import 'myProfile_screen_List.dart';
import 'new_home_screen.dart';

class NewBusSchedule extends StatefulWidget {
  static const routeName = '/newBusSchedule';

  @override
  _NewBusScheduleState createState() => _NewBusScheduleState();
}

class _NewBusScheduleState extends State<NewBusSchedule> {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;


  CollectionReference usersProfile = FirebaseFirestore.instance.collection('profile');
  CollectionReference usersPhone = FirebaseFirestore.instance.collection('UserPhoneNumber');

  Map userPersonalData = {'firstName': '', 'lastName': ''};
  Map userPhoneNumber = {'PhoneNumber': ''};

  String getFirstNameFirebase = ' ';
  String getLastNameFirebase = ' ';
  String getPhoneNumber = ' ';

  // User data show on dashboard...
  Future<void> showUserData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;
    try {
      var response =
      await usersProfile.where('LogInUserID', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getFirstNameFirebase = userPersonalData['firstName'] = response.docs[0]['firstName'];
          getLastNameFirebase =  userPersonalData['lastName'] = response.docs[0]['lastName'];
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
      var response =
      await usersPhone.where('UserId', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getPhoneNumber = userPhoneNumber['PhoneNumber'] = response.docs[0]['PhoneNumber'];
        });

      }
      print(getPhoneNumber);
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
    showUserPhone();
    super.initState();
  }


  // create custom widget...
  Expanded getExpand(String mainText) {
    return Expanded(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          color: Colors.teal[200],
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),

                  SizedBox(height: 20.0),
                  Text(
                    mainText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(),
                ]),
          ),
          onPressed: () {
            if (mainText == 'গাবতলী') {
              // Navigator.of(context).pushReplacementNamed(PriceList.routeName);
              Navigator.of(context).pushReplacementNamed(GabtoliBusTimeShow.routeName);

              print('hiiiiii');
            } else if (mainText == 'My Ticket') {
            } else if (mainText == 'My Journey') {
            } else if (mainText == 'My Offers') {
            } else if (mainText == 'Profile Setting') {
            } else if (mainText == 'My Ticket') {}
          },
        ));
  }



  Expanded getNewExpanded(String mainText) {
    return Expanded(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          color: Colors.teal[900],
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),

                  SizedBox(height: 20.0),
                  Text(
                    mainText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  )
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.lightGreen[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(),
                ]),
          ),
          onPressed: () {
            if (mainText == 'গাবতলী') {
              Navigator.of(context).pushReplacementNamed(PriceList.routeName);
            } else if (mainText == 'My Ticket') {
            } else if (mainText == 'My Journey') {
            } else if (mainText == 'My Offers') {
            } else if (mainText == 'Profile Setting') {
            } else if (mainText == 'My Ticket') {}
          },
        ));
  }











  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Bus schedule'),
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
                        gradient: LinearGradient(colors: <Color>[
                          Colors.teal,
                          Colors.teal
                        ])),
                    child:Text('$getFirstNameFirebase'+ '$getLastNameFirebase'+ '\n$getPhoneNumber',
                      style:TextStyle(color: Colors.white,fontSize: 20.0) ,),
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
                    leading: const Icon(Icons.schedule, size: 28.0,),
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

                //My Profile Page link....
                // CustomListTile(
                //     Icons.person,
                //     '    My',
                //     ' Profile',
                //         () => {
                //       Navigator.of(context).pushReplacementNamed(
                //           MyProfileScreenList.routeName),
                //     }),

                //My bus sit booking....
                // CustomListTile(
                //     Icons.directions_bus_sharp,
                //     '    Buy',
                //     '   Bus Pass',
                //         () => {
                //       Navigator.of(context)
                //           .pushReplacementNamed(SeatBooking.routeName),
                //
                //       // Navigator.of(context).pushReplacementNamed(SeatBooking.routeName),
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) =>SeatBooking(storeBookedData: newStoreBooked,))
                //       // )
                //     }),

                // CustomListTile(
                //     Icons.money_sharp,
                //     '    Check',
                //     ' Price' ' List',
                //         () => {
                //       Navigator.of(context)
                //           .pushReplacementNamed(PriceList.routeName),
                //     }),

                // CustomListTile(
                //     Icons.av_timer_sharp,
                //     '    Bus Schedule',
                //     '',
                //         () => {
                //       Navigator.of(context)
                //           .pushReplacementNamed(NewBusSchedule.routeName),
                //     }),


                // CustomListTile(
                //     Icons.logout,
                //     '    LogOut  ',
                //     '',
                //         () => {
                //       _signOut(),
                //       Navigator.of(context)
                //           .pushReplacementNamed(LoginScreen.routeName),
                //     }),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                Container(
                  color: Colors.teal,
                  child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tabs: [
                        Container(
                          child: Tab(
                            text: 'নিউ মার্কেট রুট ',
                          ),
                        ),
                        Tab(
                          text: 'মিরপুর-1 রুট ',
                        ),
                        Tab(
                          text: 'ফার্মগেট রুট ',
                        ),
                        Tab(
                          text: 'বনানী রুট',
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 500,


                  child: TabBarView(
                    children: [

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),

                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getExpand('গাবতলী'),
                                    getExpand('শ্যামলী '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getExpand('কলেজ গেট '),
                                    getExpand('আসাদ গেট '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getExpand('ধানমন্ডি'),
                                    getExpand('কলাবাগান '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getExpand('সাইন্সল্যাব '),
                                    getExpand('নিউ মার্কেট '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getExpand('আজিমপুর'),
                                    getExpand('গুলিস্তান'),
                                  ],
                                )),
                          ],

                        ),
                      ),
                      Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('গুলিস্তান'),
                                    getNewExpanded('আজিমপুর'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('নিউ মার্কেট'),
                                    getNewExpanded('সাইন্সল্যাব'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('কলাবাগান'),
                                    getNewExpanded('ধানমন্ডি'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('আসাদ গেট '),
                                    getNewExpanded('কলেজ গেট '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('শ্যামলী'),
                                    getNewExpanded('গাবতলী'),
                                  ],
                                )),
                          ],

                        ),
                      ),
                      Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('গুলিস্তান'),
                                    getNewExpanded('আজিমপুর'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('নিউ মার্কেট'),
                                    getNewExpanded('সাইন্সল্যাব'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('কলাবাগান'),
                                    getNewExpanded('ধানমন্ডি'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('আসাদ গেট '),
                                    getNewExpanded('কলেজ গেট '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('শ্যামলী'),
                                    getNewExpanded('গাবতলী'),
                                  ],
                                )),
                          ],

                        ),
                      ),
                      Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('গুলিস্তান'),
                                    getNewExpanded('আজিমপুর'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('নিউ মার্কেট'),
                                    getNewExpanded('সাইন্সল্যাব'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('কলাবাগান'),
                                    getNewExpanded('ধানমন্ডি'),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('আসাদ গেট '),
                                    getNewExpanded('কলেজ গেট '),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    getNewExpanded('শ্যামলী'),
                                    getNewExpanded('গাবতলী'),
                                  ],
                                )),
                          ],

                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
