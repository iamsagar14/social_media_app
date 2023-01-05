import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utlis.dart';
import '../services/session_manager.dart';

class LogInController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void logIN(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Navigator.pushNamed(context, RouteName.dashBooardScreen);
        Utils.toastMessage('user created successfully !');
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
