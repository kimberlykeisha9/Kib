import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/methods.dart';

import '../employer.dart';

Color kib = Color(0xFFECECEC);

class DoneRegUI extends StatefulWidget {
  @override
  _DoneRegUI createState() => _DoneRegUI();
}

class _DoneRegUI extends State<DoneRegUI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    storeData('Last Known Page', 'Completed Reg');
    super.initState();
    PictureTypes().getIDLink();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(30),
            height: height,
            width: width,
            child: Container(
                height: height * 0.4,
                width: width,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ZoomIn(
                            duration: Duration(milliseconds: 400),
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.centerLeft,
                                onPressed: () {
                                  Navigator.pushNamed(context, 'ID');
                                },
                                icon: Icon(Icons.arrow_back, size: 30, color: Color(0xFF00AC7C))),
                          ),
                          SlideInLeft(
                            duration: Duration(milliseconds: 400),
                            child: Text('Register',
                                style: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 30)),
                          )
                        ],
                      ),
                      SlideInDown(
                        duration: Duration(milliseconds: 400),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Neumorphic(
                            style: NeumorphicStyle(color: kib, depth: 4),
                            child: Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: kib,
                              ),
                              child: Image.asset(
                                'assets/images/greeniconlogo.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                        height: height * 0.5,
                        width: width,
                        child: Column(
                          children: [
                            SlideInUp(
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: width,
                                  height: height * 0.05,
                                  child: Text('Registration Complete',
                                      style: TextStyle(
                                          color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 21))),
                            ),
                            SlideInUp(
                              duration: Duration(milliseconds: 600),
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                    '''You have succesfully created your Kibarua account. We will review your details and verify your information.
Once we are done, we will send you a verification email and you can continue setting up your account.
We look forward to providing you with service!''',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: ZoomIn(
                                  duration: Duration(milliseconds: 700),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    width: width,
                                    height: height * 0.085,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Employer().sendUserInfo().then((value) {
                                          Navigator.pushNamed(context, 'Unverified');
                                        });
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Okay',
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                                        ),
                                      ),
                                      style: NeumorphicStyle(
                                        color: kib,
                                        depth: 6,
                                        shadowLightColorEmboss: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ]))),
      ),
    );
  }
}
