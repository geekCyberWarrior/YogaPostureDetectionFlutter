import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yoga_posture_detection/screens/basic_level_home.dart';
import 'package:yoga_posture_detection/screens/edit_profile.dart';
import 'package:yoga_posture_detection/screens/intermediate_level_home.dart';
import 'package:yoga_posture_detection/screens/widgets/person.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome !",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  child: Image.asset(
                    "images/account_icon.jpg",
                    width: 100,
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("images/account_icon.jpg"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: null /* add child content here */,
                // ),
                Column(
                  children: [
                    Text(
                      "User Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      },
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 25.0, right: 15.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 70.0, horizontal: 10.0),
                        child: Text(
                          "Beginner/Basic Level",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BasicLevelHome()));
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, right: 25.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 70.0, horizontal: 10.0),
                        child: Text(
                          "Intermediate Level",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IntermediateLevelHome()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("Home View!!!"),
        //     ElevatedButton(
        //       onPressed: () async {
        //         FirebaseAuth.instance.signOut();
        //         Fluttertoast.showToast(
        //             msg: "Logged Out Successfully...",
        //             toastLength: Toast.LENGTH_LONG,
        //             gravity: ToastGravity.BOTTOM,
        //             backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
        //             timeInSecForIosWeb: 1,
        //             fontSize: 16.0);
        //       },
        //       child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //           child: Text(
        //             "LOGOUT",
        //             style: TextStyle(
        //               fontSize: 18.0,
        //             ),
        //           )),
        //       style: ElevatedButton.styleFrom(
        //         primary: Color(0xff282B24),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
