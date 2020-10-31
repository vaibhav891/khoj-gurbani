class Singers {
  int id;
  String slug;
  String name;
  String description;
  String image;
  int status;
  int featured;
  int featuredDisplayOrder;
  String createdAt;
  String updatedAt;

  Singers(
      {this.id,
      this.slug,
      this.name,
      this.description,
      this.image,
      this.status,
      this.featured,
      this.featuredDisplayOrder,
      this.createdAt,
      this.updatedAt});

  Singers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    featured = json['featured'];
    featuredDisplayOrder = json['featured_display_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}