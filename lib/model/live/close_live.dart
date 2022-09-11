class CloseLive{
  String? status;
  int? errors;
  CloseLiveData? data;

  CloseLive({this.status, this.errors, this.data});

  CloseLive.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? CloseLiveData.fromJson(json['data']) : null;
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

class CloseLiveData{

  int? id;
  int? code;
  int? userId;
  String? start;
  String? end;
  String? status;
  String? createdAt;
  String? updatedAt;

  CloseLiveData(
      {this.id,
        this.code,
        this.userId,
        this.start,
        this.end,
        this.status,
        this.createdAt,
        this.updatedAt});

  CloseLiveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    start = json['start'];
    end = json['end'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}