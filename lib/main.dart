import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/admin/addNewBus/add_new_bus.dart';
import 'package:new_app/admin/addNewBus/add_seat_update.dart';
import 'package:new_app/admin/controllers/MenuController.dart';
import 'package:new_app/admin/fireUserShowDesing/all_bus_schedule.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_booking_details.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_hire_bus.dart';
import 'package:new_app/admin/fireUserShowDesing/firestore_user_number.dart';
import 'package:new_app/admin/login.dart';
import 'package:new_app/admin/login_screen.dart';
import 'package:new_app/admin/screens/main/main_screen.dart';
import 'package:new_app/google_map_geolocator_find.dart';
import 'package:new_app/hire_bus_info_show_user.dart';
import 'package:new_app/home_screen_customlist.dart';
import 'package:new_app/location_google_map_tracking.dart';
import 'package:new_app/location_google_map_tracking2.dart';
import 'package:new_app/location_tracking_screen.dart';
import 'package:new_app/myProfile_screen_List.dart';
import 'package:new_app/my_ticket_details.dart';
import 'package:new_app/new_home_screen.dart';
import 'package:new_app/new_phone_verify_screen.dart';
import 'package:new_app/personal_info_setup_screen.dart';
import './home_screen.dart';
import './login_screen.dart';
import './signUp_screen.dart';
import 'package:provider/provider.dart';
import './authentication.dart';
import './profile_edit_screen.dart';
import './home_screen_customlist.dart';
import './seat_booking_screen.dart';
import './google_map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './next_seat_booking_screen.dart';
import './গাবতলী_bus_scheduleList_screen.dart';
import './phone_verification_screen.dart';
import './profile_settings_screen.dart';
import './bus_schedule_screen.dart';
import 'admin/constants.dart';
import 'admin/fireUserShowDesing/bus_seat_update_result.dart';
import 'admin/fireUserShowDesing/firestore_bus_details.dart';
import 'admin/fireUserShowDesing/firestore_user_booking_type.dart';
import 'admin/fireUserShowDesing/firestore_user_data_show.dart';
import 'gabtoli_bus_start_time_test.dart';
import 'hire_customize_bus.dart';
import 'package:dcdg/dcdg.dart';

// import 'mobileui.dart' if (dart.library.html) 'webui.dart' as multiPlatform;




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _initialPosition = LatLng(23.804812, 90.3530069);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        // ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider(
          create: (context) => MenuController(),
          // ChangeNotifierProvider.value(value: Authentication()),

        ),
        ChangeNotifierProvider.value(value: Authentication()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
       // user interface/mobile interface color...
       //  theme: ThemeData(
       //    primaryColor: Colors.teal,
       //  ),

        //admin interface color...
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.tealAccent),
          canvasColor: secondaryColor,
        ),
        home: LoginScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),
          // HomeScreen.routeName: (ctx)=> HomeScreen(),
          // ProfileEditing.routeName: (ctx)=> ProfileEditing(),
          SeatBooking.routeName:(ctx)=>SeatBooking(),
          NextSeatBooking.routeName:(ctx) => NextSeatBooking(),
          PriceList.routeName: (ctx)=>PriceList(),
          // BusSchedule.routeName:(ctx)=>BusSchedule(),
          // CustomerBusPassInfo.routeName:(ctx)=>CustomerBusPassInfo(),
          // CustomerLocationPassInfo.routeName:(ctx)=>CustomerLocationPassInfo(),
          // CustomerLoginInfo.routeName:(ctx)=>CustomerLoginInfo(),
          // DayBusSchedule.routeName:(ctx)=>DayBusSchedule(),
          PersonalInfo.routeName:(ctx)=>PersonalInfo(),
          // ProfileSettings.routeName:(ctx)=>ProfileSettings(),
          // PhoneVerify.routeName:(ctx)=>PhoneVerify(),
          PhoneOtp.routeName:(ctx)=>PhoneOtp(),
          MyProfileScreenList.routeName:(ctx)=> MyProfileScreenList(),
          NewHomeScreen.routeName:(ctx)=> NewHomeScreen(),
          NewBusSchedule.routeName:(ctx)=>NewBusSchedule(),
             GoogleMapApp.routeName:(ctx)=> GoogleMap(initialCameraPosition:
             CameraPosition(target:_initialPosition, zoom: 10.0 ),),
          MainScreen.routeName:(ctx)=> MainScreen(),
          Login.routeName:(ctx)=>Login(),
          LoginScreenAdmin.routeName:(ctx)=> LoginScreenAdmin(),
          UserLoginForm.routeName:(ctx)=>UserLoginForm(),
          UserDataShow.routeName:(ctx)=> UserDataShow(),
          UserPhoneNumberShow.routeName:(ctx)=>UserPhoneNumberShow(),
          UserBookingType.routeName:(ctx)=> UserBookingType(),
          UserBookingDetails.routeName:(ctx)=> UserBookingDetails(),
          ShowBusDetails.routeName:(ctx)=> ShowBusDetails(),
          BusSeatUpdateResult.routeName:(ctx)=> BusSeatUpdateResult(),
          MyBookedTicket.routeName:(ctx)=> MyBookedTicket(),
          NewBusAddAdmin.routeName:(ctx)=>NewBusAddAdmin(),
          AllBusScheduleShow.routeName:(ctx)=>AllBusScheduleShow(),
          HireCustomBus.routeName:(ctx)=> HireCustomBus(),
          SeatUpdateScreen.routeName:(ctx)=> SeatUpdateScreen(),
          UserHireBusData.routeName:(ctx)=> UserHireBusData(),
          HireBusInfoDataBasic.routeName:(ctx)=> HireBusInfoDataBasic(),
          GabtoliBusTimeShow.routeName:(ctx)=>GabtoliBusTimeShow(),
         // LocationTracking.routeName:(ctx)=>LocationTracking(),
         // LocationTrackingView.routeName:(ctx)=>LocationTrackingView(),

          // MenuController.routeName:(ctx)=> MenuController()
          // LocationTracking.routeName:(ctx)=> LocationTracking()
          // GoogleMapGeoLocator.routeName:(ctx)=> GoogleMapGeoLocator(),
          // LocationTracking.routeName:(ctx)=> LocationTracking()



          //GoogleMapApp.routeName: (ctx)=> GoogleMapApp(),

          //CustomListTile.routeName: (ctx)=> CustomListTile(),


        },


      ),
    );



  }
}