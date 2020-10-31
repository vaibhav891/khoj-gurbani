import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khojgurbani_music/models/featuredPodcasts.dart';
import 'package:khojgurbani_music/models/homePodcastIndex.dart';
import 'package:khojgurbani_music/models/userFavoriteArtists.dart';
import 'package:khojgurbani_music/models/userFavoritePodcasts.dart';
import 'package:khojgurbani_music/models/oneArtist.dart';
import 'package:khojgurbani_music/widgets/featured_categories_carousel.dart';
import 'package:khojgurbani_music/models/userMedia.dart';
import 'package:khojgurbani_music/widgets/featured_media_carousel.dart';
import 'package:khojgurbani_music/models/playlistTracks.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  /// Featured Media Carousel
  var medias;
  Future getFeaturedMedia() async {
    var data = await http
        .get('https://api.khojgurbani.org/api/v1/android/featured-media');
    var jsonData = json.decode(data.body);

    FeaturedMediaSongs m = new FeaturedMediaSongs.fromJson(jsonData);

    medias = m.result;
    return m;
  }

// User Library Tracks
  var userMedia;
  final userMediaSubject = new BehaviorSubject<List<FavList>>();
  List shuffleListUserMedias = [];
  Future getUserFavoriteMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final machineId = prefs.getString('machine_id');

    var response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/fav-list?user_id=$userId&machine_id=$machineId',
    );
    var jsonData = json.decode(response.body);

    UserFavoriteMedia result = new UserFavoriteMedia.fromJson(jsonData);

    userMedia = result.favList;
    userMediaSubject.add(userMedia);
    userMedia.forEach((a) {
      shuffleListUserMedias.add(a);
    });
    return userMedia;
  }

  var userFavoriteArtists;
  final userFavoriteArtistSubject = new BehaviorSubject<List<ArtistFavList>>();
  Future getUserFavoriteArtists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final machineId = prefs.getString('machine_id');

    var response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/artist-fav-list?user_id=$userId&machine_id=$machineId',
    );
    var jsonData = json.decode(response.body);

    UserFavoriteArtists result = new UserFavoriteArtists.fromJson(jsonData);

    userFavoriteArtists = result.artistFavList;
    userFavoriteArtistSubject.add(userFavoriteArtists);

    return userFavoriteArtists;
  }

  var favUserPodcasts;
  final userPodcastSubject = new BehaviorSubject<List<FavListPodcasts>>();
  List shuffleUserFavoritePodcasts = [];

  Future getUserFavoritePodcasts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final machineId = prefs.getString('machine_id');

    final response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/podcast-fav-list?user_id=$userId&machine_id=$machineId',
    );
    var jsonData = json.decode(response.body);

    UserFavoritePodcast result = new UserFavoritePodcast.fromJson(jsonData);

    favUserPodcasts = result.favListPodcasts;
    userPodcastSubject.add(favUserPodcasts);
    favUserPodcasts.forEach((a) {
      shuffleUserFavoritePodcasts.add(a);
    });

    return favUserPodcasts;
  }

  // GET CATEGORYES

  var categories;
  Future getFeaturedCategories() async {
    var data = await http
        .get('https://api.khojgurbani.org/api/v1/android/featured-categories');
    var jsonData = json.decode(data.body);

    FeaturedCategories c = new FeaturedCategories.fromJson(jsonData);

    categories = c.result;

    return c;
  }

  // GET ONE ARTIST
  var oneArtist;
  List shuffleListOneArtist = [];

  Future getOneArtist(id, {initialLink}) async {
    // if (oneArtist != null) oneArtist.clear();
    // shuffleListOneArtist.clear();
    // if (initialLink == null) {
      var data = await http.get(
          'https://api.khojgurbani.org/api/v1/android/featured-artist-gurbani/$id');

      var jsonData = json.decode(data.body);

      OneArtist result = new OneArtist.fromJson(jsonData);

      oneArtist = result.result;

      oneArtist.forEach((a) {
        shuffleListOneArtist.add(a);
      });
    // } else {
    //   var data = await http.get(initialLink);

    //   var jsonData = json.decode(data.body);

    //   OneArtist result = new OneArtist.fromJson(jsonData);

    //   oneArtist = result.result;

    //   oneArtist.forEach((a) {
    //     shuffleListOneArtist.add(a);
    //   });
    // }

    return oneArtist;
  }

// featured artist on media page
  var artists;
  Future getFeaturedArtists() async {
    var data =
        await http.get('https://api.khojgurbani.org/api/v1/android/home-skip');
    var jsonData = json.decode(data.body);

    FeaturedPodcastsList artist = FeaturedPodcastsList.fromJson(jsonData);

    artists = artist.result.featuredAuthors;

    return artists;
  }

  // Get playlist tracks

  var playlistTracks;
  final playlistSubject = new BehaviorSubject<List<FavListPlaylistTracks>>();
  List shuffleListPlaylist = [];
  var length;
  Future getPlaylistTracks(int playlist_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');
    final machineId = prefs.getString('machine_id');
    // final headers = {'Authorization': "Bearer " + token};
    final response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/user-playlist-tracks?user_id=$userId&machine_id=$machineId&playlist_id=$playlist_id',
      // headers: headers
    );
    var jsonData = json.decode(response.body);

    PlaylistTracks result = new PlaylistTracks.fromJson(jsonData);

    playlistTracks = result.favList;
    playlistSubject.add(playlistTracks);
    playlistTracks.forEach((a) {
      shuffleListPlaylist.add(a);
    });
    length = playlistTracks.length;

    return playlistTracks;
  }

  var homePodcastIndex;
  Future getHomePodcastIndex() async {
    final response = await http.get(
      'https://api.khojgurbani.org/api/v1/android/home-podcast-index',
      // headers: headers
    );
    var jsonData = json.decode(response.body);

    HomePodcastIndex result = new HomePodcastIndex.fromJson(jsonData);

    homePodcastIndex = result.result;

    return homePodcastIndex;
  }

  bool showFromService = false;
  showChange() {
    showFromService = !showFromService;
  }

  // Update All Song where evhere they are
  updateAllSongs() {
    getFeaturedMedia();
    getUserFavoriteMedia();
  }
}
