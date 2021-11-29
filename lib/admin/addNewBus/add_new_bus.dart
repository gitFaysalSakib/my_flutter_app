import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';
import '../responsive.dart';

class NewBusAddAdmin extends StatefulWidget {
  static const routeName = '/newBusAdd';

  const NewBusAddAdmin({Key? key}) : super(key: key);

  @override
  _NewBusAddAdminState createState() => _NewBusAddAdminState();
}

class _NewBusAddAdminState extends State<NewBusAddAdmin> {
  //Controller for text field..
  late TextEditingController busNumber;
  late TextEditingController busName;
  late TextEditingController busRoutes;
  late TextEditingController busStartLocation;
  late TextEditingController busStartTime;
  late TextEditingController busTotalSeats;

  //Call firebase  store user profile table...
  CollectionReference addNewBusTable =
      FirebaseFirestore.instance.collection('busTimeTable');

  CollectionReference busSeatUpdateTable =
      FirebaseFirestore.instance.collection('busSeatUpdate');

  Future<void> addNewBus() async {
    String getBusNumber = busNumber.text;

    String getBusName = busName.text;
    //String getBusStartLocation = busStartLocation.text;
    String getBusStartLocation = busAddStartLocation!;

    // String getBusStartTime = busStartTime.text;
    String getBusStartTime = busAddStartTime!;

    String getBusRoutes = busRoutes.text;
    String getBusSeat = busTotalSeats.text;

    Map<String, String> data = <String, String>{
      'bus_number': getBusNumber,
      'bus_name': getBusName,
      'bus_routes': getBusRoutes,
      'pick_up_location': getBusStartLocation,
      'pick_up_time': getBusStartTime,
      'total_bus_seats': getBusSeat
    };
    addNewBusTable
        .add(data)
        .then((value) => print('add'))
        .catchError((error) => print('fail:$error'));



    Map<String, String> addBusSeat = <String, String>{
      'bus_number': getBusNumber,
      'current_seat': getBusSeat,
    };

    var response = await busSeatUpdateTable
        .where('bus_number', isEqualTo: getBusNumber)
        .get();
    if(response.docs.length>0){
      print('bus already exits');

    }else{
      busSeatUpdateTable
          .add(addBusSeat)
          .then((value) => print('add'))
          .catchError((error) => print('fail:$error'));
    }

    // busSeatUpdateTable
    //     .add(addBusSeat)
    //     .then((value) => print('add'))
    //     .catchError((error) => print('fail:$error'));
  }

  List<String> _mySelectedLocation = [
    'গাবতলী বাস স্ট্যান্ড',
    'শ্যামলী বাস স্ট্যান্ড',
    'কলেজ গেট বাস স্ট্যান্ড',
    'ধানমন্ডি বাস স্ট্যান্ড',
    'কলাবাগান বাস স্ট্যান্ড',
    'সাইন্স ল্যাব বাস স্ট্যান্ড',
    'নিউ মার্কেট বাস স্ট্যান্ড',
    'আজিমপুর বাস স্ট্যান্ড',
    'গুলিস্তান বাস স্ট্যান্ড',
  ];
  List<String> _myBusSchedule = [
    '7.00 - 7.15am',
    '7.30 - 7.45 am',
    '8.00 - 8.15 am',
    '8.30 - 8.45 am',
    '9.00 - 9.15 am',
    '9.30 - 9.45 am',
    '10.00 - 10.15 am',
    '10.30 - 10.45 am',
    '11.00 - 11.15 am',
    '11.30 - 11.45 am',
    '12.00 - 12.15 pm',
    '12.30 - 12.45 pm',
  ];
  String? busAddStartLocation;
  String? busAddStartTime;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully Added'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Check All Bus Schedule'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(LoginScreenAdmin.routeName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));

  void initState() {
    busNumber = TextEditingController();
    busName = TextEditingController();
    busRoutes = TextEditingController();
    busStartLocation = TextEditingController();
    busStartTime = TextEditingController();
    busTotalSeats = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(
              height: 30,
              child: Text(
                'Add New Bus Schedule',
                style: TextStyle(fontSize: 20),
              ),
            ),

            // const Text("User Booking Details"),

            // const Text("User Booking"),
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: ListView(
                  children: [
                    Text(
                      "Input Bus Information",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Form(
                        //key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Bus Number'),
                                keyboardType: TextInputType.name,
                                controller: busNumber,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Bus Name'),
                                keyboardType: TextInputType.name,
                                controller: busName,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Bus Routes'),
                                keyboardType: TextInputType.name,
                                controller: busRoutes,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              DropdownButton<String>(
                                  value: busAddStartLocation,
                                  hint: Text('Start Point'),
                                  isExpanded: true,
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.tealAccent,
                                  ),
                                  items: _mySelectedLocation
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      busAddStartLocation = value;
                                      //  print(newSelectedLocationNew);
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),

                              DropdownButton<String>(
                                  value: busAddStartTime,
                                  hint: Text('Start Time'),
                                  isExpanded: true,
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.tealAccent,
                                  ),
                                  items: _myBusSchedule
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      busAddStartTime = value;
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),


                              SizedBox(
                                height: 10,
                              ),

                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Total Seats Of Bus'),
                                keyboardType: TextInputType.name,
                                controller: busTotalSeats,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () {
                                  addNewBus();
                                  _showMyDialog();
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add New"),
                              ),
                            ],
                          ),
                        ),
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
