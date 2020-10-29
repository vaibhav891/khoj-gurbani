import 'package:flutter/material.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';
import 'package:khojgurbani_music/widgets/bottom_navigation_bar.dart';
import 'package:khojgurbani_music/widgets/library_artists.dart';
import 'package:khojgurbani_music/widgets/library_downloads.dart';
import 'package:khojgurbani_music/widgets/library_podcasts.dart';
import 'package:khojgurbani_music/widgets/library_tracks.dart';
import 'package:khojgurbani_music/widgets/playlists.dart';

import '../service_locator.dart';
import 'my_profile.dart';

class Library extends StatefulWidget {
  final Function showOverlay;
  final Function showOverlayTrue;
  final Function showOverlayFalse;
  bool show;
  final Function play;
  final Function setListLinks;
  final Function insertRecentlyPlayed;
  final Function setPropertiesForFullScreen;
  final currentSong;

  Library({
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
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var service = getIt<LoginAndRegistrationService>();

  void initiState() {
    service.getUserTest();
    super.initState();
  }

  // UserDetails user;
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(20.0),
        //   child: Container(),
        // ),
        centerTitle: true,
        backgroundColor: Color(0xffF5F5F5),
        actions: <Widget>[
          service.isUserLogedin == true
              ? Padding(
                  padding: EdgeInsets.only(right: maxWidth * 0.0638),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, animation, secondaryAnimation) => ProfilePage())),
                    child: CircleAvatar(
                      // backgroundColor: Colors.red,
                      radius: 13,
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
                )
              : Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 10, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
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
                              "Login",
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
        title: Text(
          'Library',
          //textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: Container(
          // alignment: AxisDirection.left,
          // padding: EdgeInsets.only(right: 90),
          child: IconButton(
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              Navigator.popAndPushNamed(context, '/media');
            },
            icon: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: DefaultTabController(
        length: 5,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              height: maxHeight * 0.0675,
              child: new TabBar(
                labelPadding: EdgeInsets.all(3),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: 'Playlists',
                  ),
                  Tab(
                    text: 'Tracks',
                  ),
                  Tab(
                    text: 'Ragis',
                  ),
                  Tab(
                    text: 'Downloads',
                  ),
                  Tab(
                    text: 'Podcasts',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              PlayListWidget(
                  showOverlay: this.widget.showOverlay,
                  showOverlayTrue: this.widget.showOverlayTrue,
                  showOverlayFalse: this.widget.showOverlayFalse,
                  show: this.widget.show,
                  play: this.widget.play,
                  setListLinks: this.widget.setListLinks,
                  setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                  insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                  currentSong: this.widget.currentSong),
              LibraryTracks(
                showOverlay: this.widget.showOverlay,
                showOverlayTrue: this.widget.showOverlayTrue,
                showOverlayFalse: this.widget.showOverlayFalse,
                show: this.widget.show,
                play: this.widget.play,
                setListLinks: this.widget.setListLinks,
                setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                currentSong: this.widget.currentSong,
              ),
              LibraryArtists(
                  showOverlay: this.widget.showOverlay,
                  showOverlayTrue: this.widget.showOverlayTrue,
                  showOverlayFalse: this.widget.showOverlayFalse,
                  show: this.widget.show,
                  play: this.widget.play,
                  setListLinks: this.widget.setListLinks,
                  insertRecentlyPlayed: this.widget.insertRecentlyPlayed,
                  setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                  currentSong: this.widget.currentSong),
              LibraryDownloads(
                  showOverlay: this.widget.showOverlay,
                  showOverlayTrue: this.widget.showOverlayTrue,
                  showOverlayFalse: this.widget.showOverlayFalse,
                  show: this.widget.show,
                  play: this.widget.play,
                  setListLinks: this.widget.setListLinks,
                  setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                  currentSong: this.widget.currentSong),
              LibraryPodcasts(
                  showOverlay: this.widget.showOverlay,
                  showOverlayTrue: this.widget.showOverlayTrue,
                  showOverlayFalse: this.widget.showOverlayFalse,
                  show: this.widget.show,
                  play: this.widget.play,
                  setListLinks: this.widget.setListLinks,
                  setPropertiesForFullScreen: this.widget.setPropertiesForFullScreen,
                  currentSong: this.widget.currentSong)
            ],
          ),
        ),
      ),
    );
  }
}
