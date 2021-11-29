import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_app/hire_bus_info_show_user.dart';
import 'package:new_app/my_ticket_details.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import './home_screen.dart';
import 'new_home_screen.dart';

class MyProfileScreenList extends StatefulWidget {
  static const routeName = '/profileScreenList';

  @override
  _MyProfileScreenListState createState() => _MyProfileScreenListState();
}

class _MyProfileScreenListState extends State<MyProfileScreenList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          title: Text('My Dashboard'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          color: Colors.teal,
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
                  getExpand('imageUser', 'Personal Information'),
                  getExpand('3', 'My Ticket'),
                ],
              )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  getExpand('11', 'Hired'),
                  getExpand('10', 'My Offers'),
                ],
              )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  getExpand('5', 'Profile Setting'),
                  getExpand('4', 'Booking Status'),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Expanded getExpand(String image, String mainText) {
    return Expanded(
        child: FlatButton(
      padding: EdgeInsets.all(0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'images/$image.png',
                height: 120.0,
              ),
              SizedBox(height: 20.0),
              Text(
                mainText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontSize: 15.0),
              )
            ],
          ),
        ),
        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
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
        if (mainText == 'Personal Information') {
          Navigator.of(context).pushReplacementNamed(PersonalInfo.routeName);
        } else if (mainText == 'My Ticket') {
          Navigator.of(context).pushReplacementNamed(MyBookedTicket.routeName);


        } else if (mainText == 'Hired') {
          Navigator.of(context).pushReplacementNamed(HireBusInfoDataBasic.routeName);


        } else if (mainText == 'My Offers') {
        } else if (mainText == 'Profile Setting') {
        } else if (mainText == 'My Ticket') {}
      },
    ));
  }
}
