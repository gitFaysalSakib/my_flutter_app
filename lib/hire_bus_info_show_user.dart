import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import 'admin/constants.dart';
import 'myProfile_screen_List.dart';

// import '../constants.dart';

class HireBusInfoDataBasic extends StatefulWidget {
  static const routeName = '/hireBusUserInfoShow';

  const HireBusInfoDataBasic({Key? key}) : super(key: key);

  @override
  _HireBusInfoDataBasicState createState() => _HireBusInfoDataBasicState();
}

class _HireBusInfoDataBasicState extends State<HireBusInfoDataBasic> {
  late List dataList = [];

  CollectionReference busHireInfoTable =
  FirebaseFirestore.instance.collection('hireBusInfo');
  String getBusNumber = '';
  String storeDocumentID = '';

  late TextEditingController busNumberText;
  String busNumberFirestore = '';
  Map getBusNumberData = {
    'bus_number': '',
  };
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User user;

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Delete Successfully'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(''),
  //               // Text('Would you like to approve of this message?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(context)
  //                   .pushReplacementNamed(HireBusInfoDataBasic.routeName);
  //               // Navigator.of(context).pop();
  //
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  // Future<void> delectFunction() async {
  //   try {
  //     var response = await busSeatUpdateTable
  //         .where('bus_number', isEqualTo: getBusNumber)
  //         .get()
  //         .then((QuerySnapshot snapshot) => {
  //       snapshot.docs.forEach((DocumentSnapshot doc) {
  //         storeDocumentID = doc.id;
  //         print(storeDocumentID);
  //
  //         busNumberFirestore = getBusNumberData['bus_number'] =
  //         snapshot.docs[0]['bus_number'];
  //         print(busNumberFirestore);
  //
  //         busSeatUpdateTable
  //             .doc(storeDocumentID)
  //             .delete()
  //             .then((value) => print('Delete'))
  //             .catchError((error) => print('fail:$error'));
  //       })
  //     });
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   } catch (error) {
  //     print(error);
  //   }
  //
  //   // var querySnapshots = await busSeatUpdateTable.get();
  //   // for (var snapshot in querySnapshots.docs) {
  //   //   var documentID = snapshot.id;
  //   //   print(documentID);
  //   //   print(getBusNumber);
  //   //
  //   //   // busNumberFirestore = getBusNumberData['bus_number'] =
  //   //   // snapshot.docs[0]['bus_number'];
  //   //
  //   //
  //   //
  //   // }
  // }

  late String going;
  late String startDate;
  late String endDate;
  late String amount;
  late String totalDay;
  late String totalSeat;

  Map hireUserInfoDataTable = {
    'going_place': '',
    'journey_date': '',
    'return_date':'',
    'total_amount':'',
    'total_journey_day':'',
    'total_seat_hire':'',
  };

  void initState() {
    // setState(() {
    // getHireBusQueryData();
    // });
    getHireBusQueryData();

    super.initState();
  }

  var response;

  Future<void> getHireBusQueryData() async {
    user = _firebaseAuth.currentUser!;
    String userId = user.uid;

    try{
       response =
      await busHireInfoTable.where('userId', isEqualTo: userId)
          .get();
      //     .then((QuerySnapshot snapshot) =>{
      // snapshot.docs.forEach((DocumentSnapshot doc) {
      // storeDocumentID = doc.id;
      // print(storeDocumentID);
      //
      // dataList = snapshot as List;
      //
      // going = hireUserInfoDataTable['going_place'] = dataList[0]['going_place'];






      if (response.docs.length > 0) {
        setState(() {
          going = hireUserInfoDataTable['going_place'] = response.docs[0]['going_place'];
          startDate = hireUserInfoDataTable['journey_date'] = response.docs[0]['journey_date'];
          endDate = hireUserInfoDataTable['return_date'] = response.docs[0]['return_date'];
          amount = hireUserInfoDataTable['total_amount'] = response.docs[0]['total_amount'];
          totalDay = hireUserInfoDataTable['total_journey_day'] = response.docs[0]['total_journey_day'];
          totalSeat = hireUserInfoDataTable['total_seat_hire'] = response.docs[0]['total_seat_hire'];


          print(startDate);
          print(userId);
        });

      }

    }on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }

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
            Navigator.of(context).pushReplacementNamed(MyProfileScreenList.routeName);
          },
        ),

        title: Column(
          children: [
            SizedBox(
              height: 30,
              child: Text(
                'Details Of Bus Hire',
                style: TextStyle(fontSize: 14),
              ),
            ),

            // const Text("User Booking Details"),

            // const Text("User Booking"),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Start   End       Place     Day        Seat       Total'),
            ),
            // ElevatedButton(onPressed: ()  async{
            //   user = _firebaseAuth.currentUser!;
            //   String userId = user.uid;
            //   // var response =
            //   //     await busHireInfoTable.where('userID', isEqualTo: userId).get();
            //
            //
            //   print(userId);
            //   getHireBusQueryData();
            //
            // }, child: Text('hi')),

            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 100,
                columns: [
                  DataColumn(
                    label: Text(startDate),
                  ),
                  DataColumn(
                    label: Text(endDate),
                  ),
                  DataColumn(
                    label: Text(going),
                  ),
                  DataColumn(
                    label: Text(totalDay),
                  ),
                  DataColumn(
                    label: Text(totalSeat),
                  ),
                  DataColumn(
                    label: Text(amount),
                  ),


                  // DataColumn(
                  //   label: Text("User ID"),
                  // ),
                  // DataColumn(
                  //   label: Text("Phone Number"),
                  // ),
                ],
                rows: [],
              ),
            ),

            // Expanded(
            //   flex: 5,
            //   child: FutureBuilder(
            //     future: FireStoreDataBase().getData(),
            //     builder:
            //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //       // if (snapshot.hasError) {
            //       //   return const Text(
            //       //     "Something went wrong",
            //       //   );
            //       // }
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         dataList = snapshot.data as List;
            //         return buildItems(dataList);
            //       }
            //       return const Center(child: CircularProgressIndicator());
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // Widget buildItems(response) => ListView.separated(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: response.length,
  //     separatorBuilder: (BuildContext context, int index) => const Divider(),
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         padding: EdgeInsets.all(defaultPadding),
  //         decoration: BoxDecoration(
  //           color: secondaryColor,
  //           borderRadius: const BorderRadius.all(Radius.circular(10)),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Icon(Icons.edit,color: Colors.white, size: 30.0,
  //             // ),
  //             // ListTile(
  //             //   trailing: Icon(
  //             //     Icons.delete_forever,
  //             //     color: Colors.white,
  //             //     size: 30.0,
  //             //   ),
  //             //   selected: dataList[index]["bus_number"] == getBusNumber,
  //             //   onLongPress: () {
  //             //     dataList[index]["bus_number"] == index;
  //             //     getBusNumber = dataList[index]["bus_number"];
  //             //     delectFunction();
  //             //     _showMyDialog();
  //             //
  //             //   },
  //             // ),
  //             // Text(
  //             //   "Recent Files",
  //             //   style: Theme.of(context).textTheme.subtitle1,
  //             // ),
  //             SizedBox(
  //               width: double.infinity,
  //               child: DataTable2(
  //                 columnSpacing: defaultPadding,
  //                 minWidth: 100,
  //                 columns: [
  //                   DataColumn(
  //                     label: Text(response[index]["journey_date"]),
  //                   ),
  //                   DataColumn(
  //                     label: Text(response[index]["return_date"]),
  //                   ),
  //                   DataColumn(
  //                     label: Text(response[index]["going_place"]),
  //                   ),
  //                   DataColumn(
  //                     label: Text(response[index]["total_journey_day"]),
  //                   ),
  //                   DataColumn(
  //                     label: Text(response[index]["total_seat_hire"]),
  //                   ),
  //                   DataColumn(
  //                     label: Text(response[index]["total_amount"]),
  //                   ),
  //                   // DataColumn(
  //                   //   label: Text(dataList[index]["userId"]),
  //                   // ),
  //
  //                   // DataColumn(
  //                   //   label: Text("User ID"),
  //                   // ),
  //                   // DataColumn(
  //                   //   label: Text("Phone Number"),
  //                   // ),
  //                 ],
  //                 rows: [],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     });
}
