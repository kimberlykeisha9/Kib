import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/methods.dart';
import 'package:animate_do/animate_do.dart';

Color kib = Color(0xFFECECEC);

class Emailpass extends StatefulWidget {
  @override
  _EmailPass createState() => _EmailPass();
}

TextEditingController email = new TextEditingController();
TextEditingController pass = new TextEditingController();
TextEditingController confirmPass = new TextEditingController();

class _EmailPass extends State<Emailpass> {
  bool hidePass = true;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    storeData('Last Known Page', 'Register');
    Authorization().checkAuthState() ? Navigator.pushNamed(context, 'Dashboard') : null;
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
                                      Navigator.pushNamed(context, 'Welcome');
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
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 4.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 500),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Container(
                            height: height * 0.35,
                            width: width,
                            child: ListView(
                              children: [
                                SlideInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        color: kib,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      width: width,
                                      height: height * 0.085,
                                      child: Neumorphic(
                                          style: NeumorphicStyle(
                                              depth: -4,
                                              intensity: 1,
                                              shadowLightColorEmboss: Colors.white,
                                              color: kib,
                                              border: NeumorphicBorder(color: Colors.grey[300])),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: email,
                                              keyboardType: TextInputType.emailAddress,
                                              validator: (value) {
                                                Pattern pattern =
                                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                RegExp regex = new RegExp(pattern);
                                                if (value.isEmpty) {
                                                  return 'Please your email address';
                                                } else if (!regex.hasMatch(value)) {
                                                  return 'Please enter a valid email';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(color: Color(0xFF00AC7C)),
                                                border: InputBorder.none,
                                                hintText: 'Email Address',
                                                contentPadding: EdgeInsets.only(left: 20),
                                              ),
                                            ),
                                          ))),
                                ),
                                SlideInUp(
                                  duration: Duration(milliseconds: 600),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 20),
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
                                              border: NeumorphicBorder(color: Colors.grey[300])),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: pass,
                                              obscureText: hidePass,
                                              validator: (value) {
                                                //print(value);
                                                if (value.isEmpty) {
                                                  return 'Please enter a password';
                                                } else if (value.length < 6) {
                                                  return 'Please enter a longer password';
                                                } else if (value != confirmPass.text) {
                                                  return 'Passwords do not match';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(color: Color(0xFF00AC7C)),
                                                border: InputBorder.none,
                                                hintText: 'Password',
                                                contentPadding: EdgeInsets.only(left: 20),
                                              ),
                                            ),
                                          ))),
                                ),
                                SlideInUp(
                                  duration: Duration(milliseconds: 700),
                                  child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        color: kib,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      width: width,
                                      height: height * 0.085,
                                      child: Neumorphic(
                                          style: NeumorphicStyle(
                                              depth: -4,
                                              intensity: 1,
                                              shadowLightColorEmboss: Colors.white,
                                              color: kib,
                                              border: NeumorphicBorder(color: Colors.grey[300])),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              validator: (value) {
                                                //print(value);
                                                if (value.isEmpty) {
                                                  return 'Please enter your confirmed password';
                                                } else if (value != pass.text) {
                                                  return 'Passwords do not match';
                                                }
                                                return null;
                                              },
                                              obscureText: true,
                                              controller: confirmPass,
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(color: Color(0xFF00AC7C)),
                                                border: InputBorder.none,
                                                hintText: 'Confirm Password',
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
                                  print(email.text);
                                  print(pass.text);
                                  print(confirmPass.text);
                                  addToSharedPref();
                                  if (_formKey.currentState.validate()) {
                                    Authorization()
                                        .createUserWithEmailAndPassword(email.text, pass.text, context)
                                        .then((value) {
                                      Authorization().checkAuthState()
                                          ? Navigator.pushNamed(context, 'Names')
                                          : showSnackbar(context, 'Something went wrong');
                                    });
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ZoomIn(
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'Sign In');
                                },
                                child: Text('Have an account? Sign in here',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[850]))),
                          ),
                        ),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }

  void addToSharedPref() async {
    storeData('email', email.text);
  }
}
