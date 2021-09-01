import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoga_posture_detection/screens/authentication/phone.dart';
import 'package:yoga_posture_detection/screens/homeView.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<int> register(String name, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print(name + ' name');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 2;
    } else if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 1;
    }
  } catch (e) {
    print(e.toString());
    return 3;
  }
  return 0;
}

class AuthService {
  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  Future<bool> signIn(AuthCredential authCreds) async {
    bool result = true;
    await FirebaseAuth.instance.signInWithCredential(authCreds).catchError((e) {
      result = false;
    });
    return result;
  }

  Future<bool> signInWithOTP(smsCode, verId) {
    print('this is 1');
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    return signIn(authCreds);
  }
}
