class PodcastThemeAll {
  String status;
  String message;
  List<Result> result;

  PodcastThemeAll({this.status, this.message, this.result});

  PodcastThemeAll.fromJson(Map<String, dynamic> json) {
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
  String type;
  int status;
  String duration;
  int featured;
  int featuredDisplayOrder;
  int priorityStatus;
  int priorityOrderStatus;
  String attachmentName;
  String thumbnail;
  String createdAt;
  int userPodcastId;
  bool isSelected = false;

  Result(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.status,
      this.duration,
      this.featured,
      this.featuredDisplayOrder,
      this.priorityStatus,
      this.priorityOrderStatus,
      this.attachmentName,
      this.thumbnail,
      this.createdAt,
      this.userPodcastId,
      this.isSelected});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    status = json['status'];
    duration = json['duration'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    priorityStatus = json['priority_status'];
    priorityOrderStatus = json['priority_order_status'];
    attachmentName = json['attachment_name'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    userPodcastId = json['user_podcast_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    data['priority_status'] = this.priorityStatus;
    data['priority_order_status'] = this.priorityOrderStatus;
    data['attachment_name'] = this.attachmentName;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['user_podcast_id'] = this.userPodcastId;
    return data;
  }
}