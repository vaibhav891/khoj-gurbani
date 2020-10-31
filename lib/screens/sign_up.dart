import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khojgurbani_music/screens/create_account.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';

class SingupPage extends StatefulWidget {
  @override
  _SingupPageState createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  var service = getIt<LoginAndRegistrationService>();

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  _userLoginGoogle() async {
    await service.loginWithGoogle();

    Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/media'));
  }

  _userLoginFacebook() async {
    await service.facebookLogin();

    Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/media'));
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
            height: maxHeight * 0.092,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color(0xff95989A)),
            // ),
            child: Container(
              child: Material(
                color: Color(0xffF5F5F5),
                child: Container(
                  padding: EdgeInsets.only(top: maxHeight * 0.020),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: maxWidth / 3.20),
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(context);
                            //Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.chevron_left,
                          ),
                        ),
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(fontFamily: 'Cabin', fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight / 9,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.056),
            child: Row(
              children: <Widget>[
                Text(
                  "Login",
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
            padding: EdgeInsets.only(left: maxWidth * 0.056),
            child: Row(
              children: <Widget>[
                Text(
                  "Create personalized experience",
                  style: TextStyle(fontSize: 16, color: Color(0xff578ed3)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.060,
          ),
          GestureDetector(
            onTap: () {
              _userLoginFacebook();
            },
            child: Container(
              height: maxHeight * 0.067,
              width: maxWidth / 1.11,
              child: Container(
                padding: EdgeInsets.only(left: maxWidth * 0.060),
                decoration: BoxDecoration(color: Color(0xff3B5998), borderRadius: BorderRadius.circular(6.0)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: maxHeight * 0.090,
                        width: maxWidth * 0.090,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Image.asset('assets/images/facebook.png')

                        // ImageIcon(
                        //   AssetImage('assets/images/facebook.png'),
                        // ),
                        ),
                    SizedBox(width: maxWidth * 0.098),
                    Center(
                      child: Text(
                        'Continue with Facebook',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.023,
          ),
          GestureDetector(
            onTap: () {
              _userLoginGoogle();
            },
            child: Container(
              height: maxHeight * 0.067,
              width: maxWidth / 1.11,
              child: Container(
                padding: EdgeInsets.only(left: maxWidth * 0.060),
                decoration: BoxDecoration(color: Color(0xff3C79E6), borderRadius: BorderRadius.circular(6.0)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: maxHeight * 0.090,
                      width: maxWidth * 0.090,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Image.asset('assets/images/google.png'),

                      // ImageIcon(
                      //   AssetImage('assets/images/google.png'),
                      // ),
                    ),
                    SizedBox(width: maxWidth * 0.098),
                    Center(
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.061,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.057),
                child: Container(
                  height: 1.0,
                  width: maxWidth / 2.76,
                  color: Colors.grey,
                ),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              Text(
                "Or",
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: maxWidth / 18),
                child: Container(
                  height: 1.0,
                  width: maxWidth / 2.76,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: maxHeight * 0.059,
          ),
          Container(
            height: maxHeight * 0.061,
            width: maxWidth / 1.11,
            child: Container(
              padding: EdgeInsets.only(left: maxWidth * 0.25),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => CreateAccount()));
                    },
                    child: Center(
                      child: Text(
                        'Create your account',
                        style: TextStyle(
                          color: Color(0xff578ed3),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.040,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Text(
              'Log in',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff000000),
              ),
            ),
          )
        ],
      ),
    );
  }
}
