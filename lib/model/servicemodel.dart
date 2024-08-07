class ServiceModel {
  int? errorCode;
  Data? data;
  bool? toast;
  String? message;

  ServiceModel({this.errorCode, this.data, this.toast, this.message});

  ServiceModel.fromJson(Map<String, dynamic> json) {
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
  bool? lastPage;
  bool? showReview;
  List<Content>? content;

  Data({this.lastPage, this.showReview, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    lastPage = json['last_page'];
    showReview = json['show_review'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_page'] = lastPage;
    data['show_review'] = showReview;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? type;
  List<Null>? sliderItems;
  String? title;
  List<CategoryItems>? categoryItems;
  List<Videos>? videos;
  List<ServiceItems>? serviceItems;

  Content(
      {this.type,
      this.sliderItems,
      this.title,
      this.categoryItems,
      this.videos,
      this.serviceItems});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    // if (json['slider_items'] != null) {
    //   sliderItems = <Null>[];
    //   json['slider_items'].forEach((v) {
    //     sliderItems!.add(Null.fromJson(v));
    //   });
    // }
    title = json['title'];
    if (json['category_items'] != null) {
      categoryItems = <CategoryItems>[];
      json['category_items'].forEach((v) {
        categoryItems!.add(CategoryItems.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
    if (json['service_items'] != null) {
      serviceItems = <ServiceItems>[];
      json['service_items'].forEach((v) {
        serviceItems!.add(ServiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    // if (sliderItems != null) {
    //   data['slider_items'] = sliderItems!.map((v) => v.toJson()).toList();
    // }
    data['title'] = title;
    if (categoryItems != null) {
      data['category_items'] = categoryItems!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    if (serviceItems != null) {
      data['service_items'] = serviceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItems {
  String? sId;
  String? name;
  String? image;
  int? iV;
  List<String>? cities;
  String? status;
  bool? visibleToPartnerOnly;

  CategoryItems(
      {this.sId,
      this.name,
      this.image,
      this.iV,
      this.cities,
      this.status,
      this.visibleToPartnerOnly});

  CategoryItems.fromJson(Map<String, dynamic> json) {
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

class Videos {
  String? sId;
  String? title;
  String? subTitle;
  String? description;
  String? url;
  String? platform;
  String? createdAt;
  int? iV;
  String? productId;
  String? thumbnail;

  Videos(
      {this.sId,
      this.title,
      this.subTitle,
      this.description,
      this.url,
      this.platform,
      this.createdAt,
      this.iV,
      this.productId,
      this.thumbnail});

  Videos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    url = json['url'];
    platform = json['platform'];
    createdAt = json['created_at'];
    iV = json['__v'];
    productId = json['product_id'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['description'] = description;
    data['url'] = url;
    data['platform'] = platform;
    data['created_at'] = createdAt;
    data['__v'] = iV;
    data['product_id'] = productId;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class ServiceItems {
  String? sId;
  String? title;
  List<Null>? tag;
  Description? description;
  List<Null>? videoMetadata;
  String? categoryId;
  String? image;
  int? price;

  ServiceItems(
      {this.sId,
      this.title,
      this.tag,
      this.description,
      this.videoMetadata,
      this.categoryId,
      this.image,
      this.price});

  ServiceItems.fromJson(Map<String, dynamic> json) {
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
    image = json['image'];
    price = json['price'];
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
    data['price'] = price;
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
