import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/models/allArtists.dart';
import 'dart:convert';

import 'artist.dart';

class ArtistCategory extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  ArtistCategory({
    Key key,
    this.showOverlay,
    this.showOverlayTrue,
    this.showOverlayFalse,
    this.show,
    this.play,
    this.setListLinks,
    this.insertRecentlyPlayed,
    this.setPropertiesForFullScreen,
    this.currentSong,
  }) : super(key: key);

  @override
  _ArtistCategoryState createState() => _ArtistCategoryState();
}

class _ArtistCategoryState extends State<ArtistCategory> {
  var alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "#"
  ];
  @override
  void initState() {
    super.initState();
    getAllArtists();
  }

  var allArtists;

  getAllArtists() async {
    var response = await http.get('https://api.khojgurbani.org/api/v1/media-authors/alphabet-list');
    var data = json.decode(response.body);

    AllArtists results = new AllArtists.fromJson(data);

    setState(() {
      allArtists = results.result;
    });
    return allArtists;
  }

  var alp;
  List alphabetSearch = [];

  onAlphabetSearch(String alp) {
    alphabetSearch.clear();

    // if (alp.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    final textToLowerCase = alp.toLowerCase();

    allArtists.forEach((a) {
      if (a.name[0].toLowerCase().contains(textToLowerCase)) alphabetSearch.add(a);
      setState(() {});
    });

    setState(() {});
  }

  TextEditingController controller = new TextEditingController();

  List searchResults = [];

  onSearchTextChanged(String text) {
    searchResults.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }
    final textToLowerCase = text.toLowerCase();

    allArtists.forEach((a) {
      if (a.name.toLowerCase().contains(textToLowerCase)) searchResults.add(a);
      // setState(() {});
    });
    setState(() {});
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
          'Artist Category',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        leading: Container(
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
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
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: maxWidth * 0.055,
                  ),
                  //right: maxWidth * 0.0638),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: maxHeight * 0.05, //0.0418,
                          // width: 340,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.0),
                            ),
                          ),
                          child: TextField(
                            onSubmitted: (value) {},
                            onTap: () {
                              setState(() {});
                            },
                            controller: controller,
                            onChanged: onSearchTextChanged,
                            style: TextStyle(height: 2.0),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: maxHeight * 0.0135),
                              prefixIcon: Image.asset('assets/images/search.png'),
                              //Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  controller.clear();
                                  onSearchTextChanged('');
                                },
                              ),
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: maxHeight * 0.0297,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: maxWidth * 0.0694),
                      child: Text(
                        alp != null ? alp : '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB3B3B3),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                alphabetSearch.length != 0
                    ? alphabetResults()
                    : controller.text == ''
                        ? GridView.builder(
                            padding: EdgeInsets.only(left: maxWidth * 0.0555, right: 5),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.85,
                              crossAxisCount: 2,
                            ),
                            itemCount: allArtists?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ArtistPage(
                                                    indexOfArtist: allArtists[index].id,
                                                    id: allArtists[index].id,
                                                    attachmentName: allArtists[index].attachmentName,
                                                    name: allArtists[index].name,
                                                    showOverlay: this.widget.showOverlay,
                                                    showOverlayTrue: this.widget.showOverlayTrue,
                                                    showOverlayFalse: this.widget.showOverlayFalse,
                                                    show: this.widget.show,
                                                    play: this.widget.play,
                                                    setListLinks: this.widget.setListLinks,
                                                    insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                                    setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                                    currentSong: this.widget.currentSong,
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 10.0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: allArtists[index].attachmentName.isNotEmpty
                                          ? Image(
                                              // height: 150,
                                              // width: 300,
                                              image: NetworkImage(allArtists[index].attachmentName),
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              height: 165,
                                              child: Center(
                                                child: Text("No Image"),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: maxHeight * 0.0067, left: maxWidth * 0.0138),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: maxWidth * 0.388,
                                          child: Text(
                                            allArtists[index].name,
                                            style: TextStyle(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            })
                        : searchResult(),
                SizedBox(
                  height: maxHeight * 0.170,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 95),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.transparent,
                child: ListView.builder(
                    itemCount: alphabet.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                          onVerticalDragUpdate: (DragUpdateDetails detail) {
                            setState(() {
                              // _barOffset += detail.delta.dy;
                            });
                          },
                          onVerticalDragStart: (DragStartDetails detail) {},
                          onVerticalDragEnd: (DragEndDetails detail) {},
                          onTap: () {
                            setState(() {
                              alp = alphabet[index];
                            });
                            onAlphabetSearch(alp);
                          },
                          child: new Container(
                            margin: EdgeInsets.only(left: 15.0, right: 10.0, top: 5.5),
                            height: 15.0,
                            child: new Text(
                              '${alphabet[index]}',
                              style: TextStyle(
                                color: Color(0xff578ed3),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ));
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alphabetResults() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
        padding: EdgeInsets.only(left: maxWidth * 0.0555, right: 5),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.85,
          crossAxisCount: 2,
        ),
        itemCount: alphabetSearch?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ArtistPage(
                                indexOfArtist: alphabetSearch[index].id,
                                id: alphabetSearch[index].id,
                                attachmentName: alphabetSearch[index].attachmentName,
                                name: alphabetSearch[index].name,
                                showOverlay: this.widget.showOverlay,
                                showOverlayTrue: this.widget.showOverlayTrue,
                                showOverlayFalse: this.widget.showOverlayFalse,
                                show: this.widget.show,
                                play: this.widget.play,
                                setListLinks: this.widget.setListLinks,
                                insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                                setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                                currentSong: this.widget.currentSong,
                              )));
                },
                child: Card(
                  elevation: 10.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: alphabetSearch[index].attachmentName.isNotEmpty
                      ? Image(
                          // height: 150,
                          // width: 300,
                          image: NetworkImage(alphabetSearch[index].attachmentName),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 165,
                          child: Center(
                            child: Text("No Image"),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.0067, left: maxWidth * 0.0138),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth * 0.388,
                      child: Text(
                        alphabetSearch[index].name,
                        style: TextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget searchResult() {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
        padding: EdgeInsets.only(left: maxWidth * 0.0555, right: 5),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.85,
          crossAxisCount: 2,
        ),
        itemCount: searchResults?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ArtistPage(
                              indexOfArtist: searchResults[index].id,
                              id: searchResults[index].id,
                              attachmentName: searchResults[index].attachmentName,
                              name: searchResults[index].name,
                              showOverlay: this.widget.showOverlay,
                              showOverlayTrue: this.widget.showOverlayTrue,
                              showOverlayFalse: this.widget.showOverlayFalse,
                              show: this.widget.show,
                              play: this.widget.play,
                              setListLinks: this.widget.setListLinks,
                              insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                              setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                              currentSong: this.widget.currentSong)));
                },
                child: Card(
                  elevation: 10.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: searchResults[index].attachmentName.isNotEmpty
                      ? Image(
                          // height: 150,
                          // width: 300,
                          image: NetworkImage(searchResults[index].attachmentName),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 165,
                          child: Center(
                            child: Text("No Image"),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: maxHeight * 0.0067, left: maxWidth * 0.0138),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: maxWidth * 0.388,
                      child: Text(
                        searchResults[index].name,
                        style: TextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
