// User Information
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'methods.dart';

String user = auth.currentUser.uid;
String email = auth.currentUser.email;
String phone = auth.currentUser.phoneNumber;
String fname;
String lname;
String accStat;
String pp;
double rating = 4.7;

// User data
class Employer extends ChangeNotifier {
  String employerFirstName;
  String employerLastName;
  String profilePicture;

  String get pp {
    return profilePicture;
  }

  String get firstName {
    return employerFirstName;
  }

  String get lastName {
    return employerLastName;
  }

// TODO: Send information to Provider regarding user's information
  userData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    employerFirstName = pref.getString('First Name');
    employerLastName = pref.getString('Last Name');
    profilePicture = pref.getString('pp');
    notifyListeners();
  }

// TODO: Sends user information from sign up text fields to the database
  sendUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _fname = pref.getString('First Name');
    String _lname = pref.getString('Last Name');
    String _email = pref.getString('email');
    String _dob = pref.getString('DOB');
    String _id = pref.getString('id');
    String _phone = pref.getString('Phone');

    userInfo.set({
      'First Name': _fname,
      'Last Name': _lname,
      'Account Verification Status': 'pending',
      'Date Created': Timestamp.now(),
      'Basic Information': {
        'Email Address': _email,
        'Phone Number': _phone,
        'Date of Birth': _dob,
      },
      'Identification Document': _id,
    });
  }

// TODO: Get user data from Firebase Database
  getUserInformation() async {
    String _fname;
    String _accStat;
    String _lname;
    String _pp;
    await userInfo.get().then((value) {
      _fname = value.get('First Name');
      _lname = value.get('Last Name');
      _accStat = value.get('Account Verification Status');
      _pp = value.get('profilePicture');
      storeData('First Name', _fname);
      storeData('Last Name', _lname);
      storeData('Account Status', _accStat);
      storeData('pp', _pp);
    });
  }

// TODO: Approve account
  Future<void> approveAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String profilePicture = pref.getString('pp');
    int paymentNumber = int.parse(pref.getString('paymentNumber'));
    userInfo.update(
        {'profilePicture': profilePicture, 'Account Verification Status': 'approved', 'paymentNumber': paymentNumber});
  }
}
