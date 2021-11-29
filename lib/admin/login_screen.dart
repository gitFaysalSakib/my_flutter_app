
import 'package:new_app/admin/controllers/MenuController.dart';
import 'package:new_app/admin/responsive.dart';
import 'package:new_app/admin/screens/dashboard/dashboard_screen.dart';
import 'package:new_app/admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'package:new_app/authentication.dart';

import 'package:new_app/admin/login.dart';

late TextEditingController _UserEmailController = TextEditingController();
late TextEditingController _UserPasswordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
final FirebaseAuth _auth = FirebaseAuth.instance;

//
// String finalEmailget = '';
//
Map<String, String> _authData = {
  'email': '',
  'password': '',
};

void printHellow(){
  print('hi i am sakib');
  String userEmail = _UserEmailController.text;
  //print(userEmail);
}

Future _stayLogedIn() async {
  SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
  _sharedPreference.setString('email', _UserEmailController.text);
}

// Future<String> getCurrentUIDNew() async {
//   final User? user = await _auth.currentUser;
//   final String uid = user!.uid;
//   print(uid);
//   return uid;
// }






class LoginScreenAdmin extends StatelessWidget {
  static const routeName = '/loginAdmin';

  const LoginScreenAdmin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          // IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: context.read<MenuController>().controlMenu,
          // ),
        SizedBox(height: 500,),
        if (!Responsive.isMobile(context))
          Text(
            "Daily Bus - Admin Panel",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // Expanded(child: UserEmail()),

        Expanded(child: UserLoginForm()),
        // LoginButton()
        // LoginButton()
      ],
    );
  }
}



//try statfull wiget login button...
class UserLoginForm extends StatefulWidget {
  static const routeName = '/userLogin';

  const UserLoginForm({Key? key}) : super(key: key);

  @override
  _UserLoginFormState createState() => _UserLoginFormState();
}

class _UserLoginFormState extends State<UserLoginForm> {

  late User user;
  Stream<User> get onAuthStateChanged => _auth.authStateChanges().cast();


  Future <void> loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try{
      await Provider.of<Authentication>(context, listen: false)
          .login(_authData['email']!, _authData['password']!);
      _stayLogedIn();

      final User? user = (await _auth.signInWithEmailAndPassword(
          email: _authData['email']!, password: _authData['password']!))
          .user;

      if (_authData['email'] == "faysal@gmail.com" &&
          _authData['password'] == '123456') {
        Navigator.of(context)
            .pushReplacementNamed(MainScreen.routeName);
      } else {
        _showMyDialog();

        print('unauth login');

      }
    }catch(error){
      var errorMessage = 'Authentication failed . Please try again';
      _showMyDialog();
      print('noooooootttt');
    }
  }


  @override
  void initState() {
    // _UserEmailController = TextEditingController();
    // _UserPasswordController = TextEditingController();
    super.initState();
    print('hiiiiiiiiiiii login');
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Authentication Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are not Authorized For Access'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(LoginScreenAdmin.routeName);
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: _UserEmailController,
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

                  TextFormField(
                   controller: _UserPasswordController,
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
                      print(value);
                      print( _authData['password']);
                    },
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2.2,
                            color: Colors.white
                        ),),
                      style: ElevatedButton.styleFrom(primary: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ) ,
                      ),
                      onPressed: ()  async {
                        printHellow();
                        String emailUser = _UserEmailController.text;
                        String passUser = _UserPasswordController.text;
                        // _authData['email'] == emailUser;
                        // _authData['password'] == passUser;
                        print(emailUser);
                        loginUser();

                        // FirebaseAuth.instance
                        //     .authStateChanges()
                        //     .listen((User? user) {
                        //   if (user == null) {
                        //     print('User is null!');
                        //   } else {
                        //     print('User is signed in!');
                        //     String id = user.uid;
                        //     print(id);
                        //     // Navigator.of(context)
                        //     //     .pushReplacementNamed(NewHomeScreen.routeName);
                        //   }
                        // });
                        // getCurrentUIDNew();
                        // if(emailUser =='faysal@gmail.com' && passUser == '123456' ){
                        //   print(emailUser);
                        //   print(passUser);
                        //   Navigator.of(context)
                        //       .pushReplacementNamed(MainScreen.routeName);
                        //   // MainScreen();
                        // }else{
                        //   print('not work');
                        // }
                        // if (!_formKey.currentState!.validate()) {
                        //   return;
                        // }
                        // _formKey.currentState!.save();
                        //
                        //
                        //
                        //
                        //   await Provider.of<Authentication>(context, listen: false)
                        //       .login(_authData['email']!, _authData['password']!);
                        //   print(' logedin 33333........');
                        //
                        //   _stayLogedIn();
                        //   print(' logedin 22222........');
                        //
                        //
                        //   //
                        // //
                        //   final User? user = (await _auth.signInWithEmailAndPassword(
                        //       email: _authData['email']!, password: _authData['password']!))
                        //       .user;
                        //
                        //   print(' logedin 44444444........');
                        //
                        //
                        //
                        //   Navigator.of(context)
                        //         .pushReplacementNamed(MainScreen.routeName);
                        //
                        //   print(' logedin 111........');





                          //
                        //   _authData['email'] == emailUser;
                        //   _authData['password'] == passUser;
                        //
                        //
                        //
                        //   if (emailUser == "faysal@gmail.com" &&
                        //       passUser == '123456') {
                        //     print('we login ');
                        //
                        //   } else {
                        //     print('not login');
                        //
                        //   }
                        //


                        //   // var errorMessage = 'Authentication failed . Please try again';
                        //   // _showErrorDialoglogin(errorMessage);

                        //

                        // FirebaseAuth.instance
                        //     .authStateChanges()
                        //     .listen((User? user) {
                        //   if (user == null) {
                        //     print('User is null!');
                        //   } else {
                        //     print('User is signed in!');
                        //     String id = user.uid;
                        //     print(id);
                        //     // Navigator.of(context)
                        //     //     .pushReplacementNamed(NewHomeScreen.routeName);
                        //   }
                        // });



                      },
                    ),
                  )
                ],
              ),

            )


        ),
    );
      // margin: EdgeInsets.only(left: defaultPadding),
      // padding: EdgeInsets.symmetric(
      //   horizontal: defaultPadding,
      //   vertical: defaultPadding / 2,
      // ),
      // decoration: BoxDecoration(
      //   color: secondaryColor,
      //   borderRadius: const BorderRadius.all(Radius.circular(10)),
      //   border: Border.all(color: Colors.white10),
      // ),
      // child: Row(
      //   children: [
      //     ElevatedButton(
      //       child: Text('Login'),
      //       onPressed: (){
      //
      //       },
      //     )
      //
      //   ],
      // ),

  }
}





