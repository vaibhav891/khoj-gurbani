class Downloads {
  final int id;
  final String title;
  final String author;
  final String attachmentName;
  final String image;
  final int shabad_id;
  final int page;
  final int is_media;
  final int author_id;
  final int fromFile;

  Downloads({
    this.id,
    this.title,
    this.author,
    this.attachmentName,
    this.image,
    this.shabad_id = 0,
    this.page = 0,
    this.is_media,
    this.author_id = 0,
    this.fromFile = 0,
  });

  factory Downloads.fromMap(Map<String, dynamic> json) => new Downloads(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        attachmentName: json["attachmentName"],
        image: json["image"],
        shabad_id: json["shabad_id"],
        page: json["page"],
        is_media: json["is_media"],
        author_id: json["author_id"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'attachmentName': attachmentName,
      'image': image,
      'shabad_id': shabad_id,
      'page': page,
      'is_media': is_media,
      'author_id': author_id,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $title, author: $author, attachmentName: $attachmentName, image: $image, is_media: $is_media, author_id: $author_id,shabad_id: $shabad_id,page: $page}';
  }
}
