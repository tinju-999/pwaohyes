class ServiceDetailedModel {
  int? errorCode;
  Data? data;
  bool? toast;
  String? message;

  ServiceDetailedModel({this.errorCode, this.data, this.toast, this.message});

  ServiceDetailedModel.fromJson(Map<String, dynamic> json) {
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
  Service? service;
  List<ServiceTypes>? serviceTypes;

  Data({this.service, this.serviceTypes});

  Data.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['serviceTypes'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['serviceTypes'].forEach((v) {
        serviceTypes!.add(ServiceTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (serviceTypes != null) {
      data['serviceTypes'] = serviceTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  Description? description;
  String? sId;
  String? title;
  // List<Null>? tag;
  // List<Null>? videoMetadata;
  CategoryId? categoryId;
  List<String>? image;
  int? iV;
  List<String>? cities;
  String? status;
  bool? visibleToPartnerOnly;

  Service(
      {this.description,
      this.sId,
      this.title,
      // this.tag,
      // this.videoMetadata,
      this.categoryId,
      this.image,
      this.iV,
      this.cities,
      this.status,
      this.visibleToPartnerOnly});

  Service.fromJson(Map<String, dynamic> json) {
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    sId = json['_id'];
    title = json['title'];
    // if (json['tag'] != null) {
    //   tag = <Null>[];
    //   json['tag'].forEach((v) {
    //     tag!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['video_metadata'] != null) {
    //   videoMetadata = <Null>[];
    //   json['video_metadata'].forEach((v) {
    //     videoMetadata!.add(new Null.fromJson(v));
    //   });
    // }
    categoryId = json['category_id'] != null
        ? CategoryId.fromJson(json['category_id'])
        : null;
    image = json['image'].cast<String>();
    iV = json['__v'];
    cities = json['cities'].cast<String>();
    status = json['status'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    // if (this.tag != null) {
    //   data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    // }
    // if (this.videoMetadata != null) {
    //   data['video_metadata'] =
    //       this.videoMetadata!.map((v) => v.toJson()).toList();
    // }
    if (categoryId != null) {
      data['category_id'] = categoryId!.toJson();
    }
    data['image'] = image;
    data['__v'] = iV;
    data['cities'] = cities;
    data['status'] = status;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    return data;
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

class CategoryId {
  String? sId;
  String? name;
  String? image;
  int? iV;
  List<String>? cities;
  String? status;
  bool? visibleToPartnerOnly;

  CategoryId(
      {this.sId,
      this.name,
      this.image,
      this.iV,
      this.cities,
      this.status,
      this.visibleToPartnerOnly});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    iV = json['__v'];
    cities = json['cities'].cast<String>();
    status = json['status'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['__v'] = iV;
    data['cities'] = cities;
    data['status'] = status;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    return data;
  }
}

class ServiceTypes {
  String? sId;
  String? name;
  bool? isSelected;
  String? price;
  String? currency;
  int? iV;
  int? commission;
  String? image;
  String? status;
  bool? visibleToPartnerOnly;
  List<String>? cities;

  ServiceTypes(
      {this.sId,
      this.name,
      this.isSelected,
      this.price,
      this.currency,
      this.iV,
      this.commission,
      this.image,
      this.status,
      this.visibleToPartnerOnly,
      this.cities});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isSelected = json['is_selected'];
    price = json['price'];
    currency = json['currency'];
    iV = json['__v'];
    commission = json['commission'];
    image = json['image'];
    status = json['status'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['is_selected'] = isSelected;
    data['price'] = price;
    data['currency'] = currency;
    data['__v'] = iV;
    data['commission'] = commission;
    data['image'] = image;
    data['status'] = status;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    data['cities'] = cities;
    return data;
  }
}
