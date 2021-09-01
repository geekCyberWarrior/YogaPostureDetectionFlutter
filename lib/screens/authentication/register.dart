import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoga_posture_detection/net/flutterfire.dart';
import 'package:yoga_posture_detection/screens/authentication/login.dart';
import 'package:yoga_posture_detection/screens/homeView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yoga_posture_detection/screens/widgets/textfield.dart';
import 'package:yoga_posture_detection/screens/widgets/button.dart';

class Regsiter extends StatefulWidget {
  const Regsiter({Key? key}) : super(key: key);

  @override
  _RegsiterState createState() => _RegsiterState();
}

class _RegsiterState extends State<Regsiter> {
  TextEditingController _nameField = TextEditingController();
  TextEditingController _emailNumberField = TextEditingController();
  TextEditingController _otpPasswordField = TextEditingController();
  TextEditingController _confirmPasswordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String verificationId;
  bool codeSent = false;
  bool isEmail = false;

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
            mainAxisAlignment: MainAxisAlignment.center,
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
                          !(isEmail || codeSent)
                              ? Column(
                                  children: [
                                    TextFormFieldWidget(
                                        validator: (e) => e?.length == 0
                                            ? 'Please Enter Name'
                                            : null,
                                        autofocus: true,
                                        controller: _nameField,
                                        isEnabled: !(isEmail || codeSent),
                                        hintText: "Name"),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                )
                              : Container(),
                          TextFormFieldWidget(
                              validator: inputValidator,
                              autofocus: true,
                              controller: _emailNumberField,
                              isEnabled: !(isEmail || codeSent),
                              hintText: "Email id / phone number"),
                          SizedBox(
                            height: 15.0,
                          ),
                          isEmail || codeSent
                              ? Column(
                                  children: [
                                    TextFormFieldWidget(
                                      validator: otpPasswordValidator,
                                      keyboardType: codeSent
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      controller: _otpPasswordField,
                                      hintText: isEmail ? "Password" : "OTP",
                                      autofocus: true,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                )
                              : Container(),
                          ButtonWidget(
                            onPressed: loginUser,
                            text: isEmail || codeSent ? "REGISTER" : "NEXT",
                          ),
                        ],
                      ),
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

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      if (isEmail) {
        print('-------------THIS IS IT---------------');
        signInWithEmailPassword();
      } else if (codeSent) {
        signInWithPhone();
      } else {
        print('beginning....');
        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regex = new RegExp(pattern);
        if (regex.hasMatch(_emailNumberField.text)) {
          generateOTP();
        } else {
          print('email it is...');
          setState(() {
            isEmail = true;
          });
        }
      }
    }
  }

  void signInWithPhone() async {
    if (_formKey.currentState!.validate()) {
      bool result = await AuthService()
          .signInWithOTP(_otpPasswordField.text, verificationId);
      if (!result) {
        Fluttertoast.showToast(
            msg: "Incorrect OTP... Please Try Again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Login Successful!!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }

  void signInWithEmailPassword() async {
    bool shouldNavigate =
        await signIn(_emailNumberField.text, _otpPasswordField.text);
    if (shouldNavigate) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
      Fluttertoast.showToast(
          msg: "Login successful!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Incorrect Credentials",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromRGBO(29, 28, 28, 0.5),
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  void generateOTP() async {
    if (_formKey.currentState!.validate()) {
      verifyPhone('+91' + _emailNumberField.text);
    }
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

  String? otpPasswordValidator(String? value) {
    return isEmail
        ? null
        : value?.length == 6
            ? null
            : 'Please Enter a 6 digit OTP';
    // return null;
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
