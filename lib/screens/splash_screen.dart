import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import './login_or_register.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginOrRegister())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff578ed3),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 260, left: 40, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/Khoj Gurbani logo.png')),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 123, left: 166),
                          child: Text(
                            "Media",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
