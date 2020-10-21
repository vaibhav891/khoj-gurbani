class PlaylistTracks {
  String status;
  String message;
  List<FavListPlaylistTracks> favList;

  PlaylistTracks({this.status, this.message, this.favList});

  PlaylistTracks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['fav_list'] != null) {
      favList = new List<FavListPlaylistTracks>();
      json['fav_list'].forEach((v) {
        favList.add(new FavListPlaylistTracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.favList != null) {
      data['fav_list'] = this.favList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavListPlaylistTracks {
  int id;
  int shabadId;
  int favourite;
  String title;
  String author;
  String type;
  String duration;
  String attachmentName;
  String image;
  int is_media;
  int page;
  int author_id;

  FavListPlaylistTracks(
      {this.id,
      this.shabadId,
      this.favourite,
      this.title,
      this.author,
      this.type,
      this.duration,
      this.attachmentName,
      this.image,
      this.is_media,
      this.page,
      this.author_id});

  FavListPlaylistTracks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    favourite = json['favourite'];
    title = json['title'];
    author = json['author'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
    is_media = json['is_media'];
    page = json['page'];
    author_id = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['favourite'] = this.favourite;
    data['title'] = this.title;
    data['author'] = this.author;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    data['is_media'] = this.is_media;
    data['page'] = this.page;
    data['author_id'] = this.author_id;
    return data;
  }
}
