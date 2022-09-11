class AllLive {
  String? status;
  int? errors;
  List<LiveData>? data;

  AllLive({this.status, this.errors, this.data});

  AllLive.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <LiveData>[];
      json['data'].forEach((v) {
        data!.add(LiveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveData {

  int? id;
  int? code;
  String? liveToken;
  int? userId;
  String? start;
  dynamic? end;
  String? status;
  String? createdAt;
  String? updatedAt;
  LiveUser? user;

  LiveData({this.id,
    this.code,
    this.userId,
    this.liveToken,
    this.start,
    this.end,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user});

  LiveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    liveToken = json['token'];
    userId = json['user_id'];
    start = json['start'];
    end = json['end'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? LiveUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['token'] = this.liveToken;
    data['user_id'] = this.userId;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class LiveUser {

  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  dynamic? dateOfBirth;
  dynamic? athleticInclinations;
  dynamic? address;
  String? phone;
  dynamic? image;
  String? status;
  String? type;
  dynamic? tokenFb;
  dynamic? companyName;
  dynamic? mobile;
  dynamic? companyProfile;
  dynamic? urlWeb;
  String? createdAt;
  String? updatedAt;

  LiveUser(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.dateOfBirth,
        this.athleticInclinations,
        this.address,
        this.phone,
        this.image,
        this.status,
        this.type,
        this.tokenFb,
        this.companyName,
        this.mobile,
        this.companyProfile,
        this.urlWeb,
        this.createdAt,
        this.updatedAt});

  LiveUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dateOfBirth = json['date_of_birth'];
    athleticInclinations = json['athletic_inclinations'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
    status = json['status'];
    type = json['type'];
    tokenFb = json['token_fb'];
    companyName = json['company_name'];
    mobile = json['mobile'];
    companyProfile = json['company_profile'];
    urlWeb = json['url_web'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['date_of_birth'] = this.dateOfBirth;
    data['athletic_inclinations'] = this.athleticInclinations;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['status'] = this.status;
    data['type'] = this.type;
    data['token_fb'] = this.tokenFb;
    data['company_name'] = this.companyName;
    data['mobile'] = this.mobile;
    data['company_profile'] = this.companyProfile;
    data['url_web'] = this.urlWeb;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}