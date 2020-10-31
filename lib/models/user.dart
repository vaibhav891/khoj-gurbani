class UserDetails {
  String status;
  Data data;

  UserDetails({this.status, this.data});

  UserDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int roleId;
  String name;
  String email;
  String emailVerifiedAt;
  int isActive;
  Null photoUrl;
  Null city;
  Null state;
  Null country;
  Null provider;
  Null googleId;
  Null fbId;
  Null lastLogin;
  int isBlock;
  int autoApprove;
  String verificationCode;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.roleId,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.isActive,
      this.photoUrl,
      this.city,
      this.state,
      this.country,
      this.provider,
      this.googleId,
      this.fbId,
      this.lastLogin,
      this.isBlock,
      this.autoApprove,
      this.verificationCode,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isActive = json['is_active'];
    photoUrl = json['photo_url'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    provider = json['provider'];
    googleId = json['google_id'];
    fbId = json['fb_id'];
    lastLogin = json['last_login'];
    isBlock = json['is_block'];
    autoApprove = json['auto_approve'];
    verificationCode = json['verification_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_active'] = this.isActive;
    data['photo_url'] = this.photoUrl;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['provider'] = this.provider;
    data['google_id'] = this.googleId;
    data['fb_id'] = this.fbId;
    data['last_login'] = this.lastLogin;
    data['is_block'] = this.isBlock;
    data['auto_approve'] = this.autoApprove;
    data['verification_code'] = this.verificationCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
