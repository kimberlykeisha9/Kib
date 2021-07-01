import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'methods.dart';

String employeeFirst;
String employeeLast;
double employeeRating;
String employeePhone;
String employeeUID;
String employeePP;

// Employee data
class Employee extends ChangeNotifier {
  String _first;
  String _last;
  String _uid;
  String _pp;
  String _phone;
  double _rating;

  String get first {
    return _first;
  }

  String get last {
    return _last;
  }

  String get uid {
    return _uid;
  }

  String get pp {
    return _pp;
  }

  String get phone {
    return _phone;
  }

  double get rating {
    return _rating;
  }

//	TODO Get the employee's details from firebase
  getEmployeeData() {
    userInfo.snapshots().listen((doc) {
      try {
        _first = doc.get(FieldPath(['currentJob', 'employeeFirst']));
        _last = doc.get(FieldPath(['currentJob', 'employeeLast']));
        _uid = doc.get(FieldPath(['currentJob', 'employeeUID']));
        _pp = doc.get(FieldPath(['currentJob', 'employeePP']));
        _phone = doc.get(FieldPath(['currentJob', 'employeePhone']));
        _rating = doc.get(FieldPath(['currentJob', 'employeeRating']));
      } on StateError catch (e) {
        print('There is no employee');
      }
    });
    notifyListeners();
  }
}
