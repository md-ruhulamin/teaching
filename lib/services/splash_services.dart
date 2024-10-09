// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:edtech/screen/homepage.dart';
import 'package:edtech/screen/signin_Test.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 2),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    } else {
      Timer(
          Duration(minutes: 30),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInScreen())));
    }
  }
}
