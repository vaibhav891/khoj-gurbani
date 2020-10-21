class UserFavoriteMedia{
  String status;
  String message;
  List<FavList> favList;

  UserFavoriteMedia({this.status, this.message, this.favList});

  UserFavoriteMedia.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['fav_list'] != null) {
      favList = new List<FavList>();
      json['fav_list'].forEach((v) {
        favList.add(new FavList.fromJson(v));
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

class FavList {
  int id;
  int shabadId;
  String title;
  String author;
  String type;
  String duration;
  String attachmentName;
  String image;
  int page;
  int is_media;
  int author_id;

  FavList(
      {this.id,
      this.shabadId,
      this.title,
      this.author,
      this.type,
      this.duration,
      this.attachmentName,
      this.image,
      this.page,
      this.is_media,
      this.author_id,});

  FavList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    author = json['author'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
    page = json['page'];
    is_media = json['is_media'];
    author_id = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    data['page'] = this.page;
    data['is_media'] = this.is_media;
    data['author_id'] = this.author_id;
    return data;
  }
}
