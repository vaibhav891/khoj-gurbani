import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  get routeName => '/forgot_password';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void initState() {
    super.initState();
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        //padding: EdgeInsets.only(right: 130),
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          icon: Icon(
                            Icons.chevron_left,
                          ),
                        ),
                      ),
                      Center(
                        widthFactor: 2.8,
                        child: Text(
                          "Forgot password",
                          style: TextStyle(fontFamily: 'Cabin', fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.080,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.056),
            child: Row(
              children: <Widget>[
                Text(
                  "Hello!",
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
                Container(
                  width: maxWidth * 0.90,
                  child: Text(
                    "If you need resetting your password, we can help by sending you a link to reset it.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.035, left: maxWidth * 0.056, right: maxWidth * 0.056),
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
                    Text(
                      "Email*",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(fontSize: 10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.100,
          ),
          Container(
            height: maxHeight * 0.061,
            width: maxWidth * 0.90,
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
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        "Reset password",
                        style: TextStyle(
                          color: Colors.white,
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
            height: maxHeight * 0.037,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "New User?",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: maxWidth * 0.006,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/create_account');
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
