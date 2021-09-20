import 'dart:ui';

import 'package:flutter/material.dart';

class AsanaHome extends StatefulWidget {
  final String asanaName;
  final String asanaLevel;
  final String asanaDescription;
  final String asanaImage;

  const AsanaHome(
      {required this.asanaName,
      required this.asanaLevel,
      required this.asanaDescription,
      required this.asanaImage});

  @override
  _AsanaHomeState createState() => _AsanaHomeState();
}

class _AsanaHomeState extends State<AsanaHome> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 18.0, 8.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "UserName !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Let's start !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            Container(
              width: 238.0,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.white)),
              child: Text(
                widget.asanaName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                widget.asanaLevel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(image: AssetImage(widget.asanaImage)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Text(
                      "Pose description - \nLorem ipsum dolor sit, amet consectetur adipisicing elit. Omnis cupiditate placeat quaerat praesentium, itaque cum rerum quam ipsum nemo laboriosam corrupti, fuga blanditiis ab quidem odio saepe recusandae quis. Libero.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child:
                      Image.asset("images/purple_wave.png", fit: BoxFit.cover),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 50.0),
                    child: Text(
                      "Start",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
