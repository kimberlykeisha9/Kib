import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/Dashboard/unverified.dart';
import 'package:kib/chores.dart';
import 'package:kib/methods.dart';
import 'package:provider/provider.dart';

import '../employee.dart';
import '../employer.dart';
import '../linking.dart';

Color kib = Color(0xFFECECEC);

DocumentSnapshot cache;

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: userInfo.snapshots(),
        builder: (context, snapshot) {
          cache = snapshot.data;
          final data = snapshot.data.data();
          final _accStat = data()['Account Verification Status'];
          if (_accStat == 'approved') {
            return DashboardUI();
          } else {
            return Unverified();
          }
        });
  }
}

class DashboardUI extends StatefulWidget {
  @override
  _DashboardUI createState() => _DashboardUI();
}

class _DashboardUI extends State<DashboardUI> {
  void initState() {
    storeData('Last Known Page', 'Dashboard');
    super.initState();
    // ignore: unnecessary_statements
    Future.delayed(
        Duration.zero,
        () => Authorization().checkAuthState()
            ? null
            : Navigator.pushNamed(
                context,
                'Welco'
                'me'));

    setState(() {
      items.every((item) => item.isChecked == false);
      items.every((item) => item.option == true);
      selected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Employee Data
//    Provider.of<Employee>(context).getEmployeeData();
    employeeFirst = Provider.of<Employee>(context).first;
    employeeLast = Provider.of<Employee>(context).last;
    employeePhone = Provider.of<Employee>(context).phone;
    employeeRating = Provider.of<Employee>(context).rating;
    employeePP = Provider.of<Employee>(context).pp;
    // Employer Data
    Provider.of<Employer>(context).userData();
    fname = Provider.of<Employer>(context).firstName;
    lname = Provider.of<Employer>(context).lastName;
    pp = Provider.of<Employer>(context).pp;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                    child: TabBar(
                      labelStyle: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey[850],
                      labelColor: Color(0xFF00AC7C),
                      tabs: <Widget>[
                        Tab(
                          text: 'Home',
                        ),
                        Tab(
                          text: 'History',
                        ),
                        Tab(
                          text: 'Chats',
                        ),
                      ],
                    )),
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
                    child: Hero(tag: 'logo', child: Image.asset('assets/images/greeniconlogo.png'))),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              home(),
              history(),
              chats(),
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: height * 0.17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 70,
                      width: 70,
                      child: pp == null
                          ? Icon(Icons.account_circle_rounded, size: 70)
                          : ClipOval(child: Image.network(pp, fit: BoxFit.cover))),
                  Container(
                    //  color: Colors.green,
                    height: height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            greeting(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          child: Text(
                            '$fname',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Neumorphic(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    style: NeumorphicStyle(
                      color: kib,
                      depth: 4,
                      intensity: 0.8,
                      shadowLightColor: Colors.white,
                    ),
                    child: StreamBuilder<DocumentSnapshot>(
                        initialData: cache,
                        stream: userInfo.snapshots(),
                        builder: (context, snapshot) {
                          bool isActive = snapshot.data.get('isEngaged');
                          if (!isActive) {
                            return FadeIn(
                              duration: Duration(milliseconds: 800),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(
                                      'Select a task',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF00AC7C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: width,
                                      height: height * 0.375,
                                      child: Neumorphic(
                                          style: NeumorphicStyle(
                                            color: kib,
                                            depth: -4,
                                            intensity: 0.8,
                                            shadowLightColorEmboss: Colors.white,
                                          ),
                                          child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: items.length,
                                              itemBuilder: (context, index) {
                                                var item = items[index];
                                                return ExpansionTile(
                                                  title: Text(item.title),
                                                  initiallyExpanded: false,
                                                  children: [
                                                    item.subtitle != null
                                                        ? Container(
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            child: Text(item.subtitle, style: TextStyle(fontSize: 14)))
                                                        : Container(height: 0, width: 0),
                                                    item.subtitle != null
                                                        ? RadioListTile(
                                                            dense: true,
                                                            selectedTileColor: Color(0xFF00AC7C),
                                                            value: 1,
                                                            groupValue: item.selectedRadio,
                                                            onChanged: (val) => setState(() {
                                                              item.option = true;
                                                              item.selectedRadio = val;
                                                            }),
                                                            title: Text(item.optionA, style: TextStyle(fontSize: 14)),
                                                          )
                                                        : Container(height: 0, width: 0),
                                                    item.subtitle != null
                                                        ? RadioListTile(
                                                            dense: true,
                                                            selectedTileColor: Color(0xFF00AC7C),
                                                            value: 2,
                                                            groupValue: item.selectedRadio,
                                                            onChanged: (val) => setState(() {
                                                              item.option = false;
                                                              item.selectedRadio = val;
                                                            }),
                                                            title: Text(item.optionB, style: TextStyle(fontSize: 14)),
                                                          )
                                                        : Container(height: 0, width: 0),
                                                    Container(
                                                      width: width * 0.3,
                                                      margin: EdgeInsets.only(top: 5, bottom: 10),
                                                      child: NeumorphicButton(
                                                          onPressed: () {
                                                            selected.add(item);
                                                            GetLocation()
                                                                .checkIfLocationIsEnabled()
                                                                .then((value) => Navigator.pushNamed(context, 'Bill'));
                                                          },
                                                          style: NeumorphicStyle(color: kib),
                                                          child: Center(
                                                            child: Text('Next',
                                                                style: TextStyle(color: Color(0xFF00AC7C))),
                                                          )),
                                                    ),
                                                  ],
                                                );
                                              })),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            DocumentReference _activeJob = snapshot.data.get('currentJob');
                            return StreamBuilder<DocumentSnapshot>(
                                stream: _activeJob.snapshots(),
                                builder: (context, snapshot) {
                                  employeeFirst = snapshot.data.get('employeeFirst');
                                  employeeLast = snapshot.data.get('employeeLast');
                                  employeePP = snapshot.data.get('employeePP');
                                  employeePhone = snapshot.data.get('employeePhone');
                                  employeeRating = snapshot.data.get('employeeRating');
                                  employeeUID = snapshot.data.get('employeeUID');
                                  task = snapshot.data.get('task');
                                  amount = snapshot.data.get('amount').toDouble();
                                  storeData('employeeFirst', employeeFirst);
                                  storeData('employeeLast', employeeLast);
                                  storeData('employeePP', employeePP);
                                  storeData('employeePhone', employeePhone);
                                  storeData('employeeRating', employeeRating.toString());
                                  storeData('employeeUID', employeeUID);
                                  storeData('task', task);
                                  storeData('amount', amount.toString());
                                  return FadeIn(
                                    duration: Duration(milliseconds: 800),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('$employeeFirst $employeeLast',
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                Text('Rating: $employeeRating',
                                                    style: TextStyle(
                                                      color: Color(0xFF00AC7C),
                                                      fontSize: 14,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          PopupMenuButton(
                                            child: ClipOval(
                                                child: Container(
                                              height: 70,
                                              width: 70,
                                              child: employeePP != null
                                                  ? Image.network(
                                                      employeePP,
                                                    )
                                                  : Icon(Icons.account_circle_outlined),
                                            )),
                                            color: kib,
                                            onSelected: (index) {
                                              if (index == 1) {
                                                showSnackbar(context, 'Calling $employeeFirst');
                                              } else if (index == 2) {
                                                showSnackbar(context, 'Texting $employeeFirst');
                                              } else if (index == 3) {
                                                showSnackbar(context, 'Reporting $employeeFirst');
                                              } else {
                                                showSnackbar(context, 'Feature not currently available');
                                              }
                                            },
                                            itemBuilder: (context) {
                                              return <PopupMenuItem>[
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Text('Call'),
                                                ),
                                                PopupMenuItem(
                                                  value: 2,
                                                  child: Text('Text'),
                                                ),
                                                PopupMenuItem(
                                                  value: 3,
                                                  child: Text('Report'),
                                                ),
                                                PopupMenuItem(
                                                  value: 4,
                                                  child: Text('Chat in-app'),
                                                ),
                                              ];
                                            },
                                            offset: Offset(-20, -5),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child:
                                            Text('Task', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text('$task',
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ),
                                      Expanded(
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total amount',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              Text('Ksh. ${amount.toInt()}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                            ]),
                                      ),
                                      Container(margin: EdgeInsets.only(top: 20)),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Container(
                                            child: NeumorphicButton(
                                          onPressed: () => Linking().finishJob(context),
                                          style: NeumorphicStyle(
                                            color: kib,
                                          ),
                                          child: Text('Finish Task', style: TextStyle(color: Color(0xFF00AC7C))),
                                        )),
                                        Container(
                                            child: NeumorphicButton(
                                          onPressed: () => _cancelDialog,
                                          style: NeumorphicStyle(
                                            color: kib,
                                          ),
                                          child: Text('Cancel Job', style: TextStyle(color: Color(0xFF00AC7C))),
                                        )),
                                      ]),
                                    ]),
                                  );
                                });
                          }
                        }),
                  )),
            )
          ],
        ));
  }

  Widget history() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.4,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: height * 0.13),
        child: Column(
          children: [
            Flexible(
              child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      //color: Colors.pink,
                      borderRadius: BorderRadius.circular(12)),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      color: kib,
                      depth: -2,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                    child: Flexible(
                        child: Center(
                      child: Text('You have no history'),
                    )),
                  )),
            )
          ],
        ));
  }

  Widget chats() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.4,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: height * 0.13),
        child: Column(
          children: [
            Flexible(
              child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      //color: Colors.pink,
                      borderRadius: BorderRadius.circular(12)),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      color: kib,
                      depth: -2,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                    child: Flexible(
                        child: Center(
                      child: Text('You have no chats'),
                    )),
                  )),
            )
          ],
        ));
  }

  Widget menu() {
    SystemUiOverlayStyle(statusBarColor: kib);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: SafeArea(
          child: Container(
        color: kib,
        height: height,
        width: width * 0.75,
        padding: EdgeInsets.all(15),
        child: Column(children: [
          Container(
              width: width,
              height: height * 0.31,
              child: Neumorphic(
                  padding: EdgeInsets.all(20),
                  style: NeumorphicStyle(
                    color: kib,
                    depth: 4,
                    intensity: 0.8,
                    shadowLightColorEmboss: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 90,
                              width: 90,
                              child: pp == null
                                  ? Icon(Icons.account_circle_rounded, size: 90)
                                  : ClipOval(child: Image.network(pp, fit: BoxFit.cover))),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('$fname $lname', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ],
                      ),
                    ],
                  ))),
          Container(
              margin: EdgeInsets.only(top: 20),
              //color: Colors.pink,
              width: width,
              height: height * 0.5,
              child: Column(children: [
                Container(
                    width: width,
                    height: height * 0.09,
                    child: NeumorphicButton(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Profile', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                      ),
                      onPressed: () {
                        showSnackbar(context, 'Feature not available yet');
                      },
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
                    height: height * 0.09,
                    child: NeumorphicButton(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Account Settings', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                      ),
                      onPressed: () {
                        showSnackbar(context, 'Feature not available yet');
                      },
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
                    height: height * 0.09,
                    child: NeumorphicButton(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('General Settings', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                      ),
                      onPressed: () {
                        showSnackbar(context, 'Feature not available yet');
                      },
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
                    height: height * 0.09,
                    child: NeumorphicButton(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Kibarua Website', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                      ),
                      onPressed: () {
                        showSnackbar(context, 'Feature not available yet');
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
              ])),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: width,
                  height: height * 0.09,
                  child: NeumorphicButton(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Log Out', style: TextStyle(color: Color(0xFF00AC7C), fontSize: 18)),
                    ),
                    onPressed: () {
                      Authorization().logOutDialog(context);
                    },
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      color: kib,
                      depth: 4,
                      intensity: 0.8,
                      shadowLightColorEmboss: Colors.white,
                    ),
                  )),
            ),
          )
        ]),
      )),
    );
  }

  // Asks user if they really want to cancel a job
  _cancelDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SlideInUp(
                duration: Duration(milliseconds: 500),
                child: new AlertDialog(
                  backgroundColor: Color(0xFF00AC7C).withOpacity(0.5),
                  title: Center(
                      child: Text('Confirm Cancellation',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  content: Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text('Are you sure you want to cancel?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        Center(
                          child: Text(
                              'If you cancel now you will incur a cancellation fee of'
                              ' Ksh. 100',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Center(
                        child: TextButton(
                            style: TextButton.styleFrom(side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Linking().cancelTask().then((value) => Navigator.of(context).pop());
                            },
                            child: Text(
                              'Cancel Job',
                              style: TextStyle(color: Colors.white),
                            ))),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                    ),
                    Center(
                        child: TextButton(
                            style: TextButton.styleFrom(side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Continue Job',
                              style: TextStyle(color: Colors.white),
                            ))),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
            ));
  }
}
