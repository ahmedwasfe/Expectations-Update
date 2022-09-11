class Team{

  int? id;
  int? periodicalsId;
  String? name;
  String? nameEn;
  String? image;

  Team({this.id, this.periodicalsId, this.name, this.image});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    periodicalsId = json['periodicals_id'];
    name = json['name'];
    nameEn = json['name_en'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['periodicals_id'] = this.periodicalsId;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    return data;
  }
}