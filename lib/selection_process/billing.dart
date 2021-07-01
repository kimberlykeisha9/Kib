import 'dart:async';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/chores.dart';
import 'package:kib/methods.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as k_worker;
import 'package:provider/provider.dart';

import '../employee.dart';
import '../employer.dart';
import '../linking.dart';

Color kib = Color(0xFFECECEC);
k_worker.FirebaseFirestore firestore = k_worker.FirebaseFirestore.instanceFor(app: Firebase.app('KibaruaWorkers'));

class Billing extends StatefulWidget {
  @override
  _Billing createState() => _Billing();
}

class _Billing extends State<Billing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Provider.of<Employer>(context).userData();
    fname = Provider.of<Employer>(context).firstName;
    lname = Provider.of<Employer>(context).lastName;
    pp = Provider.of<Employer>(context).pp;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: _scaffoldKey,
        //drawer: menu(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          margin: EdgeInsets.only(top: 15, bottom: 100),
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.625,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var job = selected[index];
                      return Container(
                        width: width,
                        height: height * 0.625,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              height: height * 0.2,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text('Job Selected', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text('Total Price', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(job.title, style: TextStyle(fontSize: 18)),
                                    Text(job.option ? job.optionA : job.optionB, style: TextStyle(fontSize: 18)),
                                    Text('ksh. ${job.option ? job.optionAPrice : job.optionBPrice}',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ]),
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Confirm that this is the correct selection',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18, color: Color(0xFF00AC7C))),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    width: width * 0.4,
                                    height: height * 0.075,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        storeData(
                                            'selectedPrice', '${job.option ? job.optionAPrice : job.optionBPrice}');
                                        WorkerQuery().searchForWorker(
                                          '${job.title}',
                                          fname,
                                          lname,
                                          pp,
                                          '${job.option ? job.optionAPrice : job.optionBPrice}',
                                        );
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Waiting()));
                                      },
                                      style: NeumorphicStyle(
                                        color: kib,
                                        depth: 4,
                                        intensity: 0.8,
                                        shadowLightColor: Colors.white,
                                      ),
                                      child: Center(
                                        child: Container(
                                            child: Text('Accept',
                                                style: TextStyle(
                                                  color: Color(0xFF00AC7C),
                                                  fontSize: 18,
                                                ))),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    width: width * 0.4,
                                    height: height * 0.075,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'Dashboard');
                                      },
                                      style: NeumorphicStyle(
                                        color: kib,
                                        depth: 4,
                                        intensity: 0.8,
                                        shadowLightColor: Colors.white,
                                      ),
                                      child: Center(
                                        child: Container(
                                            //   padding: EdgeInsets.all(15),
                                            child: Text('Cancel',
                                                style: TextStyle(
                                                  color: Color(0xFF00AC7C),
                                                  fontSize: 18,
                                                ))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool _failed = true;
  bool _isEngaged;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(minutes: 1), () => setState(() => _failed = false));
    userInfo.snapshots().listen((status) {
      _isEngaged = status.get('isEngaged');
      print('Status $_isEngaged');
      if (!_isEngaged) {
        print('User has not been linked');
        return null;
      } else if (_isEngaged == true) {
        print('User has been linked');
        _userLinked();
        this.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _searching(context, height, width);
  }

  Widget _searching(BuildContext context, double height, double width) {
    return new Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: _failed
            ? Container(
                height: height,
                width: width,
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        alignment: Alignment.center,
                        child: Text('Searching for available workers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF00AC7C),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ))),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(
                            child: NeumorphicProgressIndeterminate(
                          height: 20,
                          style: ProgressStyle(
                            accent: Color(0xFF00AC7C),
                            variant: Color(0xFF00AC7C).withOpacity(0.25),
                            depth: -5,
                          ),
                        )),
                      ),
                    ),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      alignment: Alignment.center,
                      child: Text('Please be patient',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF00AC7C),
//                        fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      height: height,
                      width: width,
                      padding: const EdgeInsets.all(50),
                      child: Center(
                        child: Text(
                          'There doesn\'t seems to be anyone available at the moment, '
                          'Please try again later',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF00AC7C),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                      onPressed: () => Navigator.pushNamed(context, 'Dashboard'),
                      style: NeumorphicStyle(color: kib),
                      child: Text('Alright',
                          style: TextStyle(
                            color: Color(0xFF00AC7C),
                            fontSize: 18,
                          ))),
                ],
              ),
      ),
    );
  }

  _userLinked() {
    Future.delayed(Duration(seconds: 10), () => Navigator.pushNamed(context, 'Dashboard'));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SlideInUp(
              duration: Duration(milliseconds: 500),
              child: new AlertDialog(
                title: Text('You have been linked with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00AC7C),
                    )),
                content: Wrap(children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Icon(Icons.account_circle, size: 100),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text('$employeeFirst $employeeLast',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text('Phone: $employeePhone',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF00AC7C),
                          )),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text('Rating: $employeeRating/5',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF00AC7C),
                          )),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
