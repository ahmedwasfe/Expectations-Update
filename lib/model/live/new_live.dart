class NewLive{
  String? status;
  int? errors;
  NewLiveData? data;

  NewLive({this.status, this.errors, this.data});

  NewLive.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? NewLiveData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

}

class NewLiveData{

  int? userId;
  int? code;
  String? start;
  String? token;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  NewLiveData(
      {this.userId,
        this.code,
        this.start,
        this.token,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  NewLiveData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    code = json['code'];
    start = json['start'];
    token = json['token'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['code'] = this.code;
    data['start'] = this.start;
    data['token'] = this.token;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}