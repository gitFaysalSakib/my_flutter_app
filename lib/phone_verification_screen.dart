import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';
import './home_screen.dart';
import 'new_home_screen.dart';

// enum MobileVerificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
// }

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneOtp extends StatefulWidget {
  static const routeName = '/phoneOtp';

  // final String phone;
  // PhoneOtp(this.phone);
  @override
  _PhoneOtpState createState() => _PhoneOtpState();
}

class _PhoneOtpState extends State<PhoneOtp> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;
  String _verificationCode = '';
  late DatabaseReference _ref;
  CollectionReference _collRef =
      FirebaseFirestore.instance.collection('UserPhoneNumber');

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String verificationId = '';
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewHomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldkey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  // _verifyPhone() async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: '+1${widget.phone}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _firebaseAuth
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => HomeScreen()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verificationId, int resendToken) async {
  //         setState(() {
  //           this._verificationCode = verificationId;
  //           print(_verificationCode);
  //           //PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) async {
  //         setState(() {
  //           _verificationCode = verificationId;
  //           print(_verificationCode);
  //         });
  //       },
  //       timeout: Duration(seconds: 120));
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      //  _verifyPhone();
    });

    _ref = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/PhoneNumber');
  }

  //User Phone Number store into (Realtime Database)...
  void _addPhoneNumberRealtimeStore() {
    String userPhoneNumber = phoneController.text;
    user = _firebaseAuth.currentUser!;
    String getUserId = user.uid;
    Map<String, String> phoneNumberOffUser = <String, String>{
      'UserId': getUserId,
      'PhoneNumber': userPhoneNumber
    };
    _ref.push().set(phoneNumberOffUser);
  }

  //User Phone NUmber Store into (Firebase Store)..
  void _addPhoneNumberFireStore() {
    user = _firebaseAuth.currentUser!;
    String getUserId = user.uid;
    String userPhoneNumber = phoneController.text;
    Map<String, String> phoneNumberOffUser = <String, String>{
      'UserId': getUserId,
      'PhoneNumber': userPhoneNumber
    };
    _collRef
        .add(phoneNumberOffUser)
        .then((value) => print('add'))
        .catchError((error) => print('fail:$error'));
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(hintText: 'Phone Number'),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _firebaseAuth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                  },
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      showLoading = false;
                    });
                    _scaffoldkey.currentState!.showSnackBar(SnackBar(
                        content: Text(verificationFailed.message.toString())));
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;

                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
            child: Text(
              'Continue',
              style: TextStyle(
                  fontSize: 20, letterSpacing: 2.2, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOTPFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(hintText: 'Enter OTP'),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
            _addPhoneNumberRealtimeStore();
            _addPhoneNumberFireStore();
          },
          child: Text(
            'Verify',
            style: TextStyle(
                fontSize: 20, letterSpacing: 2.2, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(PersonalInfo.routeName);
            },
          ),
          title: Text('Phone Authentication'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOTPFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));

    //Column(children: [
    //   Container(
    //     margin: EdgeInsets.only(top: 40),
    //     child: Center(
    //       child: Text(
    //         'Verify +88-${widget.phone}',
    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    //       ),
    //     ),
    //   ),
    //   Padding(
    //     padding: const EdgeInsets.all(30.0),
    //     child: PinPut(
    //       fieldsCount: 6,
    //       textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    //       eachFieldHeight: 40.0,
    //       eachFieldWidth: 50.0,
    //       focusNode: _pinPutFocusNode,
    //       controller: _pinPutController,
    //       submittedFieldDecoration: pinPutDecoration,
    //       selectedFieldDecoration: pinPutDecoration,
    //       followingFieldDecoration: pinPutDecoration,
    //       pinAnimationType: PinAnimationType.fade,
    //       onSubmit: (pin) async {
    //         try {
    //           await _firebaseAuth
    //               .signInWithCredential(PhoneAuthProvider.credential(
    //                   verificationId: _verificationCode, smsCode: pin))
    //               .then((value) async {
    //             if (value.user != null) {
    //               Navigator.pushAndRemoveUntil(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => HomeScreen()),
    //                   (route) => false);
    //             }
    //           });
    //         } catch (e) {
    //           FocusScope.of(context).unfocus();
    //           _scaffoldkey.currentState
    //               .showSnackBar(SnackBar(content: Text('invalid OTP')));
    //         }
    //       },
    //     ),
    //   )
    // ]));
  }
}
