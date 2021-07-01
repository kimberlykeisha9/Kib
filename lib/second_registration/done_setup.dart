import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kib/methods.dart';
import 'package:provider/provider.dart';

import '../employer.dart';

class Setup extends StatefulWidget {
  @override
  _Setup createState() => _Setup();
}

class _Setup extends State<Setup> {
  ScrollController _scroll;

  void initState() {
    super.initState();
    _scroll = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: PageView(
          controller: _scroll,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _instructions(),
            _uploadProfilePicture(),
            _setPaymentMethod(),
            _setPaymentNumber(),
          ],
        ),
      ),
    );
  }

  // Page 1: Shows user instruction
  Widget _instructions() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: SlideInUp(
              duration: Duration(milliseconds: 500),
              child: Text('Finish setting up your account',
                  style: TextStyle(
                    color: Color(0xFF00AC7C),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            )),
            Center(
                child: SlideInUp(
              duration: Duration(milliseconds: 600),
              child: Text(
                  'Congratulations on getting your account approved! ' +
                      'All that\'s left to do is to upload a profile picture ' +
                      'and set up your payment details.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )),
            Center(
                child: ZoomIn(
              duration: Duration(milliseconds: 500),
              child: Container(
                  height: height * 0.085,
                  width: height * 0.085,
                  child: NeumorphicButton(
                    onPressed: () => _scroll.jumpTo(200.0),
                    style: NeumorphicStyle(
                      color: kib,
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex,
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios, color: Color(0xFF00AC7C)),
                    ),
                  )),
            )),
          ],
        ));
  }

  // Page 2: UI asking user to upload a profile picture
  Widget _uploadProfilePicture() {
    File _ppImage = Provider.of<Picture>(context).image;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: SlideInRight(
              duration: Duration(milliseconds: 600),
              child: Text('Upload a profile picture',
                  style: TextStyle(
                    color: Color(0xFF00AC7C),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            )),
            Center(
                child: SlideInRight(
              duration: Duration(milliseconds: 700),
              child: Text('Show your best smile when people view your profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )),
            GestureDetector(
              onTap: () => Provider.of<Picture>(context, listen: false).showPicker(context),
              child: SlideInRight(
                duration: Duration(milliseconds: 800),
                child: Container(
                  width: 150,
                  height: 150,
                  child: Neumorphic(
                    style: NeumorphicStyle(color: kib, boxShape: NeumorphicBoxShape.circle()),
                    child: _ppImage == null
                        ? Text('Select an image')
                        : ClipOval(
                            child: Image.file(_ppImage, fit: BoxFit.cover),
                          ),
                  ),
                ),
              ),
            ),
            Center(
                child: ZoomIn(
              duration: Duration(milliseconds: 500),
              child: Container(
                  height: height * 0.085,
                  width: height * 0.085,
                  child: NeumorphicButton(
                    onPressed: _ppImage == null
                        ? null
                        : () {
                            _scroll.jumpTo(600.0);
                            PictureTypes().uploadPP().then((value) => PictureTypes().getPPLink());
                          },
                    style: NeumorphicStyle(
                      color: kib,
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex,
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios, color: Color(0xFF00AC7C)),
                    ),
                  )),
            )),
          ],
        ));
  }

  int _selectedRadio = 0;
  changeSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  // Page 3: Asks user about payment method
  Widget _setPaymentMethod() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: SlideInRight(
              duration: Duration(milliseconds: 600),
              child: Text('Set up payment method',
                  style: TextStyle(
                    color: Color(0xFF00AC7C),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            )),
            Center(
                child: SlideInRight(
              duration: Duration(milliseconds: 700),
              child: Text('When you signed up with Kib, you used the number' + '$phone to sign up.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            )),
            SlideInRight(
              duration: Duration(milliseconds: 800),
              child: Container(
                child: Text(
                    'Currently Kib only accepts payments via M-Pesa so we require a number that uses Safaricom. Is this number the same as your M-Pesa number?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
            ),
            Wrap(
              children: [
                Container(
//                  height: 40,
                    child: RadioListTile(
                        title: Text('Yes'), value: 1, groupValue: _selectedRadio, onChanged: changeSelectedRadio)),
                Container(
//                  height: 40,
                    child: RadioListTile(
                        value: 2, groupValue: _selectedRadio, title: Text('No'), onChanged: changeSelectedRadio)),
              ],
            ),
            Center(
                child: ZoomIn(
              duration: Duration(milliseconds: 500),
              child: Container(
                  height: height * 0.085,
                  width: height * 0.085,
                  child: NeumorphicButton(
                    onPressed: () {
                      if (_selectedRadio == 1) {
                        storeData('paymentNumber', phone);
                        Employer().approveAccount().then((value) => Navigator.pushNamed(context, 'Dashboard'));
                      } else if (_selectedRadio == 2) {
                        _scroll.jumpTo(800.0);
                      }
                    },
                    style: NeumorphicStyle(
                      color: kib,
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex,
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios, color: Color(0xFF00AC7C)),
                    ),
                  )),
            ))
          ],
        ));
  }

  String cc = '+254';
  final _phone = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void onCountryCodeChanged(CountryCode value) {
    setState(() {
      cc = value.toString();
    });
  }

  // Page 4: User puts custom payment number
  Widget _setPaymentNumber() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
            child: SlideInRight(
          duration: Duration(milliseconds: 600),
          child: Text('Set payment number',
              style: TextStyle(
                color: Color(0xFF00AC7C),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        )),
        Center(
            child: SlideInRight(
          duration: Duration(milliseconds: 700),
          child: Text('Please ensure that this is a Safaricom number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              )),
        )),
        Form(
          key: _formKey,
          child: Flexible(
            child: SlideInRight(
              duration: Duration(milliseconds: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: kib,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: width * 0.25,
                      height: height * 0.085,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 5,
                          intensity: 1,
                          shadowLightColorEmboss: Colors.white,
                          color: kib,
                        ),
                        child: CountryCodePicker(
                          countryFilter: ['KE', 'TZ', 'UG'],
                          initialSelection: 'KE',
                          onChanged: (value) => onCountryCodeChanged(value),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: kib,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: width * 0.49,
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
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a phone number';
                                } else if (value.length < 9) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              controller: _phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
        Center(
            child: ZoomIn(
          duration: Duration(milliseconds: 500),
          child: Container(
              height: height * 0.085,
              width: height * 0.085,
              child: NeumorphicButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    storeData('paymentNumber', cc + _phone.text);
                    Employer().approveAccount().then((value) => Navigator.pushNamed(context, 'Dashboard'));
                  }
                },
                style: NeumorphicStyle(
                  color: kib,
                  boxShape: NeumorphicBoxShape.circle(),
                  shape: NeumorphicShape.convex,
                ),
                child: Center(
                  child: Icon(Icons.arrow_forward_ios, color: Color(0xFF00AC7C)),
                ),
              )),
        ))
      ]),
    );
  }
}
