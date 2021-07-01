import 'dart:ui';
import 'package:provider/provider.dart';
import 'employer.dart';
import 'methods.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:kib/registration/email_pass.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/signin.dart';
import 'package:kib/Dashboard/dashboard.dart';
import 'homepage.dart';
import 'package:kib/Registration/dob.dart';
import 'package:kib/Registration/done_reg.dart';
import 'package:kib/Registration/iddoc.dart';
import 'package:kib/Registration/names.dart';
import 'package:kib/Registration/phone.dart';
import 'package:kib/selection_process/list_selections.dart';
import 'package:kib/selection_process/billing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' as k_worker;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kib/second_registration/done_setup.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'employee.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await NotificationService().init();
  await Firebase.initializeApp();
  try {
    await k_worker.Firebase.initializeApp(
        name: 'Worker',
        options: const FirebaseOptions(
          appId: '1:426830601616:android:f0cba4e4a2ea0c10016715',
          apiKey: 'AIzaSyCWIUEHZ_zNrA7aHLYqj7JgoiXeMs6vZSM',
          messagingSenderId: '426830601616',
          projectId: 'kibarua-workers',
        ));
  } catch (error) {
    Firebase.app('Worker');
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  MpesaFlutterPlugin.setConsumerKey('Ihm9AlVEIkzWYV4FDAPRU6QiIC5P5H0J');
  MpesaFlutterPlugin.setConsumerSecret('j8P6LAphZgWFArAx');
  runApp(Homepage());
}

Color kib = Color(0xFFECECEC);

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Employer()),
        ChangeNotifierProvider(create: (_) => Picture()),
        ChangeNotifierProvider(create: (_) => Employee()),
      ],
      child: MaterialApp(
        title: 'Kib',
        color: kib,
        theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              errorStyle: TextStyle(color: Color(0xFF00AC7C)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20, right: 20),
            ),
            colorScheme: ColorScheme.light(primary: Color(0xFF00AC7C)),
            textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFF00AC7C)),
            fontFamily: 'Quicksand',
            canvasColor: kib,
            primaryColor: kib,
            accentColor: Color(0xFF00AC7C),
            buttonColor: kib,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            snackBarTheme: SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              elevation: 5,
              backgroundColor: Color(0xFF00AC7C).withOpacity(0.5),
            )),
        initialRoute: Authorization().checkAuthState() ? 'Dashboard' : 'Welcome',
        routes: {
          'Dashboard': (context) => Dashboard(),
          'Sign In': (context) => SignInPage(),
          'Register': (context) => Emailpass(),
          'Welcome': (context) => MyHomePage(),
          'DOB': (context) => DOBUI(),
          'Completed Reg': (context) => DoneRegUI(),
          'ID': (context) => IDUI(),
          'Names': (context) => NameUI(),
          'Phone': (context) => PhoneUI(),
          'Selected': (context) => SelectedList(),
          'Bill': (context) => Billing(),
          'Setup': (context) => Setup(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future<String> lastKnownRoute() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('Last Known Route');
  }

  String _lastKnownRoute;

  getRoute() async {
    _lastKnownRoute = await lastKnownRoute();
  }
}
