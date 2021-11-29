import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_app/authentication.dart';
import 'package:new_app/home_screen.dart';
import 'package:provider/provider.dart';
import './login_screen.dart';
import './authentication.dart';
import 'new_home_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  //get auth user id..
  // final FirebaseAuth _userAuth = FirebaseAuth.instance;
  //
  // //get auth user id..
  // _getCurrentUser() async {
  //   final User user = await _userAuth.currentUser;
  //   final uid = user.uid;
  //   print(uid);
  //
  // }

  // Future<String> inputData() async {
  //   final User user = await FirebaseAuth.instance.currentUser;
  //   final String uid = user.uid.toString();
  //   return uid;
  // }

// passing sign up data...
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialogSignUp(String mes) {
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
    // print('hi');
    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['email']!, _authData['password']!);
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      // Navigator.of(context).pushReplacementNamed(NewHomeScreen.routeName);

    } catch (error) {
      var errorMessage = 'Authentication failed . User Exists';
      _showErrorDialogSignUp(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('Login'), Icon(Icons.person)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 500,
            width: 300,
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //Email field...
                    TextFormField(
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
                          print(_authData['email']);
                        }),

                    //Password...
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length <= 5) {
                          return 'invalid password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                        print(_authData['password']);
                      },
                    ),

                    //Confirm Password...
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value != _passwordController.text) {
                          return 'Password Need to be same';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _authData['password'] = value;
                      },
                    ),

                    SizedBox(
                      height: 70,
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          'REGISTER',
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
                        onPressed: () {
                          _submit();

                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user == null) {
                              print('User is null!');
                            } else {
                              print('User is signed in!');
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
