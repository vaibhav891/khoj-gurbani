import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/category_tracks.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SubCategories {
  final int id;
  final String name;
  final String slug;
  final String attachmentName;

  SubCategories(this.id, this.name, this.slug, this.attachmentName);
}

class CategoryPage extends StatefulWidget {
  final categories;
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  CategoryPage({
    Key key,
    this.categories,
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
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  void initState() {
    super.initState();
    _getSubCategorys(this.widget.categories.id);
  }

  Future<List<SubCategories>> _getSubCategorys(int id) async {
    var data = await http.get('https://api.khojgurbani.org/api/v1/android/sub-categories/$id');
    var jsonData = json.decode(data.body)['result'];

    List<SubCategories> subCategories = [];

    for (var s in jsonData) {
      SubCategories sub = SubCategories(s["id"], s["name"], s["slug"], s["attachment_name"]);
      subCategories.add(sub);
    }
    return subCategories;
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
          widget.categories.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Container(
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
          child: IconButton(
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              Navigator.of(context, rootNavigator: false).pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: FutureBuilder(
        future: _getSubCategorys(widget.categories.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.0555,
                    right: maxWidth * 0.0555,
                    top: maxHeight * 0.0216,
                    bottom: maxHeight * 0.0405),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.73, crossAxisSpacing: 9),
                itemCount: widget.categories.subCategoryCount,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // clipBehavior: Clip.hardEdge,
                    child: Column(children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => CategoryTracksPage(
                                      id: snapshot.data[index].id,
                                      name: snapshot.data[index].name,
                                      api: 'https://api.khojgurbani.org/api/v1/android/resource-subcategory-media/' +
                                          snapshot.data[index].id.toString(),
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
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              height: maxHeight * 0.2175,
                              width: maxWidth * 0.44722,
                              image: NetworkImage(snapshot.data[index].attachmentName),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: maxHeight * 0.0135, left: maxWidth * 0.0138),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: maxWidth * 0.4083,
                              child: Text(
                                snapshot.data[index].name,
                                style: TextStyle(),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              );
            } else {
              return Center(child: Container());
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
