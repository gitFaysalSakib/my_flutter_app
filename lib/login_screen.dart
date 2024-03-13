import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/main_screen.dart';
import 'package:new_app/new_home_screen.dart';
import 'package:new_app/views/stream_view.dart';
import './signUp_screen.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import './home_screen.dart';
// import './available_bus_schedule_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'google_sigin_provider.dart';


// TextEditingController _getLoginUserEmail;
String finalEmailget = '';
String logEmail = '';
final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late DatabaseReference _insertDataBaseNewPath;
  late TextEditingController _lognameController;
  late TextEditingController _logPassController;
  late TextEditingController _getLoginUserEmail;

  late User user;

  final FirebaseAuth authtwo = FirebaseAuth.instance;
  Stream<User> get onAuthStateChanged => authtwo.authStateChanges().cast();

  Future<String> getCurrentUID() async {
    int value1 = 1;
    int value2 = 2;

    if (value1 < value2) {
      print('work');
    }
    print(authtwo.currentUser!.uid);
    final uID = authtwo.currentUser!.uid.toString();
    print(uID);
    return uID;
  }

  Future<String> getCurrentUIDNew() async {
    final User? user = await authtwo.currentUser;
    final String uid = user!.uid;
    print(uid);
    return uid;
  }

  String instructor = '';

  void getInstructorId() async {
    instructor = (await FirebaseAuth.instance.currentUser)!.uid;
    print('hiiiiiiiiiiiiii');
  }

  //User user = FirebaseAuth.instance.currentUser;

  Future<void> inputData() async {
    print('hi i am here first');

    final User? user = _auth.currentUser;

    final String uid = user!.uid;
    // return uid;
    print('hi i am here');

    // final uid = user.uid;
    // print(uid);
    // here you write the codes to input the data into firestore
  }

  @override
  void initState() {
    _lognameController = TextEditingController();
    _logPassController = TextEditingController();
    _getLoginUserEmail = TextEditingController();

    _insertDataBaseNewPath = FirebaseDatabase.instance
        .reference()
        .child('daily-bus-912ad-default-rtdb/Login');

    // _auth.userChanges().listen((event) => setState(() => user = event));

    super.initState();

    setState(() {
      //print(userId);
      print('hi i am');
    });
  }

  Future _stayLogInCheck() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    var obtainemail = _sharedPreference.getString('email');
    //finalEmailget = obtainemail.toString();

    setState(() {
      // obtainemail =('email', _getLoginUserEmail.text);

      // finalEmailget = obtainemail.toString();
      //finalEmailget = _getLoginUserEmail.text;
    });
    // finalEmailget = 'email' ; finalEmailget;
    print(finalEmailget);
  }

  Future _stayLogedIn() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString('email', _lognameController.text);
  }

  void saveLogInDatabase() {
    logEmail = _lognameController.text;
    String logPass = _logPassController.text;

    Map<String, String> storeLogInVale = {
      'logEmail': logEmail,
      'logPass': logPass
    };
    _insertDataBaseNewPath.push().set(storeLogInVale);
    print(storeLogInVale);
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialoglogin(String mes) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(mes),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    try {
      await Provider.of<Authentication>(context, listen: false)
          .login(_authData['email']!, _authData['password']!);
      _stayLogedIn();
      _stayLogInCheck();

      final User? user = (await _auth.signInWithEmailAndPassword(
              email: _authData['email']!, password: _authData['password']!))
          .user;

      // String checkUser = user.uid;
      // print(checkUser);

      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('${user.email} signed in'),
      //   ),
      // );

      if (_authData['email'] == "faysal@gmail.com" &&
          _authData['password'] == '123456') {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
      } else {
        print('yes it work');
        Navigator.of(context).pushReplacementNamed(NewHomeScreen.routeName);
        // Navigator.of(context).pushReplacementNamed(StreamView.routeName);

        //getCurrentUIDNew();
      }
    } catch (error) {
      var errorMessage = 'Authentication failed . Please try again';
      _showErrorDialoglogin(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          TextButton(
            child: Row(
              children: <Widget>[Text('Singup'), Icon(Icons.person_add)],
            ),
            style:TextButton.styleFrom(textStyle: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'images/dailyBus.png',
                height: 200.0,
              ),
              Container(
                height: 220,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Email field...
                        TextFormField(
                            controller: _lognameController,
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'invalid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value!;
                            }
                            ),

                        // Password field....
                        TextFormField(
                          controller: _logPassController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length <= 5) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),

                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              _submit();
                              saveLogInDatabase();
                              // getCurrentUID();
                              // getInstructorId();

                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) {
                                if (user == null) {
                                  print('User is null!');
                                } else {
                                  print('User is signed in!');
                                  String id = user.uid;
                                  print(id);
                                  // Navigator.of(context)
                                  //     .pushReplacementNamed(NewHomeScreen.routeName);
                                }
                              });

                              // onchangedUser();

                              // getCurrentUser();
                              //print(uid);
                              //  _stayLogedCheck();
                              //inputData();
                              // final User user = _auth.currentUser;
                              // if (user == null) {
                              //   return;
                              //
                              // }
                              // final String uid = user.uid;
                              // print(uid);

                              //shared_preferences use...
                            },
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Sign Up With Facebook',
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    _submit();
                    saveLogInDatabase();
                    // getCurrentUID();
                    // getInstructorId();

                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        print('User is null!');
                      } else {
                        print('User is signed in!');
                        String id = user.uid;
                        print(id);
                        // Navigator.of(context)
                        //     .pushReplacementNamed(NewHomeScreen.routeName);
                      }
                    });

                    // onchangedUser();

                    // getCurrentUser();
                    //print(uid);
                    //  _stayLogedCheck();
                    //inputData();
                    // final User user = _auth.currentUser;
                    // if (user == null) {
                    //   return;
                    //
                    // }
                    // final String uid = user.uid;
                    // print(uid);

                    //shared_preferences use...
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
                  label: Text(
                    'Sign Up With Google',
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                    Navigator.of(context)
                        .pushReplacementNamed(NewHomeScreen.routeName);
                    // FirebaseAuth.instance
                    //     .authStateChanges()
                    //     .listen((User? user) {
                    //   if (user == null) {
                    //     print('User is null!');
                    //   } else {
                    //     print('User is signed in!');
                    //     String id = user.uid;
                    //     String? name = user.displayName;
                    //     String? email = user.email;
                    //     // print(id);
                    //     // print(name);
                    //     // print(email);
                    //     Navigator.of(context)
                    //         .pushReplacementNamed(NewHomeScreen.routeName);
                    //   }
                    // });

                    // Navigator.of(context)
                    //     .pushReplacementNamed(NewHomeScreen.routeName);


                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
