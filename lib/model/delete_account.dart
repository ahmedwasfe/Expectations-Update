class DeleteAccount{

  String? message;

  DeleteAccount({this.message});

  DeleteAccount.fromJson(Map<String, dynamic> json) {
    message = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.message;
    return data;
  }
}