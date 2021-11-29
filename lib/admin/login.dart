import 'package:new_app/admin/screens/dashboard/components/header.dart';
import 'package:new_app/admin/screens/dashboard/dashboard_screen.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_screen.dart';
class Login extends StatefulWidget {
  static const routeName = '/loginAdmin';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   child: SideMenu(),
            // ),
            Expanded(
              flex: 5,
              child: LoginScreenAdmin(),
            )
          ],
        ),
      ),
    );
  }

  }

