class AllPodcasts {
  String status;
  String message;
  List<Result> result;

  AllPodcasts({this.status, this.message, this.result});

  AllPodcasts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String title;
  String description;
  String author;
  String duration;
  int featured;
  int featuredDisplayOrder;
  String media;
  String thumbnail;
  String createdAt;
  String updatedAt;
  bool isSelected = false;

  Result({
    this.id,
    this.title,
    this.description,
    this.author,
    this.duration,
    this.featured,
    this.featuredDisplayOrder,
    this.media,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.isSelected
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    author = json['author'];
    duration = json['duration'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    media = json['media'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['author'] = this.author;
    data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    data['media'] = this.media;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
