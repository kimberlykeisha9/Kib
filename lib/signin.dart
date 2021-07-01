import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'employer.dart';
import 'methods.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:animate_do/animate_do.dart';

Color kib = Color(0xFFECECEC);

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 7).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZoomIn(
                                duration: Duration(milliseconds: 500),
                                child: Container(
                                  margin: EdgeInsets.only(left: 80),
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'Welcome');
                                      },
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.centerLeft,
                                      icon: Icon(Icons.arrow_forward, size: 30, color: Color(0xFF00AC7C))),
                                ),
                              ),
                              SlideInRight(
                                duration: Duration(milliseconds: 600),
                                child: Text('Sign In',
                                    style:
                                        TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 30)),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: height * 0.125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  child: NeumorphicButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        showSnackbar(context, 'Facebook Sign In is not available yet');
                                      },
                                      style: NeumorphicStyle(
                                        depth: _animation.value,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: kib,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        child: FaIcon(FontAwesomeIcons.facebook, size: 15),
                                      ))),
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: NeumorphicButton(
                                      onPressed: () {
                                        showSnackbar(context, 'Twitter Sign In is not available yet');
                                      },
                                      padding: EdgeInsets.zero,
                                      style: NeumorphicStyle(
                                        depth: _animation.value,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: kib,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        child: FaIcon(FontAwesomeIcons.twitter, size: 15),
                                      ))),
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: NeumorphicButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        showSnackbar(context, 'Google Sign In is not available yet');
                                      },
                                      style: NeumorphicStyle(
                                        depth: _animation.value,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: kib,
                                      ),
                                      child: Center(
                                          child: Icon(
                                        FontAwesomeIcons.google,
                                        size: 15,
                                      )))),
                            ],
                          )),
                      Form(
                          key: _formKey,
                          child: Container(
                            height: height * 0.31,
                            width: width,
                            child: Column(
                              children: [
                                Flexible(
                                  child: SlideInUp(
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
                                              intensity: 0.8,
                                              shadowLightColorEmboss: Colors.white,
                                              color: kib,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
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
                                                controller: email,
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(color: Color(0xFF00AC7C)),
                                                  border: InputBorder.none,
                                                  hintText: 'Email Address',
                                                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                                                ),
                                              ),
                                            ))),
                                  ),
                                ),
                                Flexible(
                                  child: SlideInUp(
                                    duration: Duration(milliseconds: 800),
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
                                              intensity: 0.8,
                                              shadowLightColorEmboss: Colors.white,
                                              color: kib,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please your password';
                                                  }
                                                  return null;
                                                },
                                                controller: pass,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(color: Color(0xFF00AC7C)),
                                                  suffixIconConstraints: BoxConstraints(maxHeight: 10, minHeight: 5),
                                                  border: InputBorder.none,
                                                  hintText: 'Password',
                                                  contentPadding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                ),
                                              ),
                                            ))),
                                  ),
                                ),
                                SlideInRight(
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        child: Text('Forgot Password?', style: TextStyle(color: Color(0xFF00AC7C)))),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        child: Center(
                          child: ZoomIn(
                            duration: Duration(milliseconds: 700),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: height * 0.085,
                                minWidth: width * 0.5,
                                maxWidth: width * 0.5,
                                maxHeight: height * 0.085,
                              ),
                              child: NeumorphicButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Authorization()
                                        .signInWithEmailAndPassword(email.text, pass.text, context)
                                        .then((value) {
                                      if (Authorization().checkAuthState() == true) {
                                        if (Authorization().checkEmailVerification() == true) {
                                          Employer().getUserInformation();
                                          Navigator.pushNamed(context, 'Dashboard');
                                        } else {
                                          Navigator.of(context).pop();
                                          Future.delayed(Duration(seconds: 10), () => Authorization().signOut());
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                  'You need to verify your email address in order to proceed. ' +
                                                      'Please check your email or spam folder.'),
                                              action: SnackBarAction(
                                                  textColor: Colors.grey[850],
                                                  label: 'Resend Email',
                                                  onPressed: () => auth.currentUser.sendEmailVerification()),
                                              duration: Duration(seconds: 10),
                                              backgroundColor: Color(0xFF00AC7C)));
                                        }
                                      } else {
                                        showSnackbar(context, 'An error has occured. Please try again');
                                      }
                                    });
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sign In',
                                    style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
                                  ),
                                ),
                                style: NeumorphicStyle(
                                  color: kib,
                                  depth: 6,
                                  shadowLightColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: ZoomIn(
                            duration: Duration(milliseconds: 400),
                            child: Container(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'Register');
                                },
                                child: Text('Don\'t have an account? Sign up here',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[850])),
                              ),
                            ),
                          ))
                    ],
                  ))),
        ),
      ),
    );
  }
}
