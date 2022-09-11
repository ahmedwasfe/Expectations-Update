class Packages{
  String? status;
  int? errors;
  List<PackagesData>? data;

  Packages({this.status, this.errors, this.data});

  Packages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <PackagesData>[];
      json['data'].forEach((v) {
        data!.add(PackagesData.fromJson(v));
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

class PackagesData{
  int? id;
  String? titleAr;
  String? titleEn;
  String? image;
  int? price;
  int? days;
  dynamic? sortOrder;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  PackagesData(
      {this.id,
        this.titleAr,
        this.titleEn,
        this.image,
        this.price,
        this.days,
        this.sortOrder,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  PackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    image = json['image'];
    price = json['price'];
    days = json['days'];
    sortOrder = json['sort_order'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['image'] = this.image;
    data['price'] = this.price;
    data['days'] = this.days;
    data['sort_order'] = this.sortOrder;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}