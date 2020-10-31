class FeaturedPodcastsList {
  String status;
  String message;
  Result result;

  FeaturedPodcastsList({this.status, this.message, this.result});

  FeaturedPodcastsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<FeaturedCategoriesModel> featuredCategories;
  List<FeaturedPodcastCategories> featuredPodcastCategories;
  List<Null> popularTracks;
  List<Null> recentlyPlayed;
  List<FeaturedPodcasts> featuredPodcasts;
  TodayPodcast todayPodcast;
  List<FeaturedAuthors> featuredAuthors;
  List<FeaturedTracks> featuredTracks;

  Result(
      {this.featuredCategories,
      this.featuredPodcastCategories,
      this.popularTracks,
      this.recentlyPlayed,
      this.featuredPodcasts,
      this.todayPodcast,
      this.featuredAuthors,
      this.featuredTracks});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['featured_categories'] != null) {
      featuredCategories = new List<FeaturedCategoriesModel>();
      json['featured_categories'].forEach((v) {
        featuredCategories.add(new FeaturedCategoriesModel.fromJson(v));
      });
    }
    if (json['featured_podcast_categories'] != null) {
      featuredPodcastCategories = new List<FeaturedPodcastCategories>();
      json['featured_podcast_categories'].forEach((v) {
        featuredPodcastCategories
            .add(new FeaturedPodcastCategories.fromJson(v));
      });
    }
    if (json['popular_tracks'] != null) {
      popularTracks = new List<Null>();
      json['popular_tracks'].forEach((v) {
        // popularTracks.add(new Null.fromJson(v));
      });
    }
    if (json['recently_played'] != null) {
      recentlyPlayed = new List<Null>();
      json['recently_played'].forEach((v) {
        // recentlyPlayed.add(new Null.fromJson(v));
      });
    }
    if (json['featured_podcasts'] != null) {
      featuredPodcasts = new List<FeaturedPodcasts>();
      json['featured_podcasts'].forEach((v) {
        featuredPodcasts.add(new FeaturedPodcasts.fromJson(v));
      });
    }
    todayPodcast = json['today_podcast'] != null
        ? new TodayPodcast.fromJson(json['today_podcast'])
        : null;
    if (json['featured_authors'] != null) {
      featuredAuthors = new List<FeaturedAuthors>();
      json['featured_authors'].forEach((v) {
        featuredAuthors.add(new FeaturedAuthors.fromJson(v));
      });
    }
    if (json['featured_tracks'] != null) {
      featuredTracks = new List<FeaturedTracks>();
      json['featured_tracks'].forEach((v) {
        featuredTracks.add(new FeaturedTracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featuredCategories != null) {
      data['featured_categories'] =
          this.featuredCategories.map((v) => v.toJson()).toList();
    }
    if (this.featuredPodcastCategories != null) {
      data['featured_podcast_categories'] =
          this.featuredPodcastCategories.map((v) => v.toJson()).toList();
    }
    if (this.popularTracks != null) {
      // data['popular_tracks'] =
          // this.popularTracks.map((v) => v.toJson()).toList();
    }
    if (this.recentlyPlayed != null) {
      // data['recently_played'] =
          // this.recentlyPlayed.map((v) => v.toJson()).toList();
    }
    if (this.featuredPodcasts != null) {
      data['featured_podcasts'] =
          this.featuredPodcasts.map((v) => v.toJson()).toList();
    }
    if (this.todayPodcast != null) {
      data['today_podcast'] = this.todayPodcast.toJson();
    }
    if (this.featuredAuthors != null) {
      data['featured_authors'] =
          this.featuredAuthors.map((v) => v.toJson()).toList();
    }
    if (this.featuredTracks != null) {
      data['featured_tracks'] =
          this.featuredTracks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedCategoriesModel {
  int id;
  String name;
  String slug;
  int subCategoryCount;
  String attachmentName;

  FeaturedCategoriesModel(
      {this.id,
      this.name,
      this.slug,
      this.subCategoryCount,
      this.attachmentName});

  FeaturedCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    subCategoryCount = json['sub_category_count'];
    attachmentName = json['attachment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['sub_category_count'] = this.subCategoryCount;
    data['attachment_name'] = this.attachmentName;
    return data;
  }
}

class FeaturedPodcastCategories {
  int id;
  String title;
  String description;
  String categoryImage;
  int featured;
  int featuredDisplayOrder;
  List<Null> podcastSubcats;

  FeaturedPodcastCategories(
      {this.id,
      this.title,
      this.description,
      this.categoryImage,
      this.featured,
      this.featuredDisplayOrder,
      this.podcastSubcats});

  FeaturedPodcastCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categoryImage = json['category_image'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    if (json['podcast_subcats'] != null) {
      podcastSubcats = new List<Null>();
      json['podcast_subcats'].forEach((v) {
        // podcastSubcats.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category_image'] = this.categoryImage;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    if (this.podcastSubcats != null) {
      // data['podcast_subcats'] =
          // this.podcastSubcats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedPodcasts {
  int id;
  String title;
  final String author = null;
  final int page = null;
  String duration;
  int featured;
  int featuredDisplayOrder;
  String attachmentName;
  int is_media = null;
  final int author_id = null;
  int shabadId;
  String image;

  FeaturedPodcasts(
      {this.id,
      this.title,
      this.duration,
      this.featured,
      this.featuredDisplayOrder,
      this.attachmentName,
      this.shabadId,
      this.image});

  FeaturedPodcasts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    attachmentName = json['media'];
    shabadId = json['shabad_id'];
    image = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    data['media'] = this.attachmentName;
    data['shabad_id'] = this.shabadId;
    data['thumbnail'] = this.image;
    return data;
  }
}

class TodayPodcast {
  int id;
  String title;
  Null author;
  String description;
  String mediaData;
  String updatedAt;
  String duration;
  String time;
  bool commentryDesc;
  bool commentryStatus;
  String image;

  TodayPodcast(
      {this.id,
      this.title,
      this.author,
      this.description,
      this.mediaData,
      this.updatedAt,
      this.duration,
      this.time,
      this.commentryDesc,
      this.commentryStatus,
      this.image});

  TodayPodcast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    mediaData = json['media_data'];
    updatedAt = json['updated_at'];
    duration = json['duration'];
    time = json['time'];
    commentryDesc = json['commentry_desc'];
    commentryStatus = json['commentry_status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['media_data'] = this.mediaData;
    data['updated_at'] = this.updatedAt;
    data['duration'] = this.duration;
    data['time'] = this.time;
    data['commentry_desc'] = this.commentryDesc;
    data['commentry_status'] = this.commentryStatus;
    data['image'] = this.image;
    return data;
  }
}

class FeaturedAuthors {
  int id;
  String name;
  int status;
  String attachmentName;

  FeaturedAuthors(
      {this.id,
      this.name,
      this.status,
      this.attachmentName});

  FeaturedAuthors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    attachmentName = json['attachment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['attachment_name'] = this.attachmentName;
    return data;
  }
}

class FeaturedTracks {
  int id;
  int shabadId;
  String title;
  String authorName;
  String type;
  String duration;
  String attachmentName;
  String image;
  int favourite;
  int authorId;

  FeaturedTracks(
      {this.id,
      this.shabadId,
      this.title,
      this.authorName,
      this.type,
      this.duration,
      this.attachmentName,
      this.image,
      this.favourite,
      this.authorId});

  FeaturedTracks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shabadId = json['shabad_id'];
    title = json['title'];
    authorName = json['author_name'];
    type = json['type'];
    duration = json['duration'];
    attachmentName = json['attachment_name'];
    image = json['image'];
    favourite = json['favourite'];
    authorId = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shabad_id'] = this.shabadId;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['attachment_name'] = this.attachmentName;
    data['image'] = this.image;
    data['favourite'] = this.favourite;
    data['author_id'] = this.authorId;
    return data;
  }
}