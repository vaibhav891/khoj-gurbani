import 'package:flutter/material.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';

import '../service_locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var service = getIt<LoginAndRegistrationService>();

  @override
  void initState() {
    service.getUserTest();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        title: Text(
          'My profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                // service.logout();
                service.clearAllData();
                LoginAndRegistrationService.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/media', (_) => false);
              },
              child: Container(
                height: maxHeight / 22,
                width: maxWidth / 6,
                child: Container(
                  // padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff578ed3),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        leading: Container(
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
          child: IconButton(
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: Center(
              child: CircleAvatar(
                radius: 36,
                child: ClipOval(
                    child: service.photo != null
                        ? Image(
                            image: NetworkImage(service.photo),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            color: Colors.red,
                          )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 9),
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  'Upload image',
                  style: TextStyle(color: Color(0xFF578ed3), fontSize: 12),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Account information',
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 11),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Full name',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      hintText: service.userName != null ? service.userName : "N/A",
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 11),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      hintText: service.email != null ? service.email : "N/A",
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      contentPadding: EdgeInsets.all(10),
                      // suffixIcon: Icon(
                      //   Icons.create,
                      //   size: 13,
                      // ),
                      suffixText: 'Change',
                      hintText: '*************',
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      contentPadding: EdgeInsets.all(10),
                      // suffixIcon: Icon(
                      //   Icons.create,
                      //   size: 13,
                      // ),
                      suffixText: 'Change',
                      hintText: '*************',
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 11),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'City',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      hintText: service.city != null ? service.city : 'N/A',
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 11),
                  child: Container(
                    width: maxWidth / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'State',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      hintText: service.state != null ? service.state : 'N/A',
                      hintStyle: TextStyle(fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 14),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 11),
                  child: Container(
                    width: maxWidth / 4,
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(width: 1.0, color: Colors.grey),
                    //   ),
                    // ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Country',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: maxWidth / 1.56,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      // labelStyle: ,
                      hintText: service.country != null ? service.country : 'N/A',
                      hintStyle: TextStyle(fontSize: 12),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 45,
                width: 332,
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
                      Center(
                        child: Text(
                          "Save changes",
                          style: TextStyle(
                            color: Colors.white,
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
        ],
      ),
    );
  }
}
