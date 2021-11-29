// import 'package:flutter/material.dart';
//
// class CustomListTile extends StatelessWidget
// {
//   static const routeName = '/customList';
//
//
//   IconData icon;
//   String text;
//   String textMore;
//   Function onTap;
//   CustomListTile(this.icon, this.text, this.textMore, this.onTap);
//   @override
//   Widget build(BuildContext context){
//     return InkWell(
//       splashColor: Colors.orangeAccent,
//       onTap: onTap,
//       child: Container(
//         height: 50,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:<Widget> [
//             Row(
//               children:<Widget> [
//                 Icon(icon),
//                 Text(text,style: TextStyle(
//                   fontSize: 17.0
//                 ),),
//                 Text(textMore, style: TextStyle(
//                   fontSize: 17.0
//                 ),)
//
//               ],
//
//             ),
//             Icon(Icons.arrow_right)
//
//           ],
//
//         ),
//       ),
//     );
//   }
//
// }
