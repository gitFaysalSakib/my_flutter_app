import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_app/hire_customize_bus.dart';
import 'package:new_app/new_home_screen.dart';
import 'package:new_app/services/cloude_firestore.dart';
import 'package:new_app/viewsModel/steam_view_model.dart';
import 'package:stacked/stacked.dart';
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
import 'commonDeawer/drawer_widget_sereen.dart';
import 'seat_booking_all_logic/seat_booking_logic_class.dart';

late TextEditingController radioTimetextController;
late TextEditingController radioTypetextController;

class SeatBooking extends StatefulWidget {
  static const routeName = '/seatbook';

  @override
  _SeatBookingState createState() => _SeatBookingState();
}

class _SeatBookingState extends State<SeatBooking> {
  final FirestoreService fire = FirestoreService();

  final GlobalKey<FormState> _formKey = GlobalKey();

  //late TextEditingController radioTimetextController;
  // late TextEditingController radioTypetextController;
  late TextEditingController studentPrice;
  late TextEditingController generalPrice;
  late TextEditingController disablePrice;

  late DatabaseReference ref;
  late DatabaseReference ref2;

  //Query _logRef;
  final fireStore = FirebaseDatabase.instance.reference().child('Login');
  var retriveEmail = "";
  String logEmail1 = "";

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  CollectionReference bookedUsersTypeFireStore =
      FirebaseFirestore.instance.collection('userBookingTypeInfo');

  CollectionReference adminSeatPriceTable =
      FirebaseFirestore.instance.collection('adminSetPrice');

  // String getPassType;
  String getDuration = '';
  String getPassType = '';

  String groupValue1 = '';
  String groupValue2 = '';

  late String getStudentPriceFire;
  late String getGeneralPriceFire;
  late String getDisablePriceFire;

  Map adminSeatPrice = {
    'disabled_price': '',
    'general_price': '',
    'student_price': '',
  };
  Map adminSeatPriceData = {
    'seat_price': '',
    'seat_type': '',
  };

  Future<void> getSeatPrice() async {
    getStudentPriceFire = studentPrice.text;
    getGeneralPriceFire = generalPrice.text;
    getDisablePriceFire = disablePrice.text;

    var response = await adminSeatPriceTable
        .where('seat_type', isEqualTo: 'Student Pass')
        .get();
    print(response);
    if (response.docs.length > 0) {
      setState(() {
        getStudentPriceFire =
            adminSeatPrice['seat_price'] = response.docs[0]['seat_price'];

        if (getStudentPriceFire == null) {
          studentPrice = TextEditingController(text: '');
        } else {
          studentPrice = TextEditingController(text: '$getStudentPriceFire');
        }

        // print(getGeneralPriceFire);
      });
    }

    var response2 = await adminSeatPriceTable
        .where('seat_type', isEqualTo: 'General Pass')
        .get();
    if (response2.docs.length > 0) {
      setState(() {
        getGeneralPriceFire =
            adminSeatPrice['seat_price'] = response2.docs[0]['seat_price'];

        if (getGeneralPriceFire == null) {
          generalPrice = TextEditingController(text: '');
        } else {
          generalPrice = TextEditingController(text: '$getGeneralPriceFire');
        }
      });
    }

    var response3 = await adminSeatPriceTable
        .where('seat_type', isEqualTo: 'Disabled Pass')
        .get();
    if (response3.docs.length > 0) {
      setState(() {
        getDisablePriceFire =
            adminSeatPrice['seat_price'] = response3.docs[0]['seat_price'];

        if (getDisablePriceFire == null) {
          disablePrice = TextEditingController(text: '');
        } else {
          disablePrice = TextEditingController(text: '$getDisablePriceFire');
        }
      });
    }
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    user = await _firebaseAuth.currentUser!;
  }

  @override
  void initState() {
    radioTimetextController = TextEditingController();
    radioTypetextController = TextEditingController();
    studentPrice = TextEditingController();
    generalPrice = TextEditingController();
    disablePrice = TextEditingController();

    ref = FirebaseDatabase.instance.reference().child('StoreValue');
    ref2 = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/Login');

    fire.showUserPhone();
    fire.showUserData();
    getSeatPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final reff = fireStore.reference().child('Login');
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked Your Seat'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          TextButton(
            child: Row(
              children: <Widget>[Icon(Icons.home)],
            ),
            style:TextButton.styleFrom(textStyle: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(NewHomeScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerTest(),
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
              RowOfRadioButton(),
              SizedBox(
                height: 10,
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
              BookingTypeWidget(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Price',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              PriceForm(),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      user = _firebaseAuth.currentUser!;
                      String userId = user.uid;
                      try {
                        var response = await bookedUsersTypeFireStore
                            .where('userID', isEqualTo: userId)
                            .get();
                        if (response.docs.length > 0) {
                          fire.updateUserBookingType();
                          Navigator.of(context)
                              .pushReplacementNamed(NextSeatBooking.routeName);
                        } else {
                          fire.saveData();
                          Navigator.of(context)
                              .pushReplacementNamed(NextSeatBooking.routeName);
                        }
                      } on FirebaseException catch (e) {
                        print(e);
                      } catch (error) {
                        print(error);
                      }
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
            ],
          ),
        ),
      ),
    );
  }

  Column BookingTypeWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
                value: 'Student Pass',
                groupValue: fire.groupValue2,
                onChanged: (value) {
                  setState(() {
                    this.fire.groupValue2 = value.toString();
                    print(this.fire.groupValue2);
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
                groupValue: fire.groupValue2,
                onChanged: (value) {
                  setState(() {
                    this.fire.groupValue2 = value.toString();
                    print(this.fire.groupValue2);
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
                groupValue: fire.groupValue2,
                onChanged: (value) {
                  setState(() {
                    this.fire.groupValue2 = value.toString();
                    print(this.fire.groupValue2);
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
      ],
    );
  }

  Form PriceForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Student Seat Price'),
              enabled: false,
              keyboardType: TextInputType.name,
              controller: studentPrice,
              validator: (value) {
                if (value!.isEmpty || value is int) {
                  return 'invalid';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'General Seat Price'),
              enabled: false,
              keyboardType: TextInputType.name,
              controller: generalPrice,
              validator: (value) {
                if (value!.isEmpty || value is int) {
                  return 'invalid';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Disabled Seat Price'),
              enabled: false,
              keyboardType: TextInputType.name,
              controller: disablePrice,
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
    );
  }

  Widget RowOfRadioButton() {
    return Row(
      children: <Widget>[
        Radio(
            value: '1 Day',
            groupValue: fire.groupValue1,
            onChanged: (value) {
              setState(() {
                this.fire.groupValue1 = value.toString();
                print(this.fire.groupValue1);
                // storeBookedData2.duration =groupValue1;
                // print(storeBookedData2.duration);
              });
            }),
        Text(
          '1 Day',
          style: TextStyle(
              color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),

        Radio(
            value: '1 WEEK',
            groupValue: fire.groupValue1,
            onChanged: (value) {
              setState(() {
                this.fire.groupValue1 = value.toString();
                print(this.fire.groupValue1);
                // storeBookedData2.duration =groupValue1;
                // print(storeBookedData2.duration);
              });
            }),
        Text(
          '1 WEEK',
          style: TextStyle(
              color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          width: 10,
        ),

        //
        Radio(
            value: '1 MONTH',
            groupValue: fire.groupValue1,
            onChanged: (value) {
              setState(() {
                this.fire.groupValue1 = value.toString();
                print(this.fire.groupValue1);
              });
            }),
        Text(
          '1 MONTH',
          style: TextStyle(
              color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
