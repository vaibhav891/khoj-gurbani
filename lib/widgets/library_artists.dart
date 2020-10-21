import 'package:flutter/material.dart';
import 'package:khojgurbani_music/screens/artist.dart';
import 'package:khojgurbani_music/service_locator.dart';
import 'package:khojgurbani_music/services/services.dart';

// class UserFavoriteArtists {
//   final int id;
//   final String name;
//   final String description;
//   final String image;

//   UserFavoriteArtists(this.id, this.name, this.description, this.image);
// }

class LibraryArtists extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  LibraryArtists({
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
  _LibraryArtistsState createState() => _LibraryArtistsState();
}

class _LibraryArtistsState extends State<LibraryArtists> {
  var service = getIt<Services>();
  var userFavoriteArtists;

  @override
  void initState() {
    service.userFavoriteArtistSubject.stream.listen((event) {
      if (!mounted) return;
      setState(() {
        userFavoriteArtists = event;
      });
    });
    service.getUserFavoriteArtists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: maxHeight * 0.0135,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                padding: EdgeInsets.only(
                    left: maxWidth * 0.0555, right: maxWidth * 0.0555),
                itemCount: userFavoriteArtists?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ArtistPage(
                                    indexOfArtist:
                                        userFavoriteArtists[index].id,
                                    id: userFavoriteArtists[index].id,
                                    name: userFavoriteArtists[index].name,
                                    attachmentName:
                                        userFavoriteArtists[index].image,
                                    showOverlay: this.widget.showOverlay,
                                    showOverlayTrue:
                                        this.widget.showOverlayTrue,
                                    showOverlayFalse:
                                        this.widget.showOverlayFalse,
                                    show: this.widget.show,
                                    play: this.widget.play,
                                    setListLinks: this.widget.setListLinks,
                                    insertRecentlyPlayed:
                                        this.widget.insertRecentlyPlayed,
                                    setPropertiesForFullScreen:
                                        this.widget.setPropertiesForFullScreen,
                                    currentSong: this.widget.currentSong,
                                  )));
                    },
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            // elevation: 10.0,
                            child: Image(
                              // height: 150,
                              // width: 300,
                              image: NetworkImage(
                                  userFavoriteArtists[index].image),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: maxHeight * 0.0067, left: maxWidth * 0.0138),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: maxWidth / 2.4,
                                child: Text(
                                  userFavoriteArtists[index].name,
                                  style: TextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: maxHeight * 0.0810,
              ),
              // SizedBox(
              //   height: 100,
              // )
              // GridView.count(
              //   crossAxisCount: 2,
              //   children: List.generate(100, (index) {
              //     return Center(
              //       child: Text(
              //         'test',
              //         // style: Theme.of(context).textTheme.headline,
              //       ),
              //     );
              //   }),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
