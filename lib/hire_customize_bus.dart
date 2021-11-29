import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/phone_verification_screen.dart';
import './profile_edit_screen.dart';
import 'package:http/http.dart' as http;
import './home_screen.dart';
import 'package:new_app/new_home_screen.dart';

import 'myProfile_screen_List.dart';
import 'package:intl/intl.dart';

class HireCustomBus extends StatefulWidget {
  static const routeName = '/hireBusUser';
  // Call NewHomeScreen Class as a Object..

  @override
  _HireCustomBusState createState() => _HireCustomBusState();
}

class _HireCustomBusState extends State<HireCustomBus> {
  final GlobalKey<FormState> _formKey = GlobalKey();


  //Controller for text field..
  // late TextEditingController firstCon;
  late TextEditingController whereGo;
  late TextEditingController radioButtonTextDays;
  late TextEditingController radioButtonTextSeat;
  late TextEditingController dateConvertext;


  late DateTime pickdate;
  late DateTime pickReturndate;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  //Gender group value variable..
  String daysRadioGroup = '';
  String seatRadioGroup = '';

  DateTime? date1;
  DateTime? date2;

   String storeReturnDate ='';
   String storeJourneyDate ='';


  //Call firebase  store user profile table...
  CollectionReference hireBusTable =
  FirebaseFirestore.instance.collection('hireBusInfo');



  void sucessfullMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Total Seat: ${seatRadioGroup}'),
                Text('Total Day: ${daysRadioGroup}'),
                Text('Total Cost: ${storeSeatAndDayCalculate}'),
              ],
            ),
            content: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ok'))
              ],
            ),
          );
        });
  }

  void sucessfullyAddHireBus() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Your Booking is Complete'),

              ],
            ),
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

  Future<void> addHireBusData() async{
    //radioButtonTextDays.text = daysRadioGroup;
   // radioButtonTextSeat.text = seatRadioGroup;
    radioButtonTextDays.text = daysRadioGroup;
    radioButtonTextSeat.text = seatRadioGroup;
    String storeTotalDay = radioButtonTextDays.text;
    String storeTotalSeat = radioButtonTextSeat.text;

    int calTextDays = int.parse(radioButtonTextDays.text);
    int calTextSeat = int.parse(radioButtonTextSeat.text);
    int storeSeatCalculate = calTextSeat *100;
    storeSeatAndDayCalculate = storeSeatCalculate * calTextDays;


    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;

    String startDate = storeJourneyDate;
    String endDate = storeReturnDate;
    String goingPlace = whereGo.text;

    Map<String, String> data = <String, String>{
      'going_place': goingPlace,
      'journey_date': startDate,
      'return_date': endDate,
      'total_journey_day': storeTotalDay,
      'total_seat_hire': storeTotalSeat,
      'total_amount':storeSeatAndDayCalculate.toString(),
      'userId': getUserID


    };
    hireBusTable
        .add(data)
        .then((value) => print('add'))
        .catchError((error) => print('fail:$error'));

    sucessfullyAddHireBus();


    print(startDate);
    print(endDate);
    print(goingPlace);
    print(storeTotalDay);
    print(storeTotalSeat);

  }


  Future<void> _pickJourneyDate() async {
    date1 = await showDatePicker(
      context: context,
      initialDate: pickdate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date1 != null) {
      setState(() {
        pickdate = date1!;
        storeJourneyDate = pickdate.toString();
        print(storeJourneyDate);
      });
    }
  }



  Future<void> _pickReturnDate() async {
    date2 = await showDatePicker(
      context: context,
      initialDate: pickReturndate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date2 != null) {
      setState(() {
        pickReturndate = date2!;
        storeReturnDate = pickReturndate.toString();
        print(pickReturndate);
        print(storeReturnDate);

      });
    }
  }

   int storeSeatAndDayCalculate =0;
  //calculate days and seat..
  Future<void> calcualteDaysAndSeat() async {
    radioButtonTextDays.text = daysRadioGroup;
    radioButtonTextSeat.text = seatRadioGroup;
    int calTextDays = int.parse(radioButtonTextDays.text);
    int calTextSeat = int.parse(radioButtonTextSeat.text);
    int storeSeatCalculate = calTextSeat *100;
     storeSeatAndDayCalculate = storeSeatCalculate * calTextDays;

     // sucessfullMessage();

     print(storeReturnDate);
  }

  @override
  void initState() {
    // firstCon = TextEditingController();
    whereGo = TextEditingController();
    radioButtonTextDays = TextEditingController();
    radioButtonTextSeat = TextEditingController();
    dateConvertext = TextEditingController();

    pickdate = DateTime.now();
    pickReturndate = DateTime.now();

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
                .pushReplacementNamed(NewHomeScreen.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        title: Text('Hire A Bus'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 16,
          top: 0,
          right: 16,
        ),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          "Journey Date :  ${pickdate.year}, ${pickdate.month}, ${pickdate.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickJourneyDate,
                    ),
                    ListTile(
                      title: Text(
                          "Return Date :  ${pickReturndate.year}, ${pickReturndate.month}, ${pickReturndate.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickReturnDate,
                    ),

                    //First Name field...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Where You Go?'),
                      keyboardType: TextInputType.name,
                      controller: whereGo,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),


                    //Last Name...

                    //Gender...
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'How Many Days For Hire?',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: '1',
                            groupValue: daysRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.daysRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '1',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Radio(
                            value: '2',
                            groupValue: daysRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.daysRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '2',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Radio(
                            value: '3',
                            groupValue: daysRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.daysRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '3',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'How Many Seat?',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Radio(
                            value: '30',
                            groupValue: seatRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.seatRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '30',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Radio(
                            value: '40',
                            groupValue: seatRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.seatRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '40',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Radio(
                            value: '50',
                            groupValue: seatRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.seatRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          '50',
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      // width: double.infinity,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              calcualteDaysAndSeat();
                              sucessfullMessage();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Check',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 80,),
                          ElevatedButton(
                            onPressed: () async {
                              calcualteDaysAndSeat();
                              addHireBusData();
                             // sucessfullMessage();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
