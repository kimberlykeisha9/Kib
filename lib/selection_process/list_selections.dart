import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/chores.dart';

Color kib = Color(0xFFECECEC);

class SelectedList extends StatefulWidget {
  @override
  _SelectedList createState() => _SelectedList();
}

class _SelectedList extends State<SelectedList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      //drawer: menu(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          width: width,
          height: height * 0.13,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.pushNamed(context, 'Bill');
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
                  child: Text('Next')),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back, color: Color(0xFF00AC7C)),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 27.5),
                    height: 80,
                    width: 80,
                    child: Hero(tag: 'logo', child: Image.asset('assets/images/greeniconlogo.png'))),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: 15, bottom: 100),
      ),
    );
  }
}
