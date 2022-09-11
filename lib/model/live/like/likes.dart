import 'package:expectations/model/user.dart';

class Likes{
  String? status;
  int? errors;
  LikesData? data;

  Likes({this.status, this.errors, this.data});

  Likes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? LikesData.fromJson(json['data']) : null;
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

class LikesData{
  int? id;
  int? userId;
  int? liveId;
  Null? likeId;
  String? createdAt;
  String? updatedAt;
  UserData? user;

  LikesData(
      {this.id,
        this.userId,
        this.liveId,
        this.likeId,
        this.createdAt,
        this.updatedAt,
        this.user});

  LikesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    liveId = json['live_id'];
    likeId = json['like_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['live_id'] = this.liveId;
    data['like_id'] = this.likeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}