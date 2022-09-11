class CreateComment{
  String? status;
  int? errors;
  CreateCommentData? data;

  CreateComment({this.status, this.errors, this.data});

  CreateComment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'] != null ? CreateCommentData?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class CreateCommentData{
  int? userid;
  String? liveid;
  String? comment;
  String? updatedat;
  String? createdat;
  int? id;

  CreateCommentData({this.userid, this.liveid, this.comment, this.updatedat, this.createdat, this.id});

  CreateCommentData.fromJson(Map<String, dynamic> json) {
    userid = json['user_id'];
    liveid = json['live_id'];
    comment = json['comment'];
    updatedat = json['updated_at'];
    createdat = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userid;
    data['live_id'] = liveid;
    data['comment'] = comment;
    data['updated_at'] = updatedat;
    data['created_at'] = createdat;
    data['id'] = id;
    return data;
  }
}