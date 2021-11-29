
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecentFile {
  final String? title, date, size, phone;

  RecentFile({ this.title, this.date, this.size , this.phone});


}

// CollectionReference usersProfile =
// FirebaseFirestore.instance.collection('profile');
//
// FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// late User user;
// late String getLastNameFirebase ='';
// late String getFirstNameFirebase = '' ;
//
// Map userPersonalData = {'firstName': '', 'lastName': ''};



// Future<void> showUserData() async {
//   user = _firebaseAuth.currentUser!;
//   String userId = user.uid;
//   try {
//     var response =
//     await usersProfile.where('LogInUserID', isEqualTo: userId).get();
//     if (response.docs.length > 0) {
//
//         getFirstNameFirebase =
//         userPersonalData['firstName'] = response.docs[0]['firstName'];
//         getLastNameFirebase =
//         userPersonalData['lastName'] = response.docs[0]['lastName'];
//
//     }
//     print(getFirstNameFirebase);
//   } on FirebaseException catch (e) {
//     print(e);
//   } catch (error) {
//     print(error);
//   }
// }

List demoRecentFiles = [
  RecentFile(
   // icon: "assets/icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    size: "3.5mb",
    phone: "1",
  ),
  // RecentFile(
  //   icon: "assets/icons/Figma_file.svg",
  //   title: "Figma File",
  //   date: "27-02-2021",
  //   size: "19.0mb",
  //
  //
  // ),
  // RecentFile(
  //   icon: "assets/icons/doc_file.svg",
  //   title: "Document",
  //   date: "23-02-2021",
  //   size: "32.5mb",
  //
  // ),
  // RecentFile(
  //   icon: "assets/icons/sound_file.svg",
  //   title: "Sound File",
  //   date: "21-02-2021",
  //   size: "3.5mb",
  //
  // ),
  // RecentFile(
  //   icon: "assets/icons/media_file.svg",
  //   title: "Media File",
  //   date: "23-02-2021",
  //   size: "2.5gb",
  //
  // ),
  // RecentFile(
  //   icon: "assets/icons/pdf_file.svg",
  //   title: "Sales PDF",
  //   date: "25-02-2021",
  //   size: "3.5mb",
  // ),

];



