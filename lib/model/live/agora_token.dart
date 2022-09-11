class AgoraToken{
  String? token;
  String? channelName;

  AgoraToken({this.token, this.channelName});

  AgoraToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['channelName'] = this.channelName;
    return data;
  }
}