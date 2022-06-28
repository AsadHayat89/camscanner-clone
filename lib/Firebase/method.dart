
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_test/Constants/global.dart';

import '../Login.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Succesfull");

      user.updateProfile(displayName: name);

      await _firestore.collection('users').doc(_auth.currentUser.uid).set({
        "name": name,
        "email": email,
        "status": "Unavalible",
        "uid": _auth.currentUser.uid,
      });

      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User currentUser;
  try {
    print("check1");

    User user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;
  print("check");
    if (user != null) {
      print("Login Sucessfull");
      _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) => user.updateProfile(displayName: value['name']));
      UserID=user.uid;
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()),(route) => false);
     // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future check() async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot user=(await _firestore.collection('users').doc(_auth.currentUser.uid).get());
  print(user['name']);
}

Future<String> getEmail() async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email=await _auth.currentUser.email.toString();
  return email;
}
Future<String> getName() async{
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email=await _auth.currentUser.displayName.toString();
  print("Name is metthod: "+email);
  return email;
}
