import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoga_posture_detection/net/flutterfire.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  late FocusNode otpFocusNode;

  @override
  void initState() {
    super.initState();

    otpFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    otpFocusNode.dispose();

    super.dispose();
  }

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
                          TextFormField(
                            validator: (value) {
                              return value?.length == 10
                                  ? null
                                  : 'Enter Valid Phone Number';
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            controller: _numberField,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Color(0xffC4C4C4)),
                              ),
                              fillColor: Color(0xffC4C4C4),
                              filled: true,
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabled: !codeSent,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          codeSent
                              ? (Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        return value?.length == 6
                                            ? null
                                            : 'Please Enter a 6 digit OTP';
                                      },
                                      controller: _smsCode,
                                      keyboardType: TextInputType.number,
                                      focusNode: otpFocusNode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xffC4C4C4)),
                                        ),
                                        fillColor: Color(0xffC4C4C4),
                                        filled: true,
                                        hintText: "OTP",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                ))
                              : (Container()),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print("valid");
                                if (codeSent) {
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
                                } else {
                                  verifyPhone('+91' + _numberField.text);
                                  otpFocusNode.requestFocus();
                                }
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: codeSent
                                  ? Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    )
                                  : Text(
                                      "Generate OTP",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff282B24),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
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
