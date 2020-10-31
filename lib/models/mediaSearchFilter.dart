class MediaSearchFilter {
  int mediaId;
  String image;
  String attachmentName;
  int shabadId;
  int id;
  int page;
  int is_media;
  String scripture;
  String scriptureRoman;
  String scriptureRomanEnglish;
  int melodyID;
  String melody;
  int authorID;
  String author;
  String title;
  String duration;
  String name;
  int author_id;

  MediaSearchFilter(
      {this.mediaId,
      this.image,
      this.attachmentName,
      this.shabadId,
      this.id,
      this.page,
      this.is_media,
      this.scripture,
      this.scriptureRoman,
      this.scriptureRomanEnglish,
      this.melodyID,
      this.melody,
      this.authorID,
      this.author,
      this.title,
      this.duration,
      this.name,
      this.author_id});

  MediaSearchFilter.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    image = json['image'];
    attachmentName = json['attachment_name'];
    shabadId = json['ShabadID'];
    id = json['id'];
    page = json['Page'];
    is_media = json['is_media'];
    scripture = json['Scripture'];
    scriptureRoman = json['ScriptureRoman'];
    scriptureRomanEnglish = json['ScriptureRomanEnglish'];
    melodyID = json['MelodyID'];
    melody = json['Melody'];
    authorID = json['AuthorID'];
    author = json['Author'];
    title = json['title'];
    duration = json['duration'];
    name = json['name'];
    author_id = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_id'] = this.mediaId;
    data['image'] = this.image;
    data['attachment_name'] = this.attachmentName;
    data['ShabadID'] = this.shabadId;
    data['id'] = this.id;
    data['Page'] = this.page;
    data['is_media'] = this.is_media;
    data['Scripture'] = this.scripture;
    data['ScriptureRoman'] = this.scriptureRoman;
    data['ScriptureRomanEnglish'] = this.scriptureRomanEnglish;
    data['MelodyID'] = this.melodyID;
    data['Melody'] = this.melody;
    data['AuthorID'] = this.authorID;
    data['Author'] = this.author;
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['name'] = this.name;
    data['author_id'] = this.author_id;
    return data;
  }
}
