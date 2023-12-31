// ignore_for_file: no_leading_underscores_for_local_identifiers

class HousePartnerItemModel {
  bool? status;
  String? message;
  Data? data;

  HousePartnerItemModel({this.status, this.message, this.data});

  HousePartnerItemModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? advertisementId;
  int? userId;
  int? serviceTypeId;
  String? location;
  String? neighborhood;
  int? numberPartners;
  String? nationality;
  String? title;
  String? description;
  int? phone;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;
  List<Comments>? comments;

  Data(
      {this.advertisementId,
      this.userId,
      this.serviceTypeId,
      this.location,
      this.neighborhood,
      this.numberPartners,
      this.nationality,
      this.title,
      this.description,
      this.phone,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos,
      this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["service_type_id"] is int) {
      serviceTypeId = json["service_type_id"];
    }
    if (json["location"] is String) {
      location = json["location"];
    }
    if (json["neighborhood"] is String) {
      neighborhood = json["neighborhood"];
    }
    if (json["number_partners"] is int) {
      numberPartners = json["number_partners"];
    }
    if (json["nationality"] is String) {
      nationality = json["nationality"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["phone"] is int) {
      phone = json["phone"];
    }
    if (json["user_name"] is String) {
      userName = json["user_name"];
    }
    if (json["created_at_1"] is String) {
      createdAt1 = json["created_at_1"];
    }
    if (json["created_at_2"] is String) {
      createdAt2 = json["created_at_2"];
    }
    if (json["photos"] is List) {
      photos =
          json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
    if (json["comments"] is List) {
      comments = json["comments"] == null
          ? null
          : (json["comments"] as List)
              .map((e) => Comments.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["advertisement_id"] = advertisementId;
    _data["user_id"] = userId;
    _data["service_type_id"] = serviceTypeId;
    _data["location"] = location;
    _data["neighborhood"] = neighborhood;
    _data["number_partners"] = numberPartners;
    _data["nationality"] = nationality;
    _data["title"] = title;
    _data["description"] = description;
    _data["phone"] = phone;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if (photos != null) {
      _data["photos"] = photos;
    }
    if (comments != null) {
      _data["comments"] = comments?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Comments {
  String? userName;
  String? comment;
  String? avatar;
  String? createdAt;

  Comments({this.userName, this.comment, this.avatar, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json["user_name"] is String) {
      userName = json["user_name"];
    }
    if (json["comment"] is String) {
      comment = json["comment"];
    }
    if (json["avatar"] is String) {
      avatar = json["avatar"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_name"] = userName;
    _data["comment"] = comment;
    _data["avatar"] = avatar;
    _data["created_at"] = createdAt;
    return _data;
  }
}
