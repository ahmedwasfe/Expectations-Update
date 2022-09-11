class MakeLike{
  String? status;
  int? errors;
  MakeLikeData? data;

  MakeLike({this.status, this.errors, this.data});

  MakeLike.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? MakeLikeData.fromJson(json['data']) : null;
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

class MakeLikeData {
  int? userId;
  String? liveId;
  String? updatedAt;
  String? createdAt;
  int? id;

  MakeLikeData({this.userId, this.liveId, this.updatedAt, this.createdAt, this.id});

  MakeLikeData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    liveId = json['live_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['live_id'] = this.liveId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}