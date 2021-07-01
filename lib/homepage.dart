import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'methods.dart';
import 'package:animate_do/animate_do.dart';

Color kib = Color(0xFFECECEC);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    storeData('Last Known Page', 'Homepage');
    Future.delayed(
        Duration.zero, () => Authorization().checkAuthState() ? Navigator.pushNamed(context, 'Dashboard') : null);
  }

  @override
  Widget build(BuildContext context) {
    // Get Phone Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // The build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(30),
              height: height,
              width: width,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 40, top: 20),
                      width: width,
                      height: height * 0.65,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: kib, boxShadow: [
                        BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 5, spreadRadius: 2),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ZoomIn(
                            duration: Duration(milliseconds: 450),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Image.asset(
                                'assets/images/greeniconlogo.png',
                              ),
                            ),
                          ),
                          ZoomIn(
                            duration: Duration(milliseconds: 600),
                            child: Image.asset('assets/images/Tech Life Remote Life.png'),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        greeting(),
                        style: TextStyle(color: Colors.grey[850], fontSize: 30),
                      ),
                    ),
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SlideInUp(
                        duration: Duration(milliseconds: 650),
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          width: width * 0.375,
                          height: height * 0.08,
                          child: NeumorphicButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'Sign In');
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign In',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                              ),
                            ),
                            style: NeumorphicStyle(
                              color: kib,
                              depth: 4,
                            ),
                          ),
                        ),
                      ),
                      SlideInUp(
                        duration: Duration(milliseconds: 750),
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          width: width * 0.375,
                          height: height * 0.08,
                          child: NeumorphicButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'Register');
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                              ),
                            ),
                            style: NeumorphicStyle(
                              color: kib,
                              depth: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ))),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
