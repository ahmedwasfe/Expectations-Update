class LiveComments{
  String? status;
  int? errors;
  List<LiveCommentData>? data;

  LiveComments({this.status, this.errors, this.data});

  LiveComments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <LiveCommentData>[];
      json['data'].forEach((v) {
        data!.add(LiveCommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveCommentData{

  int? id;
  int? userId;
  int? liveId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  CommentUser? user;

  LiveCommentData(
      {this.id,
        this.userId,
        this.liveId,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.user});

  LiveCommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    liveId = json['live_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['live_id'] = this.liveId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class CommentUser{
  int? id;
  String? name;
  String? email;
  dynamic? emailVerifiedAt;
  String? dateOfBirth;
  dynamic? athleticInclinations;
  String? address;
  String? phone;
  String? image;
  String? status;
  String? type;
  dynamic? tokenFb;
  dynamic? companyName;
  dynamic? mobile;
  dynamic? companyProfile;
  dynamic? urlWeb;
  dynamic? ipAddress;
  dynamic? numberDays;
  dynamic? exDate;
  String? createdAt;
  String? updatedAt;

  CommentUser(
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
        this.ipAddress,
        this.numberDays,
        this.exDate,
        this.createdAt,
        this.updatedAt});

  CommentUser.fromJson(Map<String, dynamic> json) {
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
    ipAddress = json['ip_address'];
    numberDays = json['number_days'];
    exDate = json['ex_date'];
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
    data['ip_address'] = this.ipAddress;
    data['number_days'] = this.numberDays;
    data['ex_date'] = this.exDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}