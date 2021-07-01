import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:io';
import 'package:kib/methods.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

Color kib = Color(0xFFECECEC);

class IDUI extends StatefulWidget {
  @override
  _IDUI createState() => _IDUI();
}

class _IDUI extends State<IDUI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _idImage;

  @override
  void initState() {
    super.initState();
    storeData('Last Known Page', 'ID');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _idImage = Provider.of<Picture>(context).image;
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
                                    Navigator.pushNamed(context, 'Phone');
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
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        height: height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ZoomIn(
                              duration: Duration(milliseconds: 400),
                              child: Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                            ),
                            ZoomIn(
                              duration: Duration(milliseconds: 500),
                              child: Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                            ),
                            ZoomIn(
                              duration: Duration(milliseconds: 600),
                              child: Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                            ),
                            ZoomIn(
                              duration: Duration(milliseconds: 700),
                              child: Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                            ),
                            ZoomIn(
                              duration: Duration(milliseconds: 800),
                              child: Container(width: 30, height: 30, child: Image.asset('assets/images/Group 4.png')),
                            ),
                          ],
                        )),
                    Form(
                        child: Container(
                      height: height * 0.5,
                      width: width,
                      child: Column(
                        children: [
                          SlideInUp(
                            duration: Duration(milliseconds: 500),
                            child: Container(
                                margin: EdgeInsets.only(top: 10),
                                width: width,
                                height: height * 0.05,
                                child: Text('Identification',
                                    style:
                                        TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 21))),
                          ),
                          Center(
                            child: SlideInUp(
                              duration: Duration(milliseconds: 600),
                              child: Text(
                                  'For security purposes and to verify your identity, we require an identification document. This could be your National ID, Birth Certificate or National Passport',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Provider.of<Picture>(context, listen: false).showPicker(context),
                            child: SlideInUp(
                              duration: Duration(milliseconds: 700),
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    color: kib,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: width,
                                  height: height * 0.2,
                                  child: Neumorphic(
                                      drawSurfaceAboveChild: false,
                                      style: NeumorphicStyle(
                                        depth: -5,
                                        border: NeumorphicBorder(color: Colors.grey[400]),
                                        intensity: 0.9,
                                        shadowLightColorEmboss: Colors.white,
                                        color: kib,
                                      ),
                                      child: _idImage == null
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: Text('No ID Selected'),
                                            )
                                          : Image.file(
                                              _idImage,
                                              fit: BoxFit.cover,
                                            ))),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      child: Center(
                        child: ZoomIn(
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            margin: EdgeInsets.only(top: 0),
                            width: width * 0.5,
                            height: height * 0.085,
                            child: NeumorphicButton(
                              onPressed: () {
                                _idImage == null
                                    ? showSnackbar(context, 'Please upload your ID')
                                    : showSnackbar(context, 'Added ID');
                                PictureTypes().uploadID().then((value) => (Navigator.pushNamed(
                                    context,
                                    'Comp'
                                    'let'
                                    'ed '
                                    'Reg')));
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Next',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)),
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
                ))),
      ),
    );
  }
}
