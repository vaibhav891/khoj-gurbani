import 'dart:ui';

import 'package:flutter/material.dart';

class FullLyricsPage extends StatefulWidget {
  @override
  _FullLyricsPageState createState() => _FullLyricsPageState();
}

class _FullLyricsPageState extends State<FullLyricsPage> {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: maxHeight * 0.0337),
        child: Container(
          decoration: BoxDecoration(
            color: new Color(0xffFFFFFF).withOpacity(1.0),
            border: new Border.all(
              width: maxWidth * 0.00833,
              color: Color(0xffe6f6ff),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: maxHeight * 0.0527),
                  child: Container(
                    height: maxHeight * 0.675,
                    padding: EdgeInsets.only(left: maxWidth * 0.061, right: maxWidth * 0.0583),
                    child: Text(
                      "Not by reason, not even by reasoning forever, Not by silence, not even by being silent forever, Not by possession, not even by possessing all worldly treasure, Not by all this, nor by a million mental guiles. ਸੋਚੈ ਸੋਚਿ ਨ ਹੋਵਈ ਜੇ ਸੋਚੀ ਲਖ ਵਾਰ ॥ ਚੁਪੈ ਚੁਪ ਨ ਹੋਵਈ ਜੇ ਲਾਇ ਰਹਾ ਲਿਵ ਤਾਰ ॥ ਭੁਖਿਆ ਭੁਖ ਨ ਉਤਰੀ ਜੇ ਬੰਨਾ ਪੁਰੀਆ ਭਾਰ ॥ ਸਹਸ ਸਿਆਣਪਾ ਲਖ ਹੋਹਿ ਤ ਇਕ ਨ ਚਲੈ ਨਾਲਿ ॥ How, then, will the Truth be revealed, the veil of falsehood repealed? Says Nanak, Surrender to that Will that is inscribed in all Creation. ਕਿਵ ਸਚਿਆਰਾ ਹੋਈਐ ਕਿਵ ਕੂੜੈ ਤੁਟੈ ਪਾਲਿ ॥ ਹੁਕਮਿ ਰਜਾਈ ਚਲਣਾ ਨਾਨਕ ਲਿਖਿਆ ਨਾਲਿ ॥੧॥ Not by reason, not even by reasoning forever, Not by silence, not even by being silent forever, Not by possession, not even by possessing all worldly treasure, Not by all this, nor by a million mental guiles. ਸੋਚੈ ਸੋਚਿ ਨ ਹੋਵਈ ਜੇ ਸੋਚੀ ਲਖ ਵਾਰ ॥ ਚੁਪੈ ਚੁਪ ਨ ਹੋਵਈ ਜੇ ਲਾਇ ਰਹਾ ਲਿਵ ਤਾਰ ॥ ਭੁਖਿਆ ਭੁਖ ਨ ਉਤਰੀ ਜੇ ਬੰਨਾ ਪੁਰੀਆ ਭਾਰ ॥ ਸਹਸ ਸਿਆਣਪਾ ਲਖ ਹੋਹਿ ਤ ਇਕ ਨ ਚਲੈ ਨਾਲਿ ॥",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        height: 1.7,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * 0.0675,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffB3B3B3),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 40,
                          color: Color(0xffAFAFAF),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
