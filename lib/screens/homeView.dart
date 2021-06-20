import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home View!!!"),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(
                    msg: "Logged Out Successfully...",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  )),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff282B24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
