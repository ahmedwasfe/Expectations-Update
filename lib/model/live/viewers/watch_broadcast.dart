class Broadcast{
  String? status;
  int? errors;
  BroadcastData? data;

  Broadcast({this.status, this.errors, this.data});

  Broadcast.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? BroadcastData.fromJson(json['data']) : null;
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

class BroadcastData{

  int? userId;
  dynamic? liveId;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  BroadcastData(
      {this.userId,
        this.liveId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  BroadcastData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    liveId = json['live_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['live_id'] = this.liveId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }

}