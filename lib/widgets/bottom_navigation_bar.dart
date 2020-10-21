import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyBottomNavBar extends StatelessWidget {
  void doNothing() {}
  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context).settings.name;
    print(route);
    return Container(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: (route != '/media')
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(context, '/media', ModalRoute.withName('/'));
                        }
                      : () {
                          doNothing();
                        },
                  child: Icon(
                    Icons.home,
                    size: 25,
                    color: (route == '/media') ? Color(0xff578ed3) : Colors.grey,
                  ),
                ),
                Text(
                  "Home",
                  style: (route == '/media')
                      ? TextStyle(fontSize: 13, color: Color(0xff578ed3))
                      : TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: (route != '/search')
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(context, '/search', ModalRoute.withName('/'));
                        }
                      : () {
                          doNothing();
                        },
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: (route == '/search') ? Color(0xff578ed3) : Colors.grey,
                  ),
                ),
                Text(
                  "Search",
                  style: (route == '/search')
                      ? TextStyle(fontSize: 13, color: Color(0xff578ed3))
                      : TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: (route != '/library')
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(context, '/library', ModalRoute.withName('/'));
                        }
                      : () {
                          doNothing();
                        },
                  child: Icon(
                    Icons.library_music,
                    size: 25,
                    color: (route == '/library') ? Color(0xff578ed3) : Colors.grey,
                  ),
                ),
                Text(
                  "Library",
                  style: (route == '/library')
                      ? TextStyle(fontSize: 13, color: Color(0xff578ed3))
                      : TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
