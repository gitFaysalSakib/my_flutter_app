import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import 'package:new_app/admin/constants.dart';

import 'bus_schedule_screen.dart';

class GabtoliBusTimeShow extends StatefulWidget {
  static const routeName = '/gabtoliBusTime';

  const GabtoliBusTimeShow({Key? key}) : super(key: key);

  @override
  _GabtoliBusTimeShowState createState() => _GabtoliBusTimeShowState();
}

class _GabtoliBusTimeShowState extends State<GabtoliBusTimeShow> {
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
  late var i;
  var gabtoli;
  late List<String> result;
  var gabtoliSlotStore;



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
                    .pushReplacementNamed(GabtoliBusTimeShow.routeName);
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
        backgroundColor: Colors.teal,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(NewBusSchedule.routeName);
          },
        ),
        title: Column(
          children: [
            SizedBox(
              height: 30,
              child: Text(
                'গাবতলী - Bus Schedule',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              //flex: 5,
              child: FutureBuilder(
                future: FirestoreGabtoliTimeShow().getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done){
                    // for ( i = 0; i < snapshot.data.length; i++) {
                    //
                    //   //dataList.add(snapshot.data);
                    //   if(snapshot.data[i]['pick_up_location'] == 'কলেজ গেট বাস স্ট্যান্ড'){
                    //      gabtoli =snapshot.data[i]['pick_up_time'];
                    //    // result = snapshot.data[i]['pick_up_time'].split(',');
                    //      print(gabtoli);
                    //      dataList.add(gabtoli);
                    //      print(dataList);
                    //     //dataList[i] = snapshot.data[i]['pick_up_time'];
                    //
                    //    //print(gabtoli);
                    //    // print(result);
                    //    //dataList = result;
                    //      //return buildItems(dataList);
                    //   // print(dataList);
                    //   }
                    //  // print(result);
                    //
                    //   // print(gabtoli);
                    // }
                 // print(result.toList());

                  // print(gabtoli);

                    // for(var total in snapshot.data){
                    //
                    //
                    //   // if(snapshot.data[total]['pick_up_location'] == 'কলেজ গেট বাস স্ট্যান্ড'){
                    //   //   print('workkkkkk');
                    //   //
                    //   //
                    //     dataList.add(total);
                    //   //  print(dataList);
                    //   //
                    //   // }
                    // }


                  // print(dataList);

                 dataList = snapshot.data;
                    //print(dataList);

                    //dataList = gabtoli[i].toList();
                    //result = snapshot.data[i]['pick_up_time'].split(',');
                   // dataList = result;
                  //  print(dataList);



                        // for (var result in snapshot.data) {
                        //   //print(result);
                        //   dataList.add(result.data());
                        // }

                        return buildItems(dataList);



                   // return buildItems(dataList);
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

  Widget buildItems(dataListData) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataListData.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {

        return Container(
          height: 70,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.teal[900]!,
                // blurRadius: 10,
                offset: Offset(3, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                trailing:
                    Icon(Icons.bus_alert, color: Colors.white, size: 30.0),
                title: Text(

                  dataListData[index]["pick_up_time"],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

            ],
          ),
        );
      });
}
