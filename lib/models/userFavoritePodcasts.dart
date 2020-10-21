class UserFavoritePodcast {
  String status;
  String message;
  List<FavListPodcasts> favListPodcasts;

  UserFavoritePodcast({this.status, this.message, this.favListPodcasts});

  UserFavoritePodcast.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['fav_list'] != null) {
      favListPodcasts = new List<FavListPodcasts>();
      json['fav_list'].forEach((v) {
        favListPodcasts.add(new FavListPodcasts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.favListPodcasts != null) {
      data['fav_list'] = this.favListPodcasts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavListPodcasts {
  int id;
  int shabadId;
  String title;
  String description;
  Null author;
  Null page;
  Null is_media;
  Null author_id;
  String type;
  String duration;
  String attachmentName;
  String image;

  FavListPodcasts(
      {this.id,
      this.shabadId,
      this.title,
      this.description,
      this.author,
      this.page,
      this.is_media,
      this.author_id,
      this.type,
      this.duration,
      this.attachmentName,
      this.image});

  FavListPodcasts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
    page = json['page'];
    is_media = json['is_media'];
    author_id = json['author_id'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['author'] = this.author;
    data['page'] = this.page;
    data['is_media'] = this.is_media;
    data['author_id'] = this.author_id;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    return data;
  }
}