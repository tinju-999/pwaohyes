class SubCatModel {
  int? errorCode;
  Data? data;
  bool? toast;
  String? message;

  SubCatModel({this.errorCode, this.data, this.toast, this.message});

  SubCatModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    toast = json['toast'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['toast'] = toast;
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Services>? services;

  Data({this.services});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? sId;
  String? title;
  List<Null>? tag;
  Description? description;
  List<Null>? videoMetadata;
  String? categoryId;
  String? image;
  int? iV;
  List<String>? cities;
  String? status;
  bool? visibleToPartnerOnly;

  Services(
      {this.sId,
      this.title,
      this.tag,
      this.description,
      this.videoMetadata,
      this.categoryId,
      this.image,
      this.iV,
      this.cities,
      this.status,
      this.visibleToPartnerOnly});

  Services.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    // if (json['tag'] != null) {
    //   tag = <Null>[];
    //   json['tag'].forEach((v) {
    //     tag!.add(Null.fromJson(v));
    //   });
    // }
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    // if (json['video_metadata'] != null) {
    //   videoMetadata = <Null>[];
    //   json['video_metadata'].forEach((v) {
    //     videoMetadata!.add(Null.fromJson(v));
    //   });
    // }
    categoryId = json['category_id'];
    image = checkData(json['image']);
    iV = json['__v'];
    cities = json['cities'].cast<String>();
    status = json['status'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    // if (tag != null) {
    //   data['tag'] = tag!.map((v) => v.toJson()).toList();
    // }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    // if (videoMetadata != null) {
    //   data['video_metadata'] = videoMetadata!.map((v) => v.toJson()).toList();
    // }
    data['category_id'] = categoryId;
    data['image'] = image;
    data['__v'] = iV;
    data['cities'] = cities;
    data['status'] = status;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    return data;
  }

  String? checkData(json) {
    if (json != null) {
      if (json.runtimeType == List) {
        return null;
      } else {
        return json;
      }
    } else {
      return null;
    }
  }
}

class Description {
  String? text;
  List<String>? included;
  List<String>? excluded;

  Description({this.text, this.included, this.excluded});

  Description.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    included = json['included'].cast<String>();
    excluded = json['excluded'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['included'] = included;
    data['excluded'] = excluded;
    return data;
  }
}
