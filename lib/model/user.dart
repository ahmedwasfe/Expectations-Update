class User {
  String? status;
  int? errors;
  UserData? data;
  String? message;

  User({this.status, this.errors, this.data});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  User.message(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    message = json['data'];
  }

  factory User.toObject(Map<String, dynamic> json) => User(
        status: json['status'],
        errors: json['errors'],
        data: UserData.toObject(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': this.status,
        'errors': this.errors,
        'date': this.data!.toJson()
      };
}

class UserData {
  int? id;
  String? name;
  String? email;
  dynamic? emailVerifiedAt;
  String? dateOfBirth;
  String? athleticInclinations;
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
  String? ipAddress;
  int? numberDays;
  String? exDate;
  String? createdAt;
  String? updatedAt;
  String? accessToken;

  UserData(
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
      this.updatedAt,
      this.accessToken});

  UserData.fromJson(Map<String, dynamic> json) {
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
    accessToken = json['accessToken'];
  }

  factory UserData.toObject(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        dateOfBirth: json['date_of_birth'],
        athleticInclinations: json['athletic_inclinations'],
        address: json['address'],
        phone: json['phone'],
        image: json['image'],
        status: json['status'],
        type: json['type'],
        tokenFb: json['token_fb'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        accessToken: json['accessToken'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['accessToken'] = this.accessToken;
    return data;
  }
}
