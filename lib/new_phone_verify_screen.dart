// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PhoneVerify extends StatefulWidget {
//   static const routeName = '/phoneVerify';
//
//   // PhoneVerify(this._scaffold);
//   // final ScaffoldState _scaffold;
//
//
//   @override
//   _PhoneVerifyState createState() => _PhoneVerifyState();
// }
//
// class _PhoneVerifyState extends State<PhoneVerify> {
//
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _smsController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String _message = '';
//   String _verificationId;
//   ConfirmationResult webConfirmationResult;
//
//
//   // Example code of how to verify phone number
//   Future<void> _verifyPhoneNumber() async {
//     setState(() {
//       _message = '';
//     });
//
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);
//       // widget._scaffold.showSnackBar(SnackBar(
//       //   content: Text(
//       //       'Phone number automatically verified and user signed in: $phoneAuthCredential'),
//       // ));
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               child: const Text(
//                 'Test sign in with phone number',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             TextFormField(
//               controller: _phoneNumberController,
//               decoration: const InputDecoration(
//                 labelText: 'Phone number (+x xxx-xxx-xxxx)',
//               ),
//               validator: (String value) {
//                 if (value.isEmpty) {
//                   return 'Phone number (+x xxx-xxx-xxxx)';
//                 }
//                 return null;
//               },
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               alignment: Alignment.center,
//               // child: SignInButtonBuilder(
//               //   icon: Icons.contact_phone,
//               //   backgroundColor: Colors.deepOrangeAccent[700],
//               //   text: 'Verify Number',
//               //   //onPressed: _verifyPhoneNumber,
//               // ),
//             ),
//             TextField(
//               controller: _smsController,
//               decoration: const InputDecoration(labelText: 'Verification code'),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 16),
//               alignment: Alignment.center,
//               // child: (
//               //   icon: Icons.phone,
//               //   backgroundColor: Colors.deepOrangeAccent[400],
//               //  // onPressed: _signInWithPhoneNumber,
//               //   text: 'Sign In',
//               // ),
//             ),
//             Visibility(
//               visible: _message != null,
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   _message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
