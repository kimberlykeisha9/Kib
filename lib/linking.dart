import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as workerDB;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'employer.dart';
import 'methods.dart';
import 'package:http/http.dart' as http;

String task;
double amount;
int ratingGiven;

int currentHour = DateTime.now().hour, currentMinute = DateTime.now().minute;

// Worker data
workerDB.FirebaseFirestore _firestore = workerDB.FirebaseFirestore.instanceFor(app: workerApp);
workerDB.CollectionReference workerDatabase = _firestore.collection('user-info');

class Linking {
  HttpsCallable search = functions.httpsCallable('searchForWorkers');

// TODO: Search for worker using cloud functions
  sendNotification(String token, String fname, String lname, String selected, String amount, String profilePic) async {
    try {
      final HttpsCallableResult result = await search.call(<String, String>{
        'token': token,
        'fname': fname,
        'lastname': lname,
        'selected': selected,
        'uid': user,
        'rating': '$rating',
        'phone': phone,
        'amount': amount,
        'profile': profilePic,
      });
      print(result.data);
    } on FirebaseFunctionsException catch (e) {
      print(e.code);
    }
  }

// TODO: Sets user as free
  Future<void> disengage() {
    return userInfo.update({
      'isEngaged': false,
      'currentJob': FieldValue.delete(),
    });
  }

// TODO: Cancel The Task
  cancelTask() {
    // Current task reference
    DocumentReference activeJob;
    String _workerUID;

    return userInfo.get().then((doc) {
      activeJob = doc.get('currentJob');
      // Update employer record on job status
      activeJob.update({
        'Ended at': '${currentHour.toString()}:${currentMinute.toString()}',
        'Ended': Timestamp.now(),
        'paymentCompleted': 'cancelledByEmployer',
      }).then((value) {
        // Remove worker's engagement status
        activeJob.get().then((doc) {
          workerDB.DocumentReference _workerActiveJob;
          _workerUID = doc.get('employeeUID');

          workerDatabase.doc(_workerUID).get().then((workerDoc) {
            _workerActiveJob = workerDoc.get('currentJob');
            // Update employee job record
            _workerActiveJob.update({
              'Ended at': '${currentHour.toString()}:${currentMinute.toString()}',
              'Ended': Timestamp.now(),
              'paymentCompleted': 'cancelledByEmployer',
            }).then((value) {
              // Disengage employee
              workerDatabase.doc(_workerUID).update({
                'isEngaged': false,
              });
            });
          });
        });
      }).then((value) {
        userInfo.update({
          'isEngaged': false,
          'cancelledJobs': FieldValue.increment(1),
        });
      });
    });
  }

  finishJob(BuildContext context) {
    // Current task reference
    DocumentReference activeJob;
    String _workerUID;

    return userInfo.get().then((doc) {
      storeData('paymentNumber', doc.get('paymentNumber').toString());
      activeJob = doc.get('currentJob');
      // Update employer record on job status
      activeJob.update({
        'Ended at': '${currentHour.toString()}:${currentMinute.toString()}',
        'Ended': Timestamp.now(),
        'paymentCompleted': 'pending',
      }).then((value) {
        // Remove worker's engagement status
        activeJob.get().then((doc) {
          workerDB.DocumentReference _workerActiveJob;
          storeData('amountDue', doc.get('amount').toString());
          _workerUID = doc.get('employeeUID');

          workerDatabase.doc(_workerUID).get().then((workerDoc) {
            _workerActiveJob = workerDoc.get('currentJob');
            // Update employee job record
            _workerActiveJob.update({
              'Ended at': '${currentHour.toString()}:${currentMinute.toString()}',
              'Ended': Timestamp.now(),
              'paymentCompleted': 'pending',
            }).then((value) {
              // Disengage employee
              workerDatabase.doc(_workerUID).update({
                'isEngaged': false,
              });
            });
          });
        });
      }).then((value) {
        userInfo.update({
          'isEngaged': false,
        });
      }).then((val) {
        requestRating(context);
      });
    });
  }

  // TODO Request a rating for the current worker
  int _rating = 5;

  requestRating(BuildContext context) async {
    String ratingAid() {
      if (_rating == 1) {
        return 'Terrible';
      }
      if (_rating == 2) {
        return 'Bad';
      }
      if (_rating == 3) {
        return 'Okay';
      }
      if (_rating == 4) {
        return 'Good';
      }
      if (_rating == 5) {
        return 'Excellent';
      }
      return 'Excellent';
    }

    TextEditingController ratingNotes = new TextEditingController();

    SharedPreferences pref = await SharedPreferences.getInstance();

    String employeeFirst = pref.getString('employeeFirst');
    String employeeLast = pref.getString('employeeLast');

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => new StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            title: Text(
              'You\'ve completed your job with $employeeFirst $employeeLast',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Wrap(
                children: [
                  Text(
                    'How was your experience working with $employeeFirst?',
                    textAlign: TextAlign.center,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 80,
                        width: 60,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('$_rating',
                                style: TextStyle(color: Color(0xFF00AC7C), fontSize: 25, fontWeight: FontWeight.bold)),
                            Icon(Icons.star, size: 25, color: Color(0xFF00AC7C)),
                          ],
                        )),
                  ),
                  Slider(
                      min: 1,
                      max: 5,
                      divisions: 4,
                      value: _rating.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _rating = value.toInt();
                        });
                      }),
                  Center(
                      child:
                          Text(ratingAid(), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00AC7C)))),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 80,
                    child: TextField(
                        controller: ratingNotes,
                        maxLines: 2,
                        decoration: InputDecoration(hintText: 'Any additional comment?')),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text('Continue', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    storeData('ratingGiven', _rating.toString());
                    Navigator.pop(context);
                    _payForTask();
                  }),
            ]);
      }),
    );
  }

  // TODO Make Payment
  Future<void> _payForTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int _paymentNumber = int.parse(pref.getString("paymentNumber"));
    double _amount = double.parse(pref.getString("amount"));
    String _rate = pref.getString('ratingGiven');
    print(_amount);
    print(_paymentNumber);

    var transactionInitialization;

    try {
      transactionInitialization = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: _amount,
        partyA: "$_paymentNumber",
        partyB: "174379",
        callBackURL: Uri.parse("https://www.google.com"),
        accountReference: "Kib",
        phoneNumber: "254738324562",
        baseUri: Uri.parse("https://www.sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey: "bCUmG7ixAeBB8bYBHFd48m9UvSinUqkQvL4o6iOClRN0R" +
            "r4ujI1LA662d50sfk8+wTrV46WRQIEJDyfBieYDAaOZ5U99ENUXDwAb4LgME" +
            "PB6IayaJ4lp8kNUlaYdpuB1ylueJuWRUQ7CZhxj94e4uDDt1RgH8Uwdx8k3g" +
            "XfF20GlJFu0WC44IxvehFAzMEkb8H1NuDTNv8PsEPiM5Noth+08BYuwaDtXy" +
            "jcYS0pq1zh7mHLWRVDCYAxaZ0+gHngq29neXiXoL2TxsY8Gw+iq2NrK/DVD7" +
            "+Cyu4o6YLcVuiJ3Giwam5c2fKysHKoVGpXJccC135691FGucM0t+9lefw==",
      );
      print(transactionInitialization);
      userInfo.get().then((doc) {
        DocumentReference currentJob = doc.get('currentJob');
        currentJob.update({
          'paymentRequestedFrom': _paymentNumber,
          'ratingGiven': _rate,
          'paymentCompleted' : 'approved'
        });
      });
      return transactionInitialization;
    } catch (e) {
      print("Caught an exception: ${e.toString()}");
      userInfo.get().then((doc) {
        DocumentReference currentJob = doc.get('currentJob');
        currentJob.update({
          'paymentRequestedFrom': _paymentNumber,
          'ratingGiven': _rate,
          'paymentCompleted' : 'rejected'
        });
      });
    }
  }
}

class GetLocation {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  // TODO Check if location services are enabled
  Future checkIfLocationIsEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  // TODO: Get user's current location
  // Will request permission if location is not enabled
  getLocation() async {
    if (_permissionGranted == PermissionStatus.granted) {
      _locationData = await location.getLocation();
      storeData('latitude', _locationData.latitude.toString());
      storeData('longitude', _locationData.longitude.toString());
    } else {
      _permissionGranted = await location.requestPermission();
    }
  }
}

class WorkerQuery extends GetLocation with Linking {
  CollectionReference _workers = _firestore.collection('user-info');
  final geo = Geoflutterfire();

  // TODO: Search for workers
  Future searchForWorker(String task, String fname, String lname, String profilePic, String amount) async {
    print('searching');
    getLocation();
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Get user's current location
    GeoFirePoint center;
    double latitude, longitude;
    location.getLocation().then((currentLocation) {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      center = geo.point(latitude: latitude, longitude: longitude);
    });
    // Query for available workers
    var availableWorkers = _workers
        .where('token', isNotEqualTo: null)
        .where('accountStatus', isEqualTo: 'approved')
        .where('isEngaged', isEqualTo: false)
        .where('selectedJobs', arrayContains: task);

    Stream<List<DocumentSnapshot>> stream =
        geo.collection(collectionRef: availableWorkers).within(center: center, radius: 1, field: 'location');

    return availableWorkers.get().then((docs) {
      if (docs.size > 0) {
        print('There are some workers');
        stream.listen((workerList) {
          print(workerList.length);
          workerList.forEach((worker) {
            print('There are workers within range');
            String token = worker.get('token');
            sendNotification(token, fname, lname, task, amount, profilePic);
          });
        });
        stream.timeout(Duration(minutes: 1));
      } else {
        print('There are no workers');
      }
    });
  }
}
