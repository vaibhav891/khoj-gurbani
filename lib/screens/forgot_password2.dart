import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordContinue extends StatefulWidget {
  get routeName => '/forgot_password_continue';

  @override
  _ForgotPasswordContinueState createState() => _ForgotPasswordContinueState();
}

class _ForgotPasswordContinueState extends State<ForgotPasswordContinue> {
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            height: 68,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color(0xff95989A)),
            // ),
            child: Container(
              child: Material(
                color: Color(0xffF5F5F5),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        //padding: EdgeInsets.only(right: 130),
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () {},
                          icon: Icon(
                            Icons.chevron_left,
                          ),
                        ),
                      ),
                      Center(
                        widthFactor: 3,
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
            height: 60,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Text(
                  "Please check your inbox!",
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
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 370,
                  child: Text(
                    "On more step! We have sent email for password reset instructions",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, color: Color(0xffB3B3B3)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            // ispod ovog dodati sliku
          ),
          Container(
            height: 45.0,
            width: 350,
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
                        "Continue",
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("New User?"),
              SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Sing up",
                  style: TextStyle(color: Color(0xff578ed3)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
