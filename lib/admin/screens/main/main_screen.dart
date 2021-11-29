import 'dart:ui';

import 'package:new_app/admin//responsive.dart';
import 'package:new_app/admin/screens/dashboard/dashboard_screen.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';
// import 'package:daily_bus_admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MainScreen extends StatelessWidget {
  static const routeName = '/mainScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: DashboardScreen(),
            )
          ],
        ),
      ),
    );
  }
}

