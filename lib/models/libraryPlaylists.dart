class Playlists {
  String status;
  String message;
  List<Playlist> playlist;

  Playlists({this.status, this.message, this.playlist});

  Playlists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['playlist'] != null) {
      playlist = new List<Playlist>();
      json['playlist'].forEach((v) {
        playlist.add(new Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.playlist != null) {
      data['playlist'] = this.playlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlist {
  int playlistId;
  String playlistName;
  int userId;
  String machineId;
  String createdAt;
  String updatedAt;
  List<AuthorImage> authorImage;
  int cntPlaylistMedia;

  Playlist(
      {this.playlistId,
      this.playlistName,
      this.userId,
      this.machineId,
      this.createdAt,
      this.updatedAt,
      this.authorImage,
      this.cntPlaylistMedia});

  Playlist.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    playlistName = json['playlist_name'];
    userId = json['user_id'];
    machineId = json['machine_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['author_image'] != null) {
      authorImage = new List<AuthorImage>();
      json['author_image'].forEach((v) {
        authorImage.add(new AuthorImage.fromJson(v));
      });
    }
    cntPlaylistMedia = json['cnt_playlist_media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['playlist_name'] = this.playlistName;
    data['user_id'] = this.userId;
    data['machine_id'] = this.machineId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.authorImage != null) {
      data['author_image'] = this.authorImage.map((v) => v.toJson()).toList();
    }
    data['cnt_playlist_media'] = this.cntPlaylistMedia;
    return data;
  }
}

class AuthorImage {
  String image;

  AuthorImage({this.image});

  AuthorImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
