import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoga_posture_detection/net/flutterfire.dart';
import 'package:yoga_posture_detection/screens/authentication/login.dart';
import 'package:yoga_posture_detection/screens/authentication/number.dart';
// import 'package:yoga_posture_detection/screens/authentication/login.dart';
import 'package:yoga_posture_detection/screens/authentication/register_email.dart';
// import 'package:yoga_posture_detection/screens/homeView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yoga_posture_detection/screens/widgets/textfield.dart';
import 'package:yoga_posture_detection/screens/widgets/button.dart';

class Regsiter1 extends StatefulWidget {
  const Regsiter1({Key? key}) : super(key: key);

  @override
  _Regsiter1State createState() => _Regsiter1State();
}

class _Regsiter1State extends State<Regsiter1> {
  TextEditingController _nameField = TextEditingController();
  TextEditingController _emailNumberField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String verificationId;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/register.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(29, 28, 28, 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      "REGISTER",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              TextFormFieldWidget(
                                  validator: (e) => e?.length == 0
                                      ? 'Please Enter Name'
                                      : null,
                                  autofocus: true,
                                  controller: _nameField,
                                  hintText: "Name"),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                          TextFormFieldWidget(
                              validator: inputValidator,
                              controller: _emailNumberField,
                              hintText: "Email id / phone number"),
                          SizedBox(
                            height: 15.0,
                          ),
                          ButtonWidget(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (isNumber(_emailNumberField.text)) {
                                  verifyPhone('+91' + _emailNumberField.text);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegsiterEmail(
                                              name: _nameField.text,
                                              email: _emailNumberField.text)));
                                }
                              }
                            },
                            text: "REGISTER",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    ButtonWidget(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      text: "LOGIN",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isNumber(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  String? inputValidator(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = new RegExp(pattern);
    if (value!.length == 0) {
      return 'Please Enter Credentials';
    } else if (regex.hasMatch(value)) {
      return null;
    }
    pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please Enter Correct Credentials';
    }
    return null;
  }

  Future<void> verifyPhone(String phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('ERROR FROM SERVER - ${authException.message}');
      Fluttertoast.showToast(
          msg: "Server Error... Please try after sometime!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    };

    final PhoneCodeSent smsSent = (String verId, int resendToken) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Number(
                    phoneNumber: _emailNumberField.text,
                    verificationId: this.verificationId,
                  )));
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
