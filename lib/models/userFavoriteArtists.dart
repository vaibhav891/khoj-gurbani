class UserFavoriteArtists {
  String status;
  String message;
  List<ArtistFavList> artistFavList;

  UserFavoriteArtists({this.status, this.message, this.artistFavList});

  UserFavoriteArtists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['artist_fav_list'] != null) {
      artistFavList = new List<ArtistFavList>();
      json['artist_fav_list'].forEach((v) {
        artistFavList.add(new ArtistFavList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.artistFavList != null) {
      data['artist_fav_list'] =
          this.artistFavList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArtistFavList {
  int id;
  String slug;
  String name;
  String description;
  String image;
  int status;
  int featured;
  int featuredDisplayOrder;

  ArtistFavList(
      {this.id,
      this.slug,
      this.name,
      this.description,
      this.image,
      this.status,
      this.featured,
      this.featuredDisplayOrder});

  ArtistFavList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['featured_display_order'] = this.featuredDisplayOrder;
    return data;
  }
}