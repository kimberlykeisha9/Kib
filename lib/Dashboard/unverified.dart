import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kib/methods.dart';

import '../employer.dart';

class Unverified extends StatefulWidget {
  @override
  _Unverified createState() => _Unverified();
}

Color kib = Color(0xFFECECEC);

class _Unverified extends State<Unverified> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    storeData('Last Known Page', 'Unverified');
    Future.delayed(
        Duration.zero, () => Authorization().checkAuthState() ? null : Navigator.pushNamed(context, 'Welcome'));
    Future.delayed(Duration.zero, () {
      if (!Authorization().checkEmailVerification()) {
        Authorization()
            .signOut()
            .then((value) => Authorization().checkAuthState() ? null : Navigator.pushNamed(context, 'Welcome'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Employer>(context).userData();
    fname = Provider.of<Employer>(context).firstName;
    lname = Provider.of<Employer>(context).lastName;
    pp = Provider.of<Employer>(context).pp;
//    print(accStat);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: menu(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(15),
              width: width,
              height: height * 0.13,
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: kib,
                  depth: 4,
                  intensity: 0.8,
                  shadowLightColor: Colors.white,
                ),
                child: Container(
                  //   padding: EdgeInsets.all(15),
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: height * 0.15,
            centerTitle: true,
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              width: width,
              height: height * 0.15,
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: kib,
                  depth: 4,
                  intensity: 0.8,
                  shadowLightColor: Colors.white,
                ),
                child: Container(
                    padding: EdgeInsets.all(15),
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/greeniconlogo.png')),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              home(),
            ],
          ),
        ),
      ),
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

  Widget home() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.4,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: height * 0.13),
      child: Column(
        children: [
          Container(
            // color: Colors.pink,
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Icon(Icons.account_circle_rounded, size: 100)),
                Container(
                  //  color: Colors.green,
                  height: height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(child: Text(greeting(), style: TextStyle(fontSize: 26))),
                      Container(child: Text('$fname', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              height: height * 0.475,
              width: width,
              decoration: BoxDecoration(
                  // color: Colors.pink,
                  borderRadius: BorderRadius.circular(12)),
              child: Neumorphic(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                style: NeumorphicStyle(
                  color: kib,
                  depth: -4,
                  intensity: 0.8,
                  shadowLightColorEmboss: kib,
                  shadowLightColor: Colors.white,
                ),
                child: StreamBuilder<DocumentSnapshot>(
                    stream: userInfo.snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data.data();
                      final _accStat = data()['Account Verification Status'];
                      if (_accStat == 'pending') {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(child: Text('Account has not been verified')),
                            Center(
                                child: Text(
                              'Your account is still under review. Once we are done reviewing your account we will send you a notfication email',
                              textAlign: TextAlign.center,
                            ))
                          ],
                        );
                      } else if (_accStat == 'approved but incomplete') {
                        return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Center(
                            child: Text(
                                'Your account has been approved. ' +
                                    'Click the button below to finish setting up ' +
                                    'your account',
                                textAlign: TextAlign.center),
                          ),
                          Center(
                            child: Container(
                                width: width * 0.5,
                                height: height * 0.075,
                                child: NeumorphicButton(
                                    onPressed: () => Navigator.pushNamed(context, 'Setup'),
                                    style: NeumorphicStyle(color: kib),
                                    child: Center(
                                        child: Text(
                                      'Finish Setting Up',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                                    )))),
                          )
                        ]);
                      } else if (_accStat == 'rejected') {
                        return Center(
                          child: Text(
                              'Your account has been rejected. ' + 'Please check your email for further information',
                              textAlign: TextAlign.center),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menu() {
    SystemUiOverlayStyle(statusBarColor: kib);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Container(
      color: kib,
      height: height,
      width: width,
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Flexible(
          child: Container(
              width: width,
              height: height * 0.275,
              child: Neumorphic(
                  padding: EdgeInsets.all(20),
                  style: NeumorphicStyle(
                    color: kib,
                    depth: 4,
                    intensity: 0.8,
                    shadowLightColorEmboss: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text('Menu',
                                  style:
                                      TextStyle(color: Color(0xFF00AC7C), fontWeight: FontWeight.bold, fontSize: 18))),
                          Container(width: 30, height: 30, child: Image.asset('assets/images/greeniconlogo.png')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:
                                    Text('$fname $lname', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                              Container(
                                child: Text('$phone', style: TextStyle(fontSize: 16)),
                              ),
                              Container(
                                child: Text('Rating: 4.5/5', style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          Icon(Icons.account_circle, size: 90)
                        ],
                      ),
                    ],
                  ))),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            //color: Colors.pink,
            width: width,
            height: height * 0.5,
            child: Column(children: [
              Container(
                  width: width,
                  height: height * 0.1,
                  child: NeumorphicButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Profile', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                    ),
                    onPressed: () {},
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                      color: kib,
                      depth: 4,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 3),
                  width: width,
                  height: height * 0.1,
                  child: NeumorphicButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('General Settings', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                    ),
                    onPressed: () {},
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.rect(),
                      color: kib,
                      depth: 4,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 3),
                  width: width,
                  height: height * 0.1,
                  child: NeumorphicButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Kibarua Website', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                    ),
                    onPressed: () {},
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                      color: kib,
                      depth: 4,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                  )),
            ])),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: width,
              height: height * 0.1,
              child: NeumorphicButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Log Out', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                ),
                onPressed: () {
                  Authorization().logOutDialog(context).then((value) => Authorization().checkAuthState()
                      ? null
                      : Navigator.pushNamed(
                          context,
                          'Welcom'
                          'e'));
                },
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                  color: kib,
                  depth: 4,
                  intensity: 0.8,
                  shadowLightColorEmboss: Colors.white,
                ),
              )),
        )
      ]),
    ));
  }
}
