import 'package:expectations/model/user.dart';

class Viewer{
  String? status;
  int? errors;
  List<ViewerData>? data;

  Viewer({this.status, this.errors, this.data});

  Viewer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <ViewerData>[];
      json['data'].forEach((v) {
        data!.add(ViewerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewerData{
  int? id;
  int? userId;
  int? liveId;
  String? status;
  String? createdAt;
  String? updatedAt;
  UserData? user;

  ViewerData(
      {this.id,
        this.userId,
        this.liveId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user});

  ViewerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    liveId = json['live_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['live_id'] = this.liveId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}