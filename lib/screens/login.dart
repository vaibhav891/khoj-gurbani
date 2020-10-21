import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khojgurbani_music/screens/sign_up.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  // get routeName => '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var service = getIt<LoginAndRegistrationService>();

  bool error = false;

  _userLogin(String email, String password) async {
    await service.login(email, password);
    if (service.isError == false) {
      Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/'));
      _email.clear();
      _password.clear();
    } else {
      _email.clear();
      _password.clear();
      setState(() {
        error = true;
      });
      wrongPasswordOrEmail();
      nothing();
    }
  }

  wrongPasswordOrEmail() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Center(
              child: Text(
                "Invalid Email or Password",
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        });
  }

  nothing() {}

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool _sel = false;
  void initState() {
    super.initState();
    service.getDeviceDetails();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            height: maxHeight * 0.0925,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color(0xff95989A)),
            // ),
            child: Container(
              child: Material(
                color: Color(0xffF5F5F5),
                child: Container(
                  padding: EdgeInsets.only(top: maxHeight * 0.020),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: maxWidth * 0.32),
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pushNamed(context, '/loginOrSingup');
                          },
                          icon: Icon(
                            Icons.chevron_left,
                          ),
                        ),
                      ),
                      Text(
                        "Log in",
                        style: TextStyle(fontFamily: 'Cabin', fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: maxWidth * 0.320,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, '/media');
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Color(0xffB3B3B3),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.060,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.050),
            child: Row(
              children: <Widget>[
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff578ed3),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.005,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.050),
            child: Row(
              children: <Widget>[
                Text(
                  "Log in to your account",
                  style: TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.030,
          ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.0310, left: maxWidth * 0.050, right: maxWidth * 0.050),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.email,
                        color: Color(0xff578ed3),
                        size: 14,
                      ),
                    ),
                    SizedBox(
                      width: maxWidth * 0.006,
                    ),
                    error == false
                        ? Text(
                            "Email*",
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(
                            "Email*",
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                  ],
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Enter your email',
                    hintStyle: error == false ? TextStyle(fontSize: 10) : TextStyle(fontSize: 10, color: Colors.red),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 0,
          // ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.035, left: maxWidth * 0.050, right: maxWidth * 0.050),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.lock,
                        color: Color(0xff578ed3),
                        size: 14,
                      ),
                    ),
                    SizedBox(
                      width: maxWidth * 0.006,
                    ),
                    error == false
                        ? Text(
                            "Password*",
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(
                            "Password*",
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                  ],
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Enter your password',
                    hintStyle: error == false ? TextStyle(fontSize: 10) : TextStyle(fontSize: 10, color: Colors.red),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.050,
          ),
          // Center(
          //   child: InkWell(
          //     onTap: () {
          //       setState(() {
          //         _sel = !_sel;
          //       });
          //     },
          //     child: Container(
          //       decoration:
          //           BoxDecoration(shape: BoxShape.circle, color: Colors.white,
          //           border: Border.all(width: 1, color: Colors.blue)),
          //       child: Padding(
          //         padding: const EdgeInsets.all(5.0),
          //         child: _sel
          //             ? Icon(
          //                 Icons.check,
          //                 size: 20.0,
          //                 color: Colors.blue,
          //               )
          //             : Icon(
          //                 Icons.check_box_outline_blank,
          //                 size: 20.0,
          //                 color: Colors.transparent,
          //               ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.05),
            height: maxHeight * 0.050,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _sel,
                  onChanged: (bool resp) {
                    setState(() {
                      _sel = resp;
                    });
                  },
                ),
                Text(
                  "Remember me",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  width: maxWidth * 0.255,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/forgot_password');
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 11),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.050,
          ),
          GestureDetector(
            onTap: _email.text != "" && _password.text != ""
                ? () {
                    _userLogin(_email.text, _password.text);
                  }
                : null,
            child: Container(
              height: maxHeight * 0.07,
              width: maxWidth * 0.9,
              child: Container(
                // padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xff578ed3),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //   height: 30,
                    //   width: 30,
                    // ),
                    // SizedBox(
                    //   width: 50.0,
                    // ),

                    Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.0376,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "New User?",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: maxWidth * 0.006,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => SingupPage()));
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Color(0xff578ed3), fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
