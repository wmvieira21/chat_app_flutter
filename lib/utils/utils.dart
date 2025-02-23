import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebase = FirebaseAuth.instance;

showSnackBarMessage(BuildContext context, String errorMassage) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      content: Text(errorMassage),
    ),
  );
}
