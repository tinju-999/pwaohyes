class MyqpadShopsModel {
  bool? status;
  int? statusCode;
  List<MyQShopsData>? data;
  int? count;
  int? pages;
  Pagination? pagination;
  String? message;

  MyqpadShopsModel(
      {this.status,
      this.statusCode,
      this.data,
      this.count,
      this.pages,
      this.pagination,
      this.message});

  MyqpadShopsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <MyQShopsData>[];
      json['data'].forEach((v) {
        data!.add(MyQShopsData.fromJson(v));
      });
    }
    count = json['count'];
    pages = json['pages'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['pages'] = pages;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class MyQShopsData {
  String? sId;
  List<double>? location;
  bool? isVerified;
  int? averageRating;
  int? totalRating;
  int? noOfCustomers;
  int? documentsUploaded;
  List<Null>? images;
  String? onlineStatus;
  String? status;
  int? phoneNo;
  UserId? userId;
  BusinessCategory? businessCategory;
  String? createDate;
  String? updateDate;
  int? iV;
  String? addressLine1;
  String? addressLine2;
  String? businessName;
  String? cityName;
  int? pincode;
  String? uniqueCode;
  String? businessBoard;
  String? vistingCard;
  String? logo;
  OhyesData? ohyesData;
  String? businessCategoryName;
  List<String>? serviceCategoryName;
  int? distance;

  MyQShopsData(
      {this.sId,
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
      this.ohyesData,
      this.businessCategoryName,
      this.serviceCategoryName,
      this.distance});

  MyQShopsData.fromJson(Map<String, dynamic> json) {
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
    ohyesData = json['ohyes_data'] != null
        ? OhyesData.fromJson(json['ohyes_data'])
        : null;
    businessCategoryName = json['business_category_name'];
    serviceCategoryName = json['service_category_name'].cast<String>();
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (ohyesData != null) {
      data['ohyes_data'] = ohyesData!.toJson();
    }
    data['business_category_name'] = businessCategoryName;
    data['service_category_name'] = serviceCategoryName;
    data['distance'] = distance;
    return data;
  }
}

class UserId {
  String? sId;
  String? userType;
  String? phoneNo;
  bool? isPasswordChanged;
  bool? isVerified;
  int? level;
  bool? verificationStatus;
  OhyesData? ohyesData;
  List<Null>? location;
  String? completionStatus;
  String? status;
  String? createDate;
  String? updateDate;
  int? iV;
  String? emailId;
  String? userName;

  UserId(
      {this.sId,
      this.userType,
      this.phoneNo,
      this.isPasswordChanged,
      this.isVerified,
      this.level,
      this.verificationStatus,
      this.ohyesData,
      this.location,
      this.completionStatus,
      this.status,
      this.createDate,
      this.updateDate,
      this.iV,
      this.emailId,
      this.userName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    isPasswordChanged = json['is_password_changed'];
    isVerified = json['is_verified'];
    level = json['level'];
    verificationStatus = json['verification_status'];
    ohyesData = json['ohyes_data'] != null
        ? OhyesData.fromJson(json['ohyes_data'])
        : null;
    // if (json['location'] != null) {
    //   location = <Null>[];
    //   json['location'].forEach((v) {
    //     location!.add(new Null.fromJson(v));
    //   });
    // }
    completionStatus = json['completion_status'];
    status = json['status'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    emailId = json['email_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_type'] = userType;
    data['phone_no'] = phoneNo;
    data['is_password_changed'] = isPasswordChanged;
    data['is_verified'] = isVerified;
    data['level'] = level;
    data['verification_status'] = verificationStatus;
    if (ohyesData != null) {
      data['ohyes_data'] = ohyesData!.toJson();
    }
    // if (this.location != null) {
    //   data['location'] = this.location!.map((v) => v.toJson()).toList();
    // }
    data['completion_status'] = completionStatus;
    data['status'] = status;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['email_id'] = emailId;
    data['user_name'] = userName;
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

class BusinessCategory {
  String? sId;
  bool? visibleToPartnerOnly;
  String? status;
  String? addedBy;
  String? businessName;
  String? sortingOrder;
  String? description;
  String? uniqueCode;
  String? createDate;
  String? updateDate;
  int? iV;
  String? logo;

  BusinessCategory(
      {this.sId,
      this.visibleToPartnerOnly,
      this.status,
      this.addedBy,
      this.businessName,
      this.sortingOrder,
      this.description,
      this.uniqueCode,
      this.createDate,
      this.updateDate,
      this.iV,
      this.logo});

  BusinessCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
    status = json['status'];
    addedBy = json['added_by'];
    businessName = json['business_name'];
    sortingOrder = json['sorting_order'];
    description = json['description'];
    uniqueCode = json['unique_code'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['visible_to_partner_only'] = visibleToPartnerOnly;
    data['status'] = status;
    data['added_by'] = addedBy;
    data['business_name'] = businessName;
    data['sorting_order'] = sortingOrder;
    data['description'] = description;
    data['unique_code'] = uniqueCode;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['logo'] = logo;
    return data;
  }
}

class Pagination {
  int? totalLength;
  int? pageNo;
  int? limit;

  Pagination({this.totalLength, this.pageNo, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalLength = json['total_length'];
    pageNo = json['pageNo'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_length'] = totalLength;
    data['pageNo'] = pageNo;
    data['limit'] = limit;
    return data;
  }
}
