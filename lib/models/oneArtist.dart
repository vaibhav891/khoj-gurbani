class OneArtist {
  String status;
  int favourite;
  String message;
  List<Result> result;

  OneArtist({this.status, this.favourite, this.message, this.result});

  OneArtist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    favourite = json['favourite'];
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
    data['favourite'] = this.favourite;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  int shabadId;
  String title;
  String author;
  String duration;
  String authorName;
  String authorDescription;
  String attachmentName;
  String image;
  ShabadDetail shabadDetail;
  int favourite;
  int page;
  int is_media;
  int author_id;

  Result(
      {this.id,
      this.shabadId,
      this.title,
      this.author,
      this.duration,
      this.authorName,
      this.authorDescription,
      this.attachmentName,
      this.image,
      this.shabadDetail,
      this.favourite,
      this.page,
      this.is_media,
      this.author_id,});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    author = json['author'];
    duration = json['duration'];
    authorName = json['author_name'];
    authorDescription = json['author_description'];
    attachmentName = json['attachment_name'];
    image = json['author_image'];
    shabadDetail = json['shabad_detail'] != null
        ? new ShabadDetail.fromJson(json['shabad_detail'])
        : null;
    favourite = json['favourite'];
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
    data['duration'] = this.duration;
    data['author_name'] = this.authorName;
    data['author_description'] = this.authorDescription;
    data['attachment_name'] = this.attachmentName;
    data['author_image'] = this.image;
    if (this.shabadDetail != null) {
      data['shabad_detail'] = this.shabadDetail.toJson();
    }
    data['favourite'] = this.favourite;
    data['page'] = this.page;
    data['is_media'] = this.is_media;
    data['author_id'] = this.author_id;
    return data;
  }
}

class ShabadDetail {
  int id;
  String scripture;
  String scriptureOriginal;
  int infoID;
  int melodyID;
  int authorID;
  int page;
  int line;
  String section;
  String scriptureRoman;
  String scriptureRomanEnglish;
  String scriptureVowel;
  int shabadID;

  ShabadDetail(
      {this.id,
      this.scripture,
      this.scriptureOriginal,
      this.infoID,
      this.melodyID,
      this.authorID,
      this.page,
      this.line,
      this.section,
      this.scriptureRoman,
      this.scriptureRomanEnglish,
      this.scriptureVowel,
      this.shabadID});

  ShabadDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scripture = json['Scripture'];
    scriptureOriginal = json['ScriptureOriginal'];
    infoID = json['InfoID'];
    melodyID = json['MelodyID'];
    authorID = json['AuthorID'];
    page = json['Page'];
    line = json['Line'];
    section = json['Section'];
    scriptureRoman = json['ScriptureRoman'];
    scriptureRomanEnglish = json['ScriptureRomanEnglish'];
    scriptureVowel = json['ScriptureVowel'];
    shabadID = json['ShabadID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Scripture'] = this.scripture;
    data['ScriptureOriginal'] = this.scriptureOriginal;
    data['InfoID'] = this.infoID;
    data['MelodyID'] = this.melodyID;
    data['AuthorID'] = this.authorID;
    data['Page'] = this.page;
    data['Line'] = this.line;
    data['Section'] = this.section;
    data['ScriptureRoman'] = this.scriptureRoman;
    data['ScriptureRomanEnglish'] = this.scriptureRomanEnglish;
    data['ScriptureVowel'] = this.scriptureVowel;
    data['ShabadID'] = this.shabadID;
    return data;
  }
}
