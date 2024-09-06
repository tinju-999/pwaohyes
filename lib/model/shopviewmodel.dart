class ShopViewModel {
  bool? status;
  num? statusCode;
  ShopViewModelData? data;
  // List<Null>? users;
  List<Services>? services;
  String? message;

  ShopViewModel(
      {this.status,
      this.statusCode,
      this.data,
      // this.users,
      this.services,
      this.message});

  ShopViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    data =
        json['data'] != null ? ShopViewModelData.fromJson(json['data']) : null;
    // if (json['users'] != null) {
    //   users = <Null>[];
    //   json['users'].forEach((v) {
    //     users!.add(Null.fromJson(v));
    //   });
    // }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    // if (users != null) {
    //   data['users'] = users!.map((v) => v.toJson()).toList();
    // }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ShopViewModelData {
  OhyesData? ohyesData;
  String? sId;
  List<double>? location;
  bool? isVerified;
  num? averageRating;
  num? totalRating;
  num? noOfCustomers;
  num? documentsUploaded;
  List<Null>? images;
  String? onlineStatus;
  String? status;
  num? phoneNo;
  UserId? userId;
  BusinessCategory? businessCategory;
  String? createDate;
  String? updateDate;
  num? iV;
  String? addressLine1;
  String? addressLine2;
  String? businessName;
  String? cityName;
  num? pincode;
  String? uniqueCode;
  String? businessBoard;
  String? vistingCard;
  String? logo;
  String? businessCategoryName;
  List<String>? serviceCategoryName;

  ShopViewModelData(
      {this.ohyesData,
      this.sId,
      this.location,
      this.isVerified,
      this.averageRating,
      this.totalRating,
      this.noOfCustomers,
      this.documentsUploaded,
      this.images,
      this.onlineStatus,
      this.status,
      this.phoneNo,
      this.userId,
      this.businessCategory,
      this.createDate,
      this.updateDate,
      this.iV,
      this.addressLine1,
      this.addressLine2,
      this.businessName,
      this.cityName,
      this.pincode,
      this.uniqueCode,
      this.businessBoard,
      this.vistingCard,
      this.logo,
      this.businessCategoryName,
      this.serviceCategoryName});

  ShopViewModelData.fromJson(Map<String, dynamic> json) {
    ohyesData = json['ohyes_data'] != null
        ? OhyesData.fromJson(json['ohyes_data'])
        : null;
    sId = json['_id'];
    location = json['location'].cast<double>();
    isVerified = json['is_verified'];
    averageRating = json['average_rating'];
    totalRating = json['total_rating'];
    noOfCustomers = json['no_of_customers'];
    documentsUploaded = json['documents_uploaded'];
    // if (json['images'] != null) {
    //   images = <Null>[];
    //   json['images'].forEach((v) {
    //     images!.add(new Null.fromJson(v));
    //   });
    // }
    onlineStatus = json['online_status'];
    status = json['status'];
    phoneNo = json['phone_no'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    businessCategory = json['business_category'] != null
        ? BusinessCategory.fromJson(json['business_category'])
        : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    businessName = json['business_name'];
    cityName = json['city_name'];
    pincode = json['pincode'];
    uniqueCode = json['unique_code'];
    businessBoard = json['business_board'];
    vistingCard = json['visting_card'];
    logo = json['logo'];
    businessCategoryName = json['business_category_name'];
    serviceCategoryName = json['service_category_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ohyesData != null) {
      data['ohyes_data'] = ohyesData!.toJson();
    }
    data['_id'] = sId;
    data['location'] = location;
    data['is_verified'] = isVerified;
    data['average_rating'] = averageRating;
    data['total_rating'] = totalRating;
    data['no_of_customers'] = noOfCustomers;
    data['documents_uploaded'] = documentsUploaded;
    // if (this.images != null) {
    //   data['images'] = this.images!.map((v) => v.toJson()).toList();
    // }
    data['online_status'] = onlineStatus;
    data['status'] = status;
    data['phone_no'] = phoneNo;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (businessCategory != null) {
      data['business_category'] = businessCategory!.toJson();
    }
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['business_name'] = businessName;
    data['city_name'] = cityName;
    data['pincode'] = pincode;
    data['unique_code'] = uniqueCode;
    data['business_board'] = businessBoard;
    data['visting_card'] = vistingCard;
    data['logo'] = logo;
    data['business_category_name'] = businessCategoryName;
    data['service_category_name'] = serviceCategoryName;
    return data;
  }
}

class OhyesData {
  bool? isValidated;
  Null errorMessage;
  bool? isInsideCity;
  String? dataType;
  String? data;
  String? cityId;
  String? cityMyqpadId;

  OhyesData(
      {this.isValidated,
      this.errorMessage,
      this.isInsideCity,
      this.dataType,
      this.data,
      this.cityId,
      this.cityMyqpadId});

  OhyesData.fromJson(Map<String, dynamic> json) {
    isValidated = json['is_validated'];
    errorMessage = json['error_message'];
    isInsideCity = json['is_inside_city'];
    dataType = json['data_type'];
    data = json['data'];
    cityId = json['city_id'];
    cityMyqpadId = json['city_myqpad_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_validated'] = isValidated;
    data['error_message'] = errorMessage;
    data['is_inside_city'] = isInsideCity;
    data['data_type'] = dataType;
    data['data'] = this.data;
    data['city_id'] = cityId;
    data['city_myqpad_id'] = cityMyqpadId;
    return data;
  }
}

class UserId {
  String? sId;
  String? userType;
  String? phoneNo;
  num? level;
  String? emailId;
  String? userName;

  UserId(
      {this.sId,
      this.userType,
      this.phoneNo,
      this.level,
      this.emailId,
      this.userName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    level = json['level'];
    emailId = json['email_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_type'] = userType;
    data['phone_no'] = phoneNo;
    data['level'] = level;
    data['email_id'] = emailId;
    data['user_name'] = userName;
    return data;
  }
}

class BusinessCategory {
  String? sId;
  String? businessName;

  BusinessCategory({this.sId, this.businessName});

  BusinessCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['business_name'] = businessName;
    return data;
  }
}

class Services {
  List<Null>? isDaywise;
  String? sId;
  num? amount;
  bool? isSelected;
  num? discountAmount;
  num? taxPercentage;
  List<String>? availableDays;
  bool? serviceShowToCustomers;
  num? averageRating;
  num? totalRating;
  String? slotType;
  String? status;
  String? userId;
  String? partnerId;
  ServiceCategoryId? serviceCategoryId;
  String? businessCategory;
  String? description;
  String? createDate;
  String? updateDate;
  num? iV;

  Services(
      {this.isDaywise,
      this.sId,
      this.amount,
      this.discountAmount,
      this.taxPercentage,
      this.availableDays,
      this.serviceShowToCustomers,
      this.averageRating,
      this.isSelected,
      this.totalRating,
      this.slotType,
      this.status,
      this.userId,
      this.partnerId,
      this.serviceCategoryId,
      this.businessCategory,
      this.description,
      this.createDate,
      this.updateDate,
      this.iV});

  Services.fromJson(Map<String, dynamic> json) {
    // if (json['isDaywise'] != null) {
    //   isDaywise = <Null>[];
    //   json['isDaywise'].forEach((v) {
    //     isDaywise!.add(new Null.fromJson(v));
    //   });
    // }
    sId = json['_id'];
    isSelected = false;
    amount = json['amount'];
    discountAmount = json['discount_amount'];
    taxPercentage = json['tax_percentage'];
    availableDays = json['available_days'].cast<String>();
    serviceShowToCustomers = json['service_show_to_customers'];
    averageRating = json['average_rating'];
    totalRating = json['total_rating'];
    slotType = json['slot_type'];
    status = json['status'];
    userId = json['user_id'];
    partnerId = json['partner_id'];
    serviceCategoryId = json['service_category_id'] != null
        ? ServiceCategoryId.fromJson(json['service_category_id'])
        : null;
    businessCategory = json['business_category'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (isDaywise != null) {
    //   data['isDaywise'] = isDaywise!.map((v) => v.toJson()).toList();
    // }
    data['_id'] = sId;
    data['amount'] = amount;
    data['discount_amount'] = discountAmount;
    data['tax_percentage'] = taxPercentage;
    data['available_days'] = availableDays;
    data['service_show_to_customers'] = serviceShowToCustomers;
    data['average_rating'] = averageRating;
    data['total_rating'] = totalRating;
    data['slot_type'] = slotType;
    data['status'] = status;
    data['user_id'] = userId;
    data['partner_id'] = partnerId;
    if (serviceCategoryId != null) {
      data['service_category_id'] = serviceCategoryId!.toJson();
    }
    data['business_category'] = businessCategory;
    data['description'] = description;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
  }
}

class ServiceCategoryId {
  String? sId;
  String? isUpdated;
  num? sortingOrder;
  bool? visibleToPartnerOnly;
  String? status;
  String? businessCategory;
  String? serviceName;
  String? description;
  String? createDate;
  String? updateDate;
  num? iV;
  String? photo;

  ServiceCategoryId(
      {this.sId,
      this.isUpdated,
      this.sortingOrder,
      this.visibleToPartnerOnly,
      this.status,
      this.businessCategory,
      this.serviceName,
      this.description,
      this.createDate,
      this.updateDate,
      this.iV,
      this.photo});

  ServiceCategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isUpdated = json['is_updated'];
    sortingOrder = json['sorting_order'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
    status = json['status'];
    businessCategory = json['business_category'];
    serviceName = json['service_name'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_updated'] = isUpdated;
    data['sorting_order'] = sortingOrder;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    data['status'] = status;
    data['business_category'] = businessCategory;
    data['service_name'] = serviceName;
    data['description'] = description;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['photo'] = photo;
    return data;
  }
}
