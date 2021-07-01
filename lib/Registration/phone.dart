import 'dart:async';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:kib/methods.dart';

Color kib = Color(0xFFECECEC);

class PhoneUI extends StatefulWidget {
  @override
  _PhoneUI createState() => _PhoneUI();
}

class _PhoneUI extends State<PhoneUI> {
  TextEditingController _phone = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String cc = '+254';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    storeData('Last Known Page', 'Phone');
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
                                      Navigator.pushNamed(context, 'DOB');
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
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 5.png')),
                              ),
                              ZoomIn(
                                duration: Duration(milliseconds: 700),
                                child:
                                    Container(width: 30, height: 30, child: Image.asset('assets/images/Group 4.png')),
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
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 10),
                                      width: width,
                                      height: height * 0.085,
                                      child: Text('What is your phone number?',
                                          style: TextStyle(
                                              color: Colors.grey[850], fontWeight: FontWeight.bold, fontSize: 21))),
                                ),
                                SlideInUp(
                                  duration: Duration(milliseconds: 600),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(top: 0),
                                          decoration: BoxDecoration(
                                            color: kib,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          width: width * 0.225,
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
                                          width: width * 0.55,
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
                                    verifyPhoneNumberDialog(context);
                                  }
                                  // Navigator.pushNamed(context, 'ID');
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

  void addToSharedPref() async {
    storeData('Phone', cc + _phone.text);
  }

  void onCountryCodeChanged(CountryCode value) {
    setState(() {
      cc = value.toString();
    });
  }

  verifyPhoneNumberDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            backgroundColor: Color(0xFF00AC7C).withOpacity(0.25),
            contentPadding: EdgeInsets.all(0),
            title: Text('Confirm number',
                style: TextStyle(
                  fontSize: 18,
                  color: kib,
                )),
            content: ClipRect(
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                    padding: EdgeInsets.all(20),
                    height: 150,
                    width: 80,
                    child: Center(
                      child: Text('$cc ${_phone.text}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: kib, fontWeight: FontWeight.bold)),
                    )),
              ),
            ),
            actions: [
              ClipRect(
                clipBehavior: Clip.antiAlias,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            verifyPhone();
                          },
                          child: Text('Yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kib,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text('No',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kib,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future verifySMS(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return new AlertDialog(
              backgroundColor: Color(0xFF00AC7C).withOpacity(0.25),
              contentPadding: EdgeInsets.all(0),
              title: Text('Enter SMS Code',
                  style: TextStyle(
                    color: kib,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              content: ClipRect(
                clipBehavior: Clip.antiAlias,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: width,
                      height: 100,
                      child: TextField(
                        controller: sms,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kib,
                          fontSize: 18,
                        ),
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterStyle: TextStyle(color: kib),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kib)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kib)),
                        ),
                      )),
                ),
              ),
              actions: [
                ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              linkPhoneCredential().then((value) => Navigator.pushNamed(context, 'ID'));
                              //Navigator.pushNamed(context, 'ID');
                            },
                            child: Text('Verify',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kib,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () => verifyPhone(),
                            child: Text('Retry',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kib,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }

  String _verificationID;
  final sms = new TextEditingController();

  Future<void> linkPhoneCredential() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationID,
        smsCode: sms.text,
      );
      await FirebaseAuth.instance.currentUser.linkWithCredential(credential);
      showSnackbar(context, 'Successfully verified  this phone number');
      print('Verified the number ${cc + _phone.text}');
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushNamed(context, 'ID');
    } catch (e) {
      showSnackbar(context, 'Failed to verify ${cc + _phone.text}. Please try again');
      print(e);
    }
  }

  void verifyPhone() async {
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      await FirebaseAuth.instance.currentUser.linkWithCredential(phoneAuthCredential);
      print('Phone number automatically verified and credential linked');
      showSnackbar(context, 'Phone number verified');
    };
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      showSnackbar(context, 'Phone verification failed');
      print(e);
    };
    PhoneCodeSent phoneCodeSent = (String verificationID, [int forceResendingToken]) {
      verifySMS(context);
      showSnackbar(context, 'Please check your phone for the verification code');
      _verificationID = verificationID;
    };
    PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout = (String verificationID) {
      showSnackbar(context, 'Code has timed out $verificationID');
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: cc + _phone.text,
          timeout: const Duration(seconds: 15),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar(context, 'Phone verification failed');
      print(e);
    }
  }
}
