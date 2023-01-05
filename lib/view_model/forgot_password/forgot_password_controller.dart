import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utlis.dart';
import '../services/session_manager.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.toastMessage('please check your email to recover your password');
        setLoading(false);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
