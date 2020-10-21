// import 'package:flutter/material.dart';
// import 'package:khojgurbani_music/models/drop-down.dart';
// import 'package:khojgurbani_music/models/melody.dart';
// import 'package:khojgurbani_music/models/singers.dart';
// import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';

// class GurbaniSearch extends StatefulWidget {
//   final melodys;
//   final singers;
//   final dropDownOptions;

//   const GurbaniSearch(
//       {Key key, this.melodys, this.singers, this.dropDownOptions})
//       : super(key: key);

//   @override
//   _GurbaniSearchState createState() => _GurbaniSearchState();
// }

// class _GurbaniSearchState extends State<GurbaniSearch> {
//   // Widget melody() {
//   //   String dropdownValue = 'One';
//   //   return DropdownButton<String>(
//   //     value: dropdownValue,
//   //     icon: Padding(
//   //       padding: EdgeInsets.only(left: 315),
//   //       child: Icon(Icons.keyboard_arrow_down),
//   //     ),
//   //     iconSize: 15,
//   //     elevation: 16,
//   //     style: TextStyle(color: Colors.deepPurple),
//   //     underline: Container(
//   //       height: 2,
//   //       color: Colors.grey,
//   //     ),
//   //     onChanged: (String newValue) {
//   //       setState(() {
//   //         dropdownValue = newValue;
//   //       });
//   //     },
//   //     items: <String>['One', 'Two', 'Free', 'Four']
//   //         .map<DropdownMenuItem<String>>((String value) {
//   //       return DropdownMenuItem<String>(
//   //         value: value,
//   //         child: Text(value),
//   //       );
//   //     }).toList(),
//   //   );
//   // }
//   List<Singers> _sing = [];
//   List<Melodies> _mel = [];
//   List<DropDown> _drop = [];
//   String dropdownValue;
//   String dropdownValue1;
//   String dropdownValue2 = "First letter (search in the begin)";

//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;
//     double maxHeight = MediaQuery.of(context).size.height;
//     _mel = (this.widget.melodys)
//         .map<Melodies>((item) => Melodies.fromJson(item))
//         .toList();
//     _sing = (this.widget.singers)
//         .map<Singers>((item) => Singers.fromJson(item))
//         .toList();
//     _drop = (this.widget.dropDownOptions)
//         .map<DropDown>((item) => DropDown.fromJson(item))
//         .toList();
//     // dropdownValue2 = _drop[2].value;
//     var route = ModalRoute.of(context).settings.name;
//     print(route);
//     return Scaffold(
//       bottomNavigationBar: MyBottomNavBar(),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(0xffF5F5F5),
//         actions: <Widget>[],
//         title: Text(
//           "Filters",
//           style: TextStyle(
//               color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
//         ),
//         leading: Container(
//           // width: 20,
//           // height: 50,
//           // alignment: AxisDirection.left,
//           // padding: EdgeInsets.only(right: 90),
//           child: IconButton(
//             color: Colors.black,
//             // padding: EdgeInsets.only(bottom: 30),
//             iconSize: 30,
//             onPressed: () {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, '/search', ModalRoute.withName('/'));
//             },
//             padding: EdgeInsets.only(bottom: 10),
//             icon: Icon(
//               Icons.clear,
//             ),
//           ),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 49, left: 20),
//                   child: Container(
//                     height: maxHeight * 0.0418,
//                     width: 360,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(6.0),
//                           topLeft: Radius.circular(6.0)),
//                     ),
//                     child: TextField(
//                       onSubmitted: (value) {},
//                       onTap: () {},
//                       // controller: controller,
//                       // onChanged: onSearchTextChanged,
//                       style: TextStyle(height: 1.7),
//                       // keyboardType: TextInputType.,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             EdgeInsets.only(bottom: maxHeight * 0.0175),
//                         suffixIcon: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             IconButton(
//                               icon: Image(
//                                   image:
//                                       AssetImage('assets/images/keyboard.png')),
//                               onPressed: () {
//                                 print("icon 1");
//                               },
//                             ),
//                             IconButton(
//                               icon: Image(
//                                   image:
//                                       AssetImage('assets/images/keyboard.png')),
//                               onPressed: () {
//                                 print("icon 2");
//                               },
//                             ),
//                           ],
//                         ),
//                         hintText: "Gurbani search",
//                         hintStyle: TextStyle(fontSize: 14),
//                         // border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, top: 50),
//                   child: DropdownButton<String>(
//                     value: dropdownValue,
//                     hint: Text("Melody (RAAG)"),
//                     icon: Padding(
//                       padding: EdgeInsets.only(left: 220),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     iconSize: 30,
//                     elevation: 16,
//                     style: TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.grey,
//                     ),
//                     onChanged: (String newValue) {
//                       setState(() {
//                         dropdownValue = newValue;
//                       });
//                     },
//                     items: _mel.map((Melodies map) {
//                       return new DropdownMenuItem<String>(
//                           value: map.melody,
//                           child: Text(map.melody,
//                               style: new TextStyle(
//                                   color: Colors.grey, fontSize: 12)));
//                     }).toList(),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, top: 50),
//                   child: DropdownButton<String>(
//                     value: dropdownValue1,
//                     hint: Text("Singer (Raagi)"),
//                     icon: Padding(
//                       padding: EdgeInsets.only(left: 40),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     iconSize: 30,
//                     elevation: 16,
//                     style: TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.grey,
//                     ),
//                     onChanged: (String newValue) {
//                       setState(() {
//                         dropdownValue1 = newValue;
//                       });
//                     },
//                     items: _sing.map((Singers map) {
//                       return new DropdownMenuItem<String>(
//                           value: map.name,
//                           child: Text(map.name,
//                               style: new TextStyle(
//                                   color: Colors.grey, fontSize: 12)));
//                     }).toList(),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20, top: 50),
//                   child: DropdownButton<String>(
//                     value: dropdownValue2,
//                     isDense: true,
//                     // hint: Text(dropdownValue2),
//                     icon: Padding(
//                       padding: EdgeInsets.only(left: 160),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     iconSize: 30,
//                     elevation: 16,
//                     style: TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.grey,
//                     ),
//                     onChanged: (String newValue) {
//                       setState(() {
//                         dropdownValue2 = newValue;
//                       });
//                       print(dropdownValue2);
//                     },
//                     items: _drop.map((DropDown map) {
//                       return new DropdownMenuItem<String>(
//                           value: map.value,
//                           child: new Text(map.value,
//                               style: new TextStyle(
//                                   color: Colors.grey, fontSize: 12)));
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 21.5),
//                   child: GestureDetector(
//                     onTap: () {
//                       print("radi ceo");
//                     },
//                     child: Container(
//                       height: maxHeight * 0.061,
//                       width: maxWidth / 1.11,
//                       // padding: EdgeInsets.only(left: maxWidth * 0.25),
//                       decoration: BoxDecoration(
//                         color: Color(0xff578ed3),
//                         borderRadius: BorderRadius.circular(6.0),
//                         border: Border.all(color: Colors.grey),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             'Search',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
