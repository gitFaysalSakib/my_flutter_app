import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';

class UserBookingType extends StatefulWidget {
  static const routeName = '/userBookingType';

  const UserBookingType({Key? key}) : super(key: key);

  @override
  _UserBookingTypeState createState() => _UserBookingTypeState();
}

class _UserBookingTypeState extends State<UserBookingType> {
  late List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(height:30,
              child: Text('User Booking Type',
                style: TextStyle(fontSize: 14),),
            ),

            // const Text("User Booking Details"),
            SizedBox(height:20,
              child: Text(
                "               Booking_Duration                        User Type                                                                      User_ID",
                style: TextStyle(fontSize: 16),
              ),

            ),
            // const Text("User Booking"),
          ],
        ),
      ),
      body:

      SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: FirestoreUsersBookingType().getData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                {

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
              // Text(
              //   "Recent Files",
              //   style: Theme.of(context).textTheme.subtitle1,
              // ),
              SizedBox(
                width: double.infinity,
                child: DataTable2(
                  columnSpacing: defaultPadding,
                  minWidth:100,
                  columns: [
                    DataColumn(
                      label: Text(dataList[index]["booking_duration"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["booking_type"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["userID"]),
                    ),


                    // DataColumn(
                    //   label: Text("User ID"),
                    // ),
                    // DataColumn(
                    //   label: Text("Phone Number"),
                    // ),
                  ],
                  rows:[],
                ),
              ),

            ],
          ),
        );

      });
}