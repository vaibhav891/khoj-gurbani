import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccount extends StatelessWidget {
  get routeName => '/create_account';

  register(String name, String email, String password) async {
    final res = await http.post('https://api.khojgurbani.org/api/v1/android/register',
        body: {'name': name, 'email': email, 'password': password});
    final data = jsonDecode(res.body);
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

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
            child: Container(
              child: Material(
                color: Color(0xffF5F5F5),
                child: Container(
                  padding: EdgeInsets.only(top: maxHeight * 0.020),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: maxWidth / 3.20),
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(context);
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
                      SizedBox(
                        width: maxWidth * 0.320,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/media', (_) => false);
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
            height: maxHeight * 0.080,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.057),
            child: Row(
              children: <Widget>[
                Text(
                  "Create your account",
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
            padding: EdgeInsets.only(left: maxWidth * 0.057),
            child: Row(
              children: <Widget>[
                Text(
                  "Let's join us",
                  style: TextStyle(fontSize: 16, color: Color(0xffB3B3B3)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.053,
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.057, right: maxWidth * 0.057),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.person,
                        color: Color(0xff578ed3),
                        size: 14,
                      ),
                    ),
                    SizedBox(
                      width: maxWidth * 0.003,
                    ),
                    Text(
                      "User name*",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(fontSize: 10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.022, left: maxWidth * 0.057, right: maxWidth * 0.057),
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
                      width: 3,
                    ),
                    Text(
                      "Email*",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextField(
                  controller: _email,
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
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.022, left: maxWidth * 0.057, right: maxWidth * 0.057),
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
                      width: maxWidth * 0.003,
                    ),
                    Text(
                      "Password*",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(fontSize: 10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: maxHeight * 0.022, left: maxWidth * 0.057, right: maxWidth * 0.057),
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
                      width: maxWidth * 0.003,
                    ),
                    Text(
                      "Confirm password*",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextField(
                  controller: _confirmpassword,
                  decoration: InputDecoration(
                    //  'Enter your email',
                    hintText: 'Confirm your password',
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
            height: maxHeight * 0.068,
          ),
          Container(
            height: maxHeight * 0.061,
            width: maxWidth / 1.11,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff578ed3),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _email.text != "" && _password.text != "" && _password == _confirmpassword
                        ? () {
                            register(_name.text, _email.text, _password.text);
                          }
                        : null,
                    child: Center(
                      child: Text(
                        "Sign up",
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
                "Already have an account?",
                style: TextStyle(color: Color(0xff000000), fontSize: 12),
              ),
              SizedBox(
                width: maxWidth * 0.003,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Log in",
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
