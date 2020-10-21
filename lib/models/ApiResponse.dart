class AddPlaylistApiResponse {
  String status;
  String message;
  Response response;

  AddPlaylistApiResponse({this.status, this.message, this.response});

  AddPlaylistApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  int playlistId;
  String playlistName;
  int userId;
  String machineId;
  String createdAt;
  String updatedAt;

  Response(
      {this.playlistId,
      this.playlistName,
      this.userId,
      this.machineId,
      this.createdAt,
      this.updatedAt});

  Response.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    playlistName = json['playlist_name'];
    userId = json['user_id'];
    machineId = json['machine_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['playlist_name'] = this.playlistName;
    data['user_id'] = this.userId;
    data['machine_id'] = this.machineId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}