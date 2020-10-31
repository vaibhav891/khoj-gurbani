import 'dart:ui';

import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:khojgurbani_music/models/UserSetings.dart';
import 'package:khojgurbani_music/services/Database.dart';

class SettingsScreen extends StatefulWidget {
  final Function translateValue;
  final Function scriptureIsGurmukhi;
  final Function scriptureIsEnglish;
  final Function scriptureIsLarevaar;
  final int val;
  bool isGurmukhi;
  bool isEnglish;
  bool isLarevaar;

  SettingsScreen(
      {Key key,
      this.translateValue,
      this.scriptureIsGurmukhi,
      this.val,
      this.isGurmukhi,
      this.isEnglish,
      this.isLarevaar,
      this.scriptureIsEnglish,
      this.scriptureIsLarevaar})
      : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int radioValue1;
  var valFromDB;

  @override
  void initState() {
    super.initState();
    radioValue1 = this.widget.val;
    isGurmukhi = this.widget.isGurmukhi;
    isEnglish = this.widget.isEnglish;
    isLarevaar = this.widget.isLarevaar;
  }

  insertSetings(value) async {
    UserSetings newSetings = UserSetings(
      val: value,
    );
    await DBProvider.db.setingsForUser(newSetings);
  }

  void _handleRadioValueChange1(int value) async {
    setState(() {
      insertSetings(value);
      radioValue1 = value;
      this.widget.translateValue(radioValue1);
      switch (radioValue1) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
        case 5:
          break;
      }
    });
  }

  bool isGurmukhi = true;
  bool isEnglish = false;
  bool isLarevaar = false;

  var first;
  var second;
  var third;

  lyricsBold() {
    if (isGurmukhi == true) {
      setState(() {
        first = 1;
      });
    } else {
      setState(() {
        first = 0;
      });
    }
    if (isEnglish == true) {
      if (first == 0) {
        setState(() {
          first = 1;
        });
      } else if (second != 2 && second == 0) {
        setState(() {
          second = 2;
        });
      } else if (third != 3 && third == 0) {
        setState(() {
          third = 3;
        });
      } else {
        setState(() {
          second = 0;
          third = 0;
        });
      }
    }
    if (isLarevaar == true) {
      if (first == 0) {
        setState(() {
          first = 1;
        });
      } else if (second != 2 && second == 0) {
        setState(() {
          second = 2;
        });
      } else if (third != 3 && third == 0) {
        setState(() {
          third = 3;
        });
      } else {
        setState(() {
          second = 0;
          third = 0;
          first = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white.withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
          color: new Color(0xff578ed3).withOpacity(0.9),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: maxHeight * 0.08108,
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.0555),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Display Settings",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: maxHeight * 0.0270,
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.061111, right: maxWidth * 0.05555),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth / 1.33,
                      child: Text(
                        "Gurmukhi",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isGurmukhi = !isGurmukhi;
                          this.widget.scriptureIsGurmukhi(isGurmukhi);
                        });
                      },
                      child: SizedBox(
                        width: maxWidth / 8,
                        height: maxHeight * 0.04189,
                        child: CustomSwitchButton(
                          indicatorWidth: 25,
                          backgroundColor: Colors.white,
                          unCheckedColor: Colors.grey,
                          animationDuration: Duration(milliseconds: 300),
                          checkedColor: Color(0xff578ed3),
                          checked: isGurmukhi,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.061, right: maxWidth * 0.05555, top: maxHeight * 0.02027),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth / 1.33,
                      child: Text(
                        "English (Transliteration)",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEnglish = !isEnglish;
                        });
                        this.widget.scriptureIsEnglish(isEnglish);
                      },
                      child: SizedBox(
                        width: maxWidth / 8,
                        height: maxHeight * 0.04189,
                        child: CustomSwitchButton(
                          indicatorWidth: 25,
                          backgroundColor: Colors.white,
                          unCheckedColor: Colors.grey,
                          animationDuration: Duration(milliseconds: 300),
                          checkedColor: Color(0xff578ed3),
                          checked: isEnglish,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.061, right: maxWidth * 0.05555, top: maxHeight * 0.02027),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth / 1.33,
                      child: Text(
                        "Larevaar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLarevaar = !isLarevaar;
                        });
                        this.widget.scriptureIsLarevaar(isLarevaar);
                      },
                      child: SizedBox(
                        width: maxWidth / 8,
                        height: maxHeight * 0.04189,
                        child: CustomSwitchButton(
                          indicatorWidth: 25,
                          backgroundColor: Colors.white,
                          unCheckedColor: Colors.grey,
                          animationDuration: Duration(milliseconds: 300),
                          checkedColor: Color(0xff578ed3),
                          checked: isLarevaar,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.067, left: maxWidth * 0.0555, bottom: maxWidth * 0.0555),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Translation",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.grey,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: maxWidth * 0.0555),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 0,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "Sant Singh Khalsa (English)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 1,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "Manmohan Singh (English)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 2,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "Sahib Singh (Panjabi)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 3,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "Harbans Singh (Panjabi)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 4,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "Manmohan Singh (Panjabi)",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            activeColor: Colors.white,
                            value: 5,
                            groupValue: radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          Text(
                            "None",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: maxHeight * 0.1027,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: maxHeight * 0.0245,
                              width: maxWidth * 0.138888,
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
