import 'package:flutter/material.dart';
import 'package:yoga_posture_detection/screens/asana_homepage.dart';
import 'package:camera/camera.dart';

class BasicLevelHome extends StatelessWidget {
  final List<CameraDescription> cameras;
  const BasicLevelHome({required this.cameras});

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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Beginner/Basic Level",
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 238.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AsanaHome(
                                            asanaName:
                                                "Bhujangasana \n cobra pose",
                                            asanaLevel:
                                                "Level - Beginner/Basic",
                                            asanaDescription:
                                                "asanaDescription",
                                            asanaImage:
                                                "images/Bhujangasana-pose.jpg",
                                            cameras: cameras,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 24.0),
                              child: Text(
                                "Bhujangasana - cobra pose",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 238.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AsanaHome(
                                            asanaName:
                                                "Shavasana \n corpse pose",
                                            asanaLevel:
                                                "Level - Beginner/Basic",
                                            asanaDescription:
                                                "asanaDescription",
                                            asanaImage:
                                                "images/shavasana-pose.jpg",
                                            cameras: cameras,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 24.0),
                              child: Text(
                                "Shavasana - corpse pose",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 238.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AsanaHome(
                                            asanaName:
                                                "Tadasana \n mountain pose",
                                            asanaLevel:
                                                "Level - Beginner/Basic",
                                            asanaDescription:
                                                "asanaDescription",
                                            asanaImage:
                                                "images/Tadasana-pose.jpg",
                                            cameras: cameras,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 24.0),
                              child: Text(
                                "Tadasana - mountain pose",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 238.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AsanaHome(
                                            asanaName:
                                                "Vrikshasana \n tree pose",
                                            asanaLevel:
                                                "Level - Beginner/Basic",
                                            asanaDescription:
                                                "asanaDescription",
                                            asanaImage:
                                                "images/vrikshasana-pose.jpg",
                                            cameras: cameras,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 24.0),
                              child: Text(
                                "Vrikshasana - tree pose",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("images/purple_wave.png", fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
