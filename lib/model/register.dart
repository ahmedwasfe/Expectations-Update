
class Register {
  String? status;
  int? errors;
  RegisterData? data;
  String? message;

  Register({this.status, this.errors, this.data});

  Register.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
  }

  Register.message(Map<String, dynamic> json){
    status = json['status'];
    errors = json['errors'];
    message = json['data'];
  }

  // factory Register.toObject(Map<String, dynamic> json) => Register(
  //       status: json['status'],
  //       errors: json['errors'],
  //       data: RegisterData.toObject(json['data']),
  //     );

  Map<String, dynamic> toJson() => {
        'status': this.status,
        'errors': this.errors,
        'data': this.data!.toJson()
      };

}

class RegisterData {
  String? name;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? address;
  String? ipAddress;
  String? image;
  String? type;
  String? status;
  String? numberDays;
  String? exDate;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  RegisterData({this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.address,
    this.ipAddress,
    this.image,
    this.type,
    this.status,
    this.numberDays,
    this.exDate,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token});

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    ipAddress = json['ip_address'];
    image = json['image'];
    type = json['type'];
    status = json['status'];
    numberDays = json['number_days'];
    exDate = json['ex_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['ip_address'] = this.ipAddress;
    data['image'] = this.image;
    data['type'] = this.type;
    data['status'] = this.status;
    data['number_days'] = this.numberDays;
    data['ex_date'] = this.exDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }

}
