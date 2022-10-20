import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/phone_auth/sign_in_with_phone.dart';
import 'email_auth/login_screen.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("ISJ5TjwqUfinzORcbcbI")
  //     .get();

  //     log(snapshot.data().toString());

  // Map<String, dynamic> newUserData = {
  //   "name": "Ranshu Mangal",
  //   "email": "ranshumangal@gmail.com"
  // };

  // await _firestore.collection("users").doc("Your-id-here").update({
  //   "email" : "ranshu@gmail.com"
  // });
  // log("New user saved!");

  // await _firestore.collection("users").doc("7GT08ClUKzhzjXBL13XX").delete();
  // log("User Deleted!");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomeScreen()
          : SignInWithPhone(),
    );
  }
}
