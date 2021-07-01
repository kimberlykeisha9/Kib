import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/methods.dart';

Color kib = Color(0xFFECECEC);

class DOBUI extends StatefulWidget {
  @override
  _DOBUI createState() => _DOBUI();
}

class _DOBUI extends State<DOBUI> {
  TextEditingController dob = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int year;
  int month;
  int day;

  @override
  void initState() {
    super.initState();
    storeData('Last Known Page', 'DOB');
    Authorization().checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
//      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(30),
              height: height,
              width: width,
              child: Container(
                  height: height * 0.4,
                  width: width,
                  child: Column(
                    children: [
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
                                      Navigator.pushNamed(context, 'Names');
                                    },
                                    icon: Icon(Icons.arrow_back, size: 30, color: Color(0xFF00AC7C))),
                              ),
                              SlideInLeft(
                                duration: Duration(milliseconds: 400),
                                child: Text('Register',
                                    style:
                                        TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 30)),
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
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ZoomIn(
                                duration: Duration(milliseconds: 400),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 500),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 600),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 4.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 700),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 800),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                              ),
                            ],
                          )),
                      Form(
                          key: _formKey,
                          child: Container(
                            height: height * 0.25,
                            width: width,
                            child: ListView(
                              children: [
                                SlideInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: width,
                                      height: height * 0.085,
                                      child: Text('When were you born?',
                                          style: TextStyle(
                                              color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 24))),
                                ),
                                SlideInUp(
                                  duration: Duration(milliseconds: 600),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 0),
                                      decoration: BoxDecoration(
                                        color: kib,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      width: width,
                                      height: height * 0.085,
                                      child: Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: -5,
                                            intensity: 1,
                                            shadowLightColorEmboss: Colors.white,
                                            color: kib,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              onTap: () => _selectDate(context),
                                              readOnly: true,
                                              controller: dob,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter your date of birth';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Date of Birth',
                                                contentPadding: EdgeInsets.only(left: 20),
                                              ),
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        child: Center(
                          child: ZoomIn(
                            duration: Duration(milliseconds: 700),
                            child: Container(
                              margin: EdgeInsets.only(top: 0),
                              width: width * 0.5,
                              height: height * 0.085,
                              child: NeumorphicButton(
                                onPressed: () {
                                  addToSharedPref();
                                  if (_formKey.currentState.validate()) {
                                    Navigator.pushNamed(context, 'Phone');
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Next',
                                    style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                                  ),
                                ),
                                style: NeumorphicStyle(
                                  color: kib,
                                  depth: 6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime(DateTime.now().year - 18);
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(currentYear - 100),
        lastDate: DateTime(currentYear - 18, month = currentMonth, day = currentDay),
        builder: (context, child) {
          return ZoomIn(duration: Duration(milliseconds: 500), child: child);
        });
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        year = picked.year;
        month = picked.month;
        day = picked.day;
        dob.text = ('${picked.day}-${picked.month}-${picked.year}');
      });
    }
  }

  void addToSharedPref() async {
    storeData('DOB', dob.text);
  }
}
