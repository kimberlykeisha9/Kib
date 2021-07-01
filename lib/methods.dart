import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:kib/chores.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'employer.dart';

Color kib = Color(0xFFECECEC);

// Firebase Shortcuts
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseApp workerApp = Firebase.app('Worker');
FirebaseFunctions functions = FirebaseFunctions.instanceFor(app: workerApp);

// Paths to Firebase stores
DocumentReference userInfo = firestore.collection('users').doc(user);

final _picker = ImagePicker();

// Boolean to check if something is loading
bool isLoading = false;

// Store shared preferences
void storeData(String title, String toBeSet) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(title, toBeSet);
  print(pref.getString(title));
}

class Authorization {
  // TODO: Check user's authentication State
  bool checkAuthState() {
    if (auth.currentUser == null) {
      print('There is no user');
    } else {
      print('There is a user');
    }
    return auth.currentUser != null;
  }

  // TODO Check if user's email is verified
  bool checkEmailVerification() {
    auth.authStateChanges().listen((User user) {
      if (!user.emailVerified) {
        print('This user\'s email is not verified');
      } else {
        print('This user\'s email is verified');
      }
    });
    return auth.currentUser.emailVerified;
  }

  // TODO Signs in user
  Future<void> signInWithEmailAndPassword(String emailGiven, String passwordGiven, BuildContext context) async {
    try {
      isLoading = true;
      loading(context);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailGiven,
        password: passwordGiven,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print(e);
      if (e.code == 'user-not-found') {
        showSnackbar(context, 'There was no user found for that email');
      } else if (e.code == 'wrong-password') {
        showSnackbar(context, 'You have a wrong password. Please enter the correct one');
      }
    }
  }

  // TODO Creates user account
  Future<void> createUserWithEmailAndPassword(String emailGiven, String passwordGiven, BuildContext context) async {
    try {
      isLoading = true;
      loading(context);
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailGiven, password: passwordGiven);
      auth.currentUser.sendEmailVerification();
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print(e);
      if (e.code == 'weak-password') {
        showSnackbar(context, 'This password is too weak. Please select another one');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(context, 'This email address is already in use. Sign in instead or use another one');
      }
    } catch (e) {
      print(e);
    }
  }

  // TODO Prompts user if they want to log out
  Future<bool> logOutDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      useRootNavigator: false,
      context: context,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: new AlertDialog(
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(side: BorderSide(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  signOut().then((value) => checkAuthState() ? null : Navigator.pushNamed(context, 'Welcome'));
                },
                child: Text('Log Out',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kib,
//                            fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(margin: const EdgeInsets.only(top: 5)),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(side: BorderSide(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kib,
//                          fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(margin: const EdgeInsets.only(top: 5))
          ],
          backgroundColor: Color(0xFF00AC7C).withOpacity(0.5),
          contentPadding: EdgeInsets.all(0),
          content: Container(
              padding: EdgeInsets.all(40),
              height: 150,
              width: 80,
              child: Center(
                child: Text('Are you sure you want to log out?',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.white)),
              )),
        ),
      ),
    );
  }

  // TODO Logs the user out
  Future<void> signOut() async {
    return await auth.signOut();
  }
}

// Show Snackbar
showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

// Loading Widget that shows Circular Progress Indicator
Future<Widget> loading(BuildContext context) {
  isLoading
      ? showDialog(
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          context: context,
          builder: (_) => new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()]))
      : null;
  return null;
}

// Sets shared preferences data from database
void setSharedPreferences() async {
  String _fname;
  String _lname;
  String _accStat;
  userInfo.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      _fname = documentSnapshot.get(FieldPath(['First Name']));
      _lname = documentSnapshot.get(FieldPath(['Last Name']));
      _accStat = documentSnapshot.get(FieldPath(['Account Verification Status']));
      print('$_fname $_lname $_accStat');
    }
    storeData('First Name', _fname);
    storeData('Last Name', _lname);
    storeData('Account Status', _accStat.toString());
  });
}

// Class to select images and store them in provider
class Picture extends ChangeNotifier {
  File _image;
  File get image {
    return _image;
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
                  child: new Wrap(children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                }),
            new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                })
          ])));
        });
  }

  _imgFromCamera() async {
    final image = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    _image = File(image.path);
    notifyListeners();
  }

  _imgFromGallery() async {
    final image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    _image = File(image.path);
    notifyListeners();
  }
}

class PictureTypes extends Picture {
// Profile Picture methods
// TODO: Upload Profile Picture to Firebase Storage
  Future<void> uploadPP() async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('Users')
          .child(user)
          .child('User Information')
          .child('Profile')
          .child('ProfilePicture')
          .putFile(image);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

//TODO: Gets profile picture link
  Future<String> getPPLink() async {
    String pp;
    var ppPhoto = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(user)
        .child('User Information')
        .child('Profile')
        .child('ProfilePicture');
    var ppURL = await ppPhoto.getDownloadURL();
    pp = ppURL.toString();
    print(pp);
    storeData('pp', pp);
    return pp;
  }

// ID Picture methods
// TODO: Upload ID Picture to Firebase Storage
  Future<void> uploadID() async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('Users')
          .child(user)
          .child('User Information')
          .child('Identification')
          .child('ID')
          .putFile(image);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

// TODO: Gets ID Document Link
  Future<String> getIDLink() async {
    String id;
    var idPhoto = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(user)
        .child('User Information')
        .child('Identification')
        .child('ID');
    var idURL = await idPhoto.getDownloadURL();
    id = idURL.toString();
    print(id);
    storeData('id', id);
    return id;
  }
}
