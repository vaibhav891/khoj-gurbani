class Melodies {
  int id;
  String melody;
  String melodyGurmukhi;
  Null melodyDescription;

  Melodies({this.id, this.melody, this.melodyGurmukhi, this.melodyDescription});

  Melodies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    melody = json['Melody'];
    melodyGurmukhi = json['MelodyGurmukhi'];
    melodyDescription = json['MelodyDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Melody'] = this.melody;
    data['MelodyGurmukhi'] = this.melodyGurmukhi;
    data['MelodyDescription'] = this.melodyDescription;
    return data;
  }
}