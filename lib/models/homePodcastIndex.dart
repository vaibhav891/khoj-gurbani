class HomePodcastIndex {
  String status;
  String message;
  List<Result> result;

  HomePodcastIndex({this.status, this.message, this.result});

  HomePodcastIndex.fromJson(Map<String, dynamic> json) {
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
  String englishPodcastSrc;
  String updatedAt;
  String createdAt;
  String duration;
  String time;
  bool commentryDesc;
  bool commentryStatus;
  int is_media;
  int pId;
  String pTitle;
  String pDescription;
  String punjabiPodcardSrc;
  String pUpdatedAt;
  String pCreatedAt;
  String pDuration;
  String pTime;
  bool pCommentryDesc;
  bool pCommentryStatus;
  int is_radio = 1;
  String thumbnail;

  Result(
      {this.id,
      this.title,
      this.description,
      this.englishPodcastSrc,
      this.updatedAt,
      this.createdAt,
      this.duration,
      this.time,
      this.commentryDesc,
      this.commentryStatus,
      this.is_media,
      this.pId,
      this.pTitle,
      this.pDescription,
      this.punjabiPodcardSrc,
      this.pUpdatedAt,
      this.pCreatedAt,
      this.pDuration,
      this.pTime,
      this.pCommentryDesc,
      this.pCommentryStatus,
      this.is_radio,
      this.thumbnail});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    englishPodcastSrc = json['englishPodcastSrc'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    duration = json['duration'];
    time = json['time'];
    commentryDesc = json['commentry_desc'];
    commentryStatus = json['commentry_status'];
    is_media = json['is_media'];
    pId = json['p_id'];
    pTitle = json['p_title'];
    pDescription = json['p_description'];
    punjabiPodcardSrc = json['punjabiPodcardSrc'];
    pUpdatedAt = json['p_updated_at'];
    pCreatedAt = json['p_created_at'];
    pDuration = json['p_duration'];
    pTime = json['p_time'];
    pCommentryDesc = json['p_commentry_desc'];
    pCommentryStatus = json['p_commentry_status'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['englishPodcastSrc'] = this.englishPodcastSrc;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['duration'] = this.duration;
    data['time'] = this.time;
    data['commentry_desc'] = this.commentryDesc;
    data['commentry_status'] = this.commentryStatus;
    data['is_media'] = this.is_media;
    data['p_id'] = this.pId;
    data['p_title'] = this.pTitle;
    data['p_description'] = this.pDescription;
    data['punjabiPodcardSrc'] = this.punjabiPodcardSrc;
    data['p_updated_at'] = this.pUpdatedAt;
    data['p_created_at'] = this.pCreatedAt;
    data['p_duration'] = this.pDuration;
    data['p_time'] = this.pTime;
    data['p_commentry_desc'] = this.pCommentryDesc;
    data['p_commentry_status'] = this.pCommentryStatus;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
