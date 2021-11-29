import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/phone_verification_screen.dart';
import './profile_edit_screen.dart';
import 'package:http/http.dart' as http;
import './home_screen.dart';
import 'package:new_app/new_home_screen.dart';

import 'myProfile_screen_List.dart';

class PersonalInfo extends StatefulWidget {
  static const routeName = '/personal';
  // Call NewHomeScreen Class as a Object..

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Call query for profile edit data show on app page..
  //Query _query;
  //

  //Controller for text field..
  late TextEditingController firstCon;
  late TextEditingController lastCon;
  late TextEditingController genderCon;

  //Gender group value variable..
  String genderRadioGroup = '';

  //Create new function for data store in firebase..
  late DatabaseReference _ref;

  //firebase Auth for user get..
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;
  late String getPhoneNumber;

// create a Map for retrieve data..
  Map userPersonalData = {'firstName': '', 'lastName': ''};

  final firebaseStore = FirebaseFirestore.instance;

  //Call firebase  store user profile table...
  CollectionReference usersProfile =
      FirebaseFirestore.instance.collection('profile');

  //call firebase store in User Phone table...
  CollectionReference usersPhone =
      FirebaseFirestore.instance.collection('UserPhoneNumber');
  Map userPhoneNumber = {'PhoneNumber': ''};

  //Add user firebase fire store...
  Future<void> addUsers() async {
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    String firstName = firstCon.text;
    String lastName = lastCon.text;
    genderCon.text = genderRadioGroup;
    String genderValueStore = genderCon.text;
    print(firstName);
    Map<String, String> data = <String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'genderValueStore': genderValueStore,
      'LogInUserID': getUserID
    };
    usersProfile
        .add(data)
        .then((value) => print('add'))
        .catchError((error) => print('fail:$error'));
  }

  // Update user data and store firebase fire store...
  Future<void> updateUserData() async {
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    String firstName = firstCon.text;
    String lastName = lastCon.text;
    genderCon.text = genderRadioGroup;
    String genderValueStore = genderCon.text;
    print(firstName);
    Map<String, String> data = <String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'genderValueStore': genderValueStore,
      'LogInUserID': getUserID
    };
    usersProfile
        .doc(getUserID)
        .set(data, SetOptions(merge: true))
        .then((value) => print('Update'))
        .catchError((error) => print('fail:$error'));
  }

  late String getFirstNameFirebase;
  late String getLastNameFirebase;

  //method for personal data retrieve from firebase and show personal form...
  Future<void> getUserProfileData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;

    getFirstNameFirebase = firstCon.text;
    getLastNameFirebase = lastCon.text;
    try {
      var response =
          await usersProfile.where('LogInUserID', isEqualTo: userId).get();
      if (response.docs.length > 0) {
        setState(() {
          getFirstNameFirebase =
              userPersonalData['firstName'] = response.docs[0]['firstName'];
          getLastNameFirebase =
              userPersonalData['lastName'] = response.docs[0]['lastName'];

          //if logic check database null value and set database value in TextField..
          if (getFirstNameFirebase == null) {
            firstCon = TextEditingController(text: '');
          } else {
            firstCon = TextEditingController(text: '$getFirstNameFirebase');
          }

          if (getLastNameFirebase == null) {
            lastCon = TextEditingController(text: '');
          } else {
            lastCon = TextEditingController(text: '$getLastNameFirebase');
          }
        });
      }
      print(getFirstNameFirebase);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  //submit button method..
  void savePersonalData() {
    String firstName = firstCon.text;
    String lastName = lastCon.text;
    genderCon.text = genderRadioGroup;
    String genderValueStore = genderCon.text;
    user = _firebaseAuth.currentUser!;
    String getUserID = user.uid;
    Map<String, String> personalDataStore = {
      'firstName': firstName,
      'lastName': lastName,
      'gender': genderValueStore,
      'userID': getUserID
    };
    _ref.push().set(personalDataStore);
  }

  @override
  void initState() {
    firstCon = TextEditingController();
    lastCon = TextEditingController();
    genderCon = TextEditingController();

    // genderCon.text = genderRadioGroup;

    // profile edit data insert in database..
    _ref = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/PersonalInfo');

    // new query for profile edit data show on app page..
    // _query = FirebaseDatabase.instance
    //     .reference()
    //     .child('daily-bus-912ad-default-rtdb/PersonalInfo')
    //     .orderByChild('firstName');

    //CRUD Function..
    //users = FirebaseFirestore.instance.collection('daily-bus-912ad');

    super.initState();

    setState(() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is null!');
        } else {
          print('User is signed in!');
          String id = user.uid;
          print(id);
        }
      });

      getUserProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(MyProfileScreenList.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        title: Text('Personal Information'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.pexels.com/photo/stylish-focused-woman-leaned-on-hand-at-table-in-countryside-5368679/"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            //color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.teal),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //First Name field...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'First Name'),
                      keyboardType: TextInputType.name,
                      controller: firstCon,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),

                    //Last Name...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      keyboardType: TextInputType.name,
                      controller: lastCon,
                      validator: (value) {
                        if (value!.isEmpty || value is int) {
                          return 'invalid';
                        }
                        return null;
                      },
                    ),

                    //Gender...
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Gender',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 'Male',
                            groupValue: genderRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.genderRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          'Male',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 'Female',
                            groupValue: genderRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.genderRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          'Female',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 'Other',
                            groupValue: genderRadioGroup,
                            onChanged: (value) {
                              setState(() {
                                this.genderRadioGroup = value.toString();
                                // print(this.genderRadioGroup);
                              });
                            }),
                        Text(
                          'Other',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // check fire store if phone number exist (Call update function) Or
                          // phone number not exist (Call add function)...
                          user = _firebaseAuth.currentUser!;
                          String userId = user.uid;
                          print(userId);
                          try {
                            var response = await usersPhone
                                .where('UserId', isEqualTo: userId)
                                .get();
                            if (response.docs.length > 0) {
                              setState(() {
                                getPhoneNumber =
                                    response.docs[0]['PhoneNumber'];
                                // userPhoneNumber['PhoneNumber'] = response.docs[0]['PhoneNumber'];
                                if (getPhoneNumber == null) {
                                  print('not found');
                                  addUsers();
                                } else {
                                  print('found');
                                  updateUserData();
                                }
                              });
                            }
                          } on FirebaseException catch (e) {
                            print(e);
                          } catch (error) {
                            print(error);
                          }
                          savePersonalData();
                          // addUsers();
                          // Navigator.of(context).pushReplacementNamed(ProfileEditing.routeName);
                          Navigator.of(context)
                              .pushReplacementNamed(PhoneOtp.routeName);
                        },
                        // addUsers
                        // Navigator.of(context).pushReplacementNamed(ProfileEditing.routeName);

                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          //
          // ),
          // child: Container(
          //   height: 500,
          //   width: 400,
          //   padding: EdgeInsets.all(16),
          //   child: Form(
          //     key: _formKey,
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: <Widget>[
          //           //First Name field...
          //           TextFormField(
          //               decoration: InputDecoration(labelText: 'First Name'),
          //               keyboardType: TextInputType.name,
          //               controller: firstCon,
          //
          //               validator: (value) {
          //               if (value.isEmpty || value is int) {
          //                 return 'invalid';
          //               }
          //               return null;
          //             },
          //         //      onSaved: (value) {
          //         //   _authData['firstName'] = value;
          //         // }
          //         ),
          //
          //
          //           //Last Name...
          //           TextFormField(
          //             decoration: InputDecoration(labelText: 'Last Name'),
          //             keyboardType: TextInputType.name,
          //             controller: lastCon,
          //             obscureText: true,
          //
          //             validator: (value) {
          //               if (value.isEmpty || value is int) {
          //                 return 'invalid';
          //               }
          //               return null;
          //             },
          //               // onSaved: (value) {
          //               //   _authData['lastName'] = value;
          //               // }
          //               ),
          //
          //
          //
          //
          //           //Gender Password...
          //           // TextFormField(
          //           //   decoration:
          //           //   InputDecoration(labelText: '˝Gender'),
          //           //   obscureText: true,
          //           //
          //           //
          //           // ),
          //
          //           Padding(
          //               padding: const EdgeInsets.all(20.0),
          //             child: Text('Gender',
          //               textAlign: TextAlign.left,
          //               style: TextStyle(fontSize: 18.0, color: Colors.black),
          //             ),
          //           ),
          //
          //
          //           Row(
          //             children: <Widget>[
          //               Radio(
          //                   value: 'Male',
          //                   groupValue: genderRadioGroup,
          //                   onChanged: (value) {
          //                     setState(() {
          //                       this.genderRadioGroup = value;
          //                       print(this.genderRadioGroup);
          //                     });
          //                   }),
          //               Text(
          //                 'Male',
          //                 style: TextStyle(
          //                     color: Colors.deepOrange,
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 5.0,
          //           ),
          //
          //           Row(
          //             children: <Widget>[
          //               Radio(
          //                   value: 'Female',
          //                   groupValue: genderRadioGroup,
          //                   onChanged: (value) {
          //                     setState(() {
          //                       this.genderRadioGroup = value;
          //                       print(this.genderRadioGroup);
          //                     });
          //                   }),
          //               Text(
          //                 'Female',
          //                 style: TextStyle(
          //                     color: Colors.deepOrange,
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //
          //           SizedBox(
          //             height: 5.0,
          //           ),
          //
          //           Row(
          //             children: <Widget>[
          //               Radio(
          //                   value: 'Other',
          //                   groupValue: genderRadioGroup,
          //                   onChanged: (value) {
          //                     setState(() {
          //                       this.genderRadioGroup = value;
          //                       print(this.genderRadioGroup);
          //                     });
          //                   }),
          //               Text(
          //                 'Other',
          //                 style: TextStyle(
          //                     color: Colors.deepOrange,
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //
          //
          //
          //
          //
          //
          //
          //
          //           ElevatedButton(
          //             child: Text('Submit'),
          //             onPressed: () {
          //               savePersonalData();
          //               Navigator.of(context).pushReplacementNamed(ProfileEditing.routeName);
          //             },
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          //
          // ),
        ),
      ),
    );
  }
}
