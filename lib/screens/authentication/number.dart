import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yoga_posture_detection/net/flutterfire.dart';
import 'package:yoga_posture_detection/screens/widgets/button.dart';
import 'package:yoga_posture_detection/screens/widgets/textfield.dart';

class Number extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const Number({
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  TextEditingController _numberField = TextEditingController();
  TextEditingController _otpField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool codeSent = false;

  initState() {
    super.initState();
    _numberField = TextEditingController(text: widget.phoneNumber);
  }

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
                                  isEnabled: false,
                                  controller: _numberField),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                          TextFormFieldWidget(
                              keyboardType: TextInputType.number,
                              validator: (e) => null,
                              autofocus: true,
                              controller: _otpField,
                              hintText: "OTP"),
                          SizedBox(
                            height: 15.0,
                          ),
                          ButtonWidget(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signInWithPhone();
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
                      onPressed: () {},
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

  void signInWithPhone() async {
    if (_formKey.currentState!.validate()) {
      bool result =
          await AuthService().signInWithOTP(_otpField.text, widget.verificationId);
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
}
