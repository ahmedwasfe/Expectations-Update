class DeleteLike {
  String? status;
  int? errors;
  String? data;

  DeleteLike({this.status, this.errors, this.data});

  DeleteLike.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errors'] = this.errors;
    data['data'] = this.data;
    return data;
  }
}