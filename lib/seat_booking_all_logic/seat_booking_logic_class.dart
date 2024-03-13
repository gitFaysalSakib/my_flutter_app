import 'package:firebase_auth/firebase_auth.dart';

class SeatLogic{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;
  Future<void> UserId() async{
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;


  }
}