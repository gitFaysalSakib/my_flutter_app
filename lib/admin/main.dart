import 'package:new_app/admin/constants.dart';
import 'package:new_app/admin/controllers/MenuController.dart';
import 'package:new_app/admin/login.dart';
import 'package:new_app/admin/login_screen.dart';
import 'package:new_app/admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:new_app/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          // ChangeNotifierProvider.value(value: Authentication()),

           ),
        ],
        // child: MainScreen(),
        child: MainScreen(),


      ),
      routes: {
        MainScreen.routeName: (ctx)=> MainScreen(),
        Login.routeName: (ctx)=> Login(),


      },
    );
  }
}
