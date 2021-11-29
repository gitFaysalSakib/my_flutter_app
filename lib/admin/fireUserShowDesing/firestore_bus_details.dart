import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';

class ShowBusDetails extends StatefulWidget {
  static const routeName = '/busDetails';

  const ShowBusDetails({Key? key}) : super(key: key);

  @override
  _ShowBusDetailsState createState() => _ShowBusDetailsState();
}

class _ShowBusDetailsState extends State<ShowBusDetails> {
  late List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(height:30,
              child: Text('Bus Details',
                style: TextStyle(fontSize: 14),),
            ),

            // const Text("User Booking Details"),
            SizedBox(height:20,
              child: Text(
                "          Bus_Number                  Pick-Up_Location                           Pick-Up_Time               Total_Seat                 Current_Seat",
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
                future: FirestoreBusDetails().getData(),
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
                      label: Text(dataList[index]["bus_number"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["pick_up_location"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["pick_up_time"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["total_bus_seats"].toString()),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["ts_current_bus_seats"].toString()),
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