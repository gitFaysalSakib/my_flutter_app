// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import './personal_info_setup_screen.dart';
//
//
// class ProfileSettings extends StatefulWidget {
//   static const routeName = '/profileSetting';
//
//   @override
//   _ProfileSettingsState createState() => _ProfileSettingsState();
// }
//
// class _ProfileSettingsState extends State<ProfileSettings> {
//   DatabaseReference _databaseReference;
//   Query _query;
//
//
//
//
//
//   TextEditingController firstCon;
//
//
//   @override
//   void initState() {
//     firstCon = TextEditingController();
//
//
//
//     _query = FirebaseDatabase.instance
//         .reference()
//         .child('daily-bus-912ad-default-rtdb/PersonalInfo')
//         .orderByChild('firstName');
//
//     super.initState();
//   }
//
//   Widget _buildPassvalue({Map passInfo}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.all(10),
//       height: 130,
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//               SizedBox(
//                 width: 6,
//               ),
//               Text(
//                 passInfo['firstName'],
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.w600),
//
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//
//
//         ],
//       ),
//     );
//   }
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       body: Container(
//         height: double.infinity,
//
//         child: FirebaseAnimatedList(
//           query: _query,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             Map passInfo = snapshot.value;
//             return _buildPassvalue(passInfo: passInfo);
//           },
//
//           controller: ScrollController(
//
//           ),
//
//         )
//       ),
//     );
//   }
// }
