import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';

class UserHireBusData extends StatefulWidget {
  static const routeName = '/hireBusAdmin';

  const UserHireBusData({Key? key}) : super(key: key);

  @override
  _UserHireBusDataState createState() => _UserHireBusDataState();
}

class _UserHireBusDataState extends State<UserHireBusData> {
  late List dataList = [];

  CollectionReference busSeatUpdateTable =
  FirebaseFirestore.instance.collection('busTimeTable');
  String getBusNumber = '';
  String storeDocumentID = '';

  late TextEditingController busNumberText;
  String busNumberFirestore = '';
  Map getBusNumberData = {
    'bus_number': '',
  };

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserHireBusData.routeName);
                // Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }


  Future<void> delectFunction() async {
    try {
      var response = await busSeatUpdateTable
          .where('bus_number', isEqualTo: getBusNumber)
          .get()
          .then((QuerySnapshot snapshot) => {
        snapshot.docs.forEach((DocumentSnapshot doc) {
          storeDocumentID = doc.id;
          print(storeDocumentID);

          busNumberFirestore = getBusNumberData['bus_number'] =
          snapshot.docs[0]['bus_number'];
          print(busNumberFirestore);

          busSeatUpdateTable
              .doc(storeDocumentID)
              .delete()
              .then((value) => print('Delete'))
              .catchError((error) => print('fail:$error'));
        })
      });
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }

    // var querySnapshots = await busSeatUpdateTable.get();
    // for (var snapshot in querySnapshots.docs) {
    //   var documentID = snapshot.id;
    //   print(documentID);
    //   print(getBusNumber);
    //
    //   // busNumberFirestore = getBusNumberData['bus_number'] =
    //   // snapshot.docs[0]['bus_number'];
    //
    //
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(
              height: 20,
              child: Text(
                "                        Journey_Date          Return_Date            Going_Place           Total_Days          Booking_Seat        Total_Amount        User_ID",
                style: TextStyle(fontSize: 16),
              ),
            ),
            // const Text("User Booking"),
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: FirestoreHireBusData().getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  // if (snapshot.hasError) {
                  //   return const Text(
                  //     "Something went wrong",
                  //   );
                  // }
                  if (snapshot.connectionState == ConnectionState.done) {
                    dataList = snapshot.data as List;
                    return buildItems(dataList);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(Icons.edit,color: Colors.white, size: 30.0,
              // ),
              ListTile(
                trailing: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30.0,
                ),
                selected: dataList[index]["bus_number"] == getBusNumber,
                onLongPress: () {
                  dataList[index]["bus_number"] == index;
                  getBusNumber = dataList[index]["bus_number"];
                  delectFunction();
                  _showMyDialog();

                },
              ),
              // Text(
              //   "Recent Files",
              //   style: Theme.of(context).textTheme.subtitle1,
              // ),
              SizedBox(
                width: double.infinity,
                child: DataTable2(
                  columnSpacing: defaultPadding,
                  minWidth: 100,
                  columns: [
                    DataColumn(
                      label: Text(dataList[index]["journey_date"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["return_date"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["going_place"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["total_journey_day"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["total_seat_hire"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["total_amount"]),
                    ),
                    DataColumn(
                      label: Text(dataList[index]["userId"]),
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
            ],
          ),
        );
      });
}
