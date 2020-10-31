import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khojgurbani_music/screens/sign_up.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    // final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff578ed3).withOpacity(1),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: maxHeight * 0.0392),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/media');
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Cabin',
                        // fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: maxWidth / 10, right: maxWidth / 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: maxHeight / 7.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/Khoj Gurbani logo.png')),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: maxHeight * 0.095, left: maxWidth / 1.6),
                          child: Text(
                            "Media",
                            style: TextStyle(
                              fontFamily: 'Cabin',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: maxHeight / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: maxWidth / 1.08,
                height: maxHeight * 0.06,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: Colors.white)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //Navigator.popAndPushNamed(context, '/login');
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => SingupPage()));
                    },
                    child: Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Cabin'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: maxHeight * 0.0216),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: maxWidth / 1.08,
                height: maxHeight * 0.06,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: Colors.white)),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => SingupPage()));
                    },
                    child: Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Color(0xff578ed3), fontSize: 14, fontFamily: 'Cabin'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
