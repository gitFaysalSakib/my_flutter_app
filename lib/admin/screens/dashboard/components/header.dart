import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/admin/controllers/MenuController.dart' ;
import 'package:new_app/admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../login.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
late User user;
bool isLoggedIn = false;


class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [

          // Image.asset(
          //   "assets/images/logo.png",
          //   height: 20,
          // ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Faysal Sakib"),

            ),

          Icon(Icons.keyboard_arrow_down,),

        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return TextField(
  //     decoration: InputDecoration(
  //       hintText: "Search",
  //       fillColor: secondaryColor,
  //       filled: true,
  //       border: OutlineInputBorder(
  //         borderSide: BorderSide.none,
  //         borderRadius: const BorderRadius.all(Radius.circular(10)),
  //       ),
  //       suffixIcon: InkWell(
  //         onTap: () {},
  //         child: Container(
  //           padding: EdgeInsets.all(defaultPadding * 0.75),
  //           margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
  //           decoration: BoxDecoration(
  //             color: primaryColor,
  //             borderRadius: const BorderRadius.all(Radius.circular(10)),
  //           ),
  //           // child: SvgPicture.asset("assets/icons/Search.svg"),
  //
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding /
              (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
      onPressed: () async {

          // user = (await _firebaseAuth.currentUser)!;
          // var response = await _firebaseAuth.signOut();
          // isLoggedIn = false;
          // Navigator.of(context)
          //     .pushReplacementNamed(Login.routeName);

          },
      icon: Icon(Icons.logout),
      label: Text("Log out"),
    );
  }
}