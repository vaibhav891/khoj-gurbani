import 'package:flutter/material.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';

class PlayingNext extends StatefulWidget {
  @override
  _PlayingNextState createState() => _PlayingNextState();
}

class _PlayingNextState extends State<PlayingNext> {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: MyBottomNavBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: maxHeight * 0.156,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            decoration: BoxDecoration(
              color: new Color(0xffFFFFFF).withOpacity(1.0),
              border: new Border.all(
                width: maxWidth * 0.0083,
                color: Color(0xffe6f6ff),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: maxWidth * 0.0555, top: 0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 40,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image(
                          width: maxWidth * 0.1305,
                          height: maxHeight * 0.0635,
                          image: AssetImage(
                            'assets/images/slider_1.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: maxHeight * 0.0135),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Bhai Shokeen Singh',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: maxWidth * 0.14722,
                                    right: maxWidth * 0.055,
                                    top: maxHeight * 0.0067,
                                  ),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: maxWidth * 0.01388),
                              child: Text(
                                'Amrit Peevo Sada Chir Jeevo',
                                style: TextStyle(
                                  color: Color(0xff578ed3),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.0135),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Playing next',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: maxWidth * 0.0555, top: maxHeight * 0.0135),
            height: maxHeight * 0.7229,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // itemCount: destinations.length,
              itemBuilder: (BuildContext context, int index) {
                // Destination destination = destinations[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: maxHeight * 0.0135),
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          left: maxHeight * 0.0810,
                          child: Container(
                            width: maxWidth * 0.583,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: maxHeight * 0.0135),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Kaun Sahai Mann Ka',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Bhai Avtar Singh',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xffB3B3B3)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // tag: 'recently-played1',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image(
                                    height: maxHeight * 0.0635,
                                    width: maxWidth * 0.1305,
                                    image: AssetImage('assets/images/slider_1.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: maxHeight * 0.0202, right: maxWidth * 0.1222),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.dehaze,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
