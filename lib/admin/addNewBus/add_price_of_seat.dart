import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:new_app/admin/fireUserDataQuery/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:new_app/admin/screens/main/components/side_menu.dart';

import '../constants.dart';
import '../responsive.dart';

class PriceSetOfSeat extends StatefulWidget {
  static const routeName = '/newBusAdd';

  const PriceSetOfSeat({Key? key}) : super(key: key);

  @override
  _PriceSetOfSeatState createState() => _PriceSetOfSeatState();
}

class _PriceSetOfSeatState extends State<PriceSetOfSeat> {
  //Controller for text field..

  late TextEditingController busSeatPrice;

  //Call firebase  store user profile table...

  CollectionReference adminSeatPriceTable =
      FirebaseFirestore.instance.collection('adminSetPrice');

  Future<void> setSeatPrice() async {
    String storeDocumentID;

    String getBusSeatCategory = busSeatCategory!;
    String getBusSeatPrice = busSeatPrice.text;
    String price;

    var response = await adminSeatPriceTable
        .where('seat_type', isEqualTo: getBusSeatCategory)
        .get()
        .then((QuerySnapshot snapshot) => {
    snapshot.docs.forEach((DocumentSnapshot doc) {
    storeDocumentID = doc.id;
    print(storeDocumentID);

    Map<String, String> priceData = <String, String>{
      'seat_type': getBusSeatCategory,
      'seat_price':getBusSeatPrice,
    };
    if(snapshot.docs.length>0){
      adminSeatPriceTable
          .doc(storeDocumentID)
          .set(priceData, SetOptions(merge: true))
          .then((value) => print('Update'))
          .catchError((error) => print('fail:$error'));
    }else{
      print('add need');
    }



    })
    });


    // adminSeatPriceTable
    //     .add(priceData)
    //     .then((value) => print('add'))
    //     .catchError((error) => print('fail:$error'));


  }

  List<String> _mySelectedLocation = [
    'Student Pass',
    'General Pass',
    'Disabled Pass',
  ];

  String? busSeatCategory;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully Added'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Check All Bus Schedule'),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));

  void initState() {
    busSeatPrice = TextEditingController();

    super.initState();
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
                'Pricing Of Bus Seat',
                style: TextStyle(fontSize: 20),
              ),
            ),

            // const Text("User Booking Details"),

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
              child: Container(
                child: ListView(
                  children: [
                    Text(
                      "Set The Category Of Seat Price",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Form(
                        //key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButton<String>(
                                  value: busSeatCategory,
                                  hint: Text('Seat Category'),
                                  isExpanded: true,
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.tealAccent,
                                  ),
                                  items: _mySelectedLocation
                                      .map(buildMenuItem)
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      busSeatCategory = value;
                                      //  print(newSelectedLocationNew);
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'How much money?'),
                                keyboardType: TextInputType.name,
                                controller: busSeatPrice,
                                validator: (value) {
                                  if (value!.isEmpty || value is int) {
                                    return 'invalid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () {
                                  setSeatPrice();
                               //   _showMyDialog();
                                },
                                icon: Icon(Icons.add),
                                label: Text("SET"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
