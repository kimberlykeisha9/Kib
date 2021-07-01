import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/methods.dart';

Color kib = Color(0xFFECECEC);

class NameUI extends StatefulWidget {
  @override
  _NameUI createState() => _NameUI();
}

class _NameUI extends State<NameUI> {
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    storeData('Last Known Page', 'Names');
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
                                      Navigator.pushNamed(context, 'Sign In');
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
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 4.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 600),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Container(
                            height: height * 0.35,
                            width: width,
                            child: ListView(
                              children: [
                                SlideInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: width,
                                      height: height * 0.085,
                                      child: Text('What is your name?',
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
                                              controller: fname,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter your first name';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'First Name',
                                                contentPadding: EdgeInsets.only(left: 20),
                                              ),
                                            ),
                                          ))),
                                ),
                                SlideInUp(
                                  duration: Duration(milliseconds: 700),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 25),
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
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter your last name';
                                                }
                                                return null;
                                              },
                                              controller: lname,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Last Name',
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
                                  if (_formKey.currentState.validate()) {
//                                  showSnackbar('Adding names');
                                    _addToSharedPref();
                                    Navigator.pushNamed(context, 'DOB');
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

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<Widget> loading() {
    showDialog(
        context: context,
        builder: (_) => new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()]));
  }

  void _addToSharedPref() async {
    storeData('First Name', fname.text);
    storeData('Last Name', lname.text);
  }
}
