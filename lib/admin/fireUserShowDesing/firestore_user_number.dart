import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';

class UserPhoneNumberShow extends StatefulWidget {
  static const routeName = '/userNumberShow';

  const UserPhoneNumberShow({Key? key}) : super(key: key);

  @override
  _UserPhoneNumberShowState createState() => _UserPhoneNumberShowState();
}

class _UserPhoneNumberShowState extends State<UserPhoneNumberShow> {
  late List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Column(
          children: [
            SizedBox(height:30,
              child: Text('Users Contacts Number',
                style: TextStyle(fontSize: 14),),
            ),

            // const Text("User Booking Details"),
            SizedBox(height:20,
              child: Text(
                "Phone_Number                                                                        User_ID",
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
                future: FirestoreUserPhone().getData(),
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
        // child: FutureBuilder(
        //   future: FireStoreDataBase().getData(),
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        //   {
        //
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
        //
        //
        //
        //   },
        //
        // ),
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
                      label: Text(dataList[index]["PhoneNumber"]),
                    ),
                    DataColumn(
                      label: Text( dataList[index]["UserId"]),
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





        // return
        //   Column(
        //     children: [
        //       Container(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               SizedBox(
        //                 width: double.infinity,
        //                 child: ListTile(
        //                     title: Text(
        //                       dataList[index]["firstName"],
        //                           )
        //                       ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       Container(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               width: double.infinity,
        //               child: ListTile(
        //                   title: Text(
        //                     dataList[index]["lastName"],
        //                   )
        //               ),
        //             ),
        //           ],
        //         ),
        //
        //       )
        //     ],
        //   );

        //   Column(
        //     children: [
        //       Container(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children:<Widget> [
        //               SizedBox(
        //                // width: double.infinity,
        //                 child: DataTable2(
        //                   // columnSpacing: defaultPadding,
        //                   //minWidth:100,
        //                   columns: [
        //                     DataColumn(
        //                       label: Text(dataList[index]["firstName"]),
        //                     ),
        //                     // DataColumn(
        //                     //   label: Text(dataList[index]["lastName"]),
        //                     // ),
        //
        //                   ], rows: [],
        //
        //                 ),
        //               ),
        //               // SizedBox(
        //               //  // width: double.infinity,
        //               //   child: DataTable2(
        //               //     // columnSpacing: defaultPadding,
        //               //     //minWidth:100,
        //               //     columns: [
        //               //       DataColumn(
        //               //         label: Text(dataList[index]["lastName"]),
        //               //       ),
        //               //       // DataColumn(
        //               //       //   label: Text(dataList[index]["lastName"]),
        //               //       // ),
        //               //
        //               //     ], rows: [],
        //               //   ),
        //               //
        //               //
        //               // )
        //             ],
        //           ),
        //
        //
        // //     ListTile(
        // //     title: Text(
        // //       dataList[index]["firstName"],
        // //
        // //     ),
        // //     // subtitle:  Text(dataList[index]["genderValueStore"]),
        // //     // trailing: Text(
        // //     //   dataList[index]["lastName"],
        // //     // ),
        // // ),
        //       ),
        //       Container(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             SizedBox(
        //               child:DataTable2(
        //                 columns: [
        //                   DataColumn(
        //                     label: Text(dataList[index]["lastName"]),
        //                   ),
        //                   // DataColumn(
        //                   //   label: Text(dataList[index]["lastName"]),
        //                   // ),
        //
        //                 ], rows: [],
        //
        //               ) ,
        //             )
        //           ],
        //
        //
        //         ),
        //       )
        //     ],
        //   );


      });
}