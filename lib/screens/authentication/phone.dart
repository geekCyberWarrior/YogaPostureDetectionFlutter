import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoga_posture_detection/net/flutterfire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yoga_posture_detection/screens/widgets/button.dart';
import 'package:yoga_posture_detection/screens/widgets/textfield.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController _numberField = TextEditingController();
  TextEditingController _smsCode = TextEditingController();
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
            image: AssetImage("images/login.jpg"),
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
                      "LOGIN",
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
                          TextFormFieldWidget(
                              validator: (value) {
                                return value?.length == 10
                                    ? null
                                    : 'Enter Valid Phone Number';
                              },
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              controller: _numberField,
                              isEnabled: !codeSent,
                              hintText: "Mobile Number"),
                          SizedBox(
                            height: 15.0,
                          ),
                          codeSent
                              ? (Column(
                                  children: [
                                    TextFormFieldWidget(
                                      validator: (value) {
                                        return value?.length == 6
                                            ? null
                                            : 'Please Enter a 6 digit OTP';
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _smsCode,
                                      hintText: "OTP",
                                      autofocus: codeSent,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                ))
                              : (Container()),
                          codeSent
                              ? (ButtonWidget(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool result = await AuthService()
                                          .signInWithOTP(
                                              _smsCode.text, verificationId);
                                      if (!result) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Incorrect OTP... Please Try Again",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor:
                                                Color.fromRGBO(29, 28, 28, 0.5),
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Login Successful!!!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor:
                                                Color.fromRGBO(29, 28, 28, 0.5),
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  text: "LOGIN",
                                ))
                              : (ButtonWidget(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      verifyPhone('+91' + _numberField.text);
                                    }
                                  },
                                  text: "Generate OTP",
                                )),
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
