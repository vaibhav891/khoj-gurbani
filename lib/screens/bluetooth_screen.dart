import 'dart:ui';

import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white.withOpacity(0.5),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: new Color(0xff578ed3).withOpacity(0.9),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: maxHeight * 0.06216, left: maxWidth * 0.01388),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: maxWidth * 0.1722,
                          // height: 60,
                          child: Icon(
                            Icons.phone_iphone,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Listening on',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: maxHeight * 0.0067,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: maxWidth * 0.01388),
                              child: Text(
                                'This Phone',
                                style: TextStyle(
                                  color: Color(0xffB3B3B3),
                                  fontSize: 14,
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
              SizedBox(
                height: maxHeight * 0.0243,
              ),
              Padding(
                padding: EdgeInsets.only(right: maxWidth * 0.52777),
                child: Text(
                  'Connect to a device:',
                  style: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: maxHeight * 0.0324,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.071, top: maxHeight * 0.0378),
                    child: Icon(
                      Icons.airplay,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0416, top: maxHeight * 0.0384),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'AirPlay or Bluetooth',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.071, top: maxHeight * 0.0554),
                    child: Icon(
                      Icons.desktop_windows,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0416, top: maxHeight * 0.05),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Receiver',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0611, top: maxHeight * 0.0554),
                    child: Icon(
                      Icons.speaker,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0416, top: maxHeight * 0.06),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Speaker',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0611, top: maxHeight * 0.0554),
                    child: Icon(
                      Icons.speaker,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0416, top: maxHeight * 0.06),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Speaker',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.071, top: maxHeight * 0.0554),
                    child: Icon(
                      Icons.desktop_windows,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.0416, top: maxHeight * 0.06),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'TV',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: maxHeight * 0.31621,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: maxWidth * 0.1388,
                      height: maxHeight * 0.0108,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
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
}
