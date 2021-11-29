import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_app/admin/fireUserShowDesing/all_bus_schedule.dart';
import 'package:new_app/admin/fireUserShowDesing/bus_seat_update_result.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_bus_details.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_booking_details.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_booking_type.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_data_show.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_hire_bus.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_number.dart';

import '../main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(

        children: [
          DrawerHeader(
            child: Text('Admin Panel'),
          ),
          DrawerListTile(
            title: "Dashboard",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(MainScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Registered User",
            // svgSrc: "assets/icons/menu_tran.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserDataShow.routeName);
              },
          ),
          DrawerListTile(
            title: "User Contacts Number",
            // svgSrc: "assets/icons/menu_task.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserPhoneNumberShow.routeName);
              },
          ),
          DrawerListTile(
            title: "User Booking Type",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserBookingType.routeName);
            },
          ),
          DrawerListTile(
            title: "User Booking Details",
            // svgSrc: "assets/icons/menu_store.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserBookingDetails.routeName);
            },
          ),
          // DrawerListTile(
          //   title: "Bus Details",
          //   // svgSrc: "assets/icons/menu_notification.svg",
          //
          //   press: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(ShowBusDetails.routeName);
          //   },
          // ),
          DrawerListTile(
            title: "Bus Seat Update Result",
            // svgSrc: "assets/icons/menu_profile.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(BusSeatUpdateResult.routeName);

            },
          ),
          DrawerListTile(
            title: "All Bus Schedule",
            // svgSrc: "assets/icons/menu_setting.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(AllBusScheduleShow.routeName);

            },
          ),
          DrawerListTile(
            title: "Details Of Bus Hire",
            // svgSrc: "assets/icons/menu_setting.svg",

            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserHireBusData.routeName);

            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,

      title: Text(
        title,
        style: TextStyle(color: Colors.tealAccent),
      ),
    );
  }
}