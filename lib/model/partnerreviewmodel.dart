class PartnerReviewModel {
  bool? status;
  List<PartnerReviewData>? data;
  PartnerDetails? partnerDetails;
  // PaginationDetails? paginationDetails;
  String? message;

  PartnerReviewModel(
      {this.status,
      this.data,
      this.partnerDetails,
      // this.paginationDetails,
      this.message});

  PartnerReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PartnerReviewData>[];
      json['data'].forEach((v) {
        data!.add(PartnerReviewData.fromJson(v));
      });
    }
    partnerDetails = json['partnerDetails'] != null
        ? PartnerDetails.fromJson(json['partnerDetails'])
        : null;
    // paginationDetails = json['pagination_details'] != null
    //     ? PaginationDetails.fromJson(json['pagination_details'])
    //     : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (partnerDetails != null) {
      data['partnerDetails'] = partnerDetails!.toJson();
    }
    // if (paginationDetails != null) {
    //   data['pagination_details'] = paginationDetails!.toJson();
    // }
    data['message'] = message;
    return data;
  }
}

class PartnerReviewData {
  String? sId;
  String? customerName;
  double? rating;
  String? review;
  String? createDate;

  PartnerReviewData(
      {this.sId, this.customerName, this.rating, this.review, this.createDate});

  PartnerReviewData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerName = json['customerName'];
    rating = json['rating'];
    review = json['review'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerName'] = customerName;
    data['rating'] = rating;
    data['review'] = review;
    data['create_date'] = createDate;
    return data;
  }
}

class PartnerDetails {
  OhyesData? ohyesData;
  String? sId;
  List<double>? location;
  bool? isVerified;
  double? averageRating;
  int? totalRating;
  int? documentsUploaded;
  // List<Null>? images;
  String? onlineStatus;
  String? status;
  int? phoneNo;
  String? userId;
  String? businessCategory;
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
  int? noOfCustomers;
  String? businessCategoryName;
  List<String>? serviceCategoryName;
  bool? isGreetingsSend;
  String? lastLoginTime;
  int? loginCount;
  String? logo;
  String? vistingCard;

  PartnerDetails(
      {this.ohyesData,
      this.sId,
      this.location,
      this.isVerified,
      this.averageRating,
      this.totalRating,
      this.documentsUploaded,
      // this.images,
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
      this.noOfCustomers,
      this.businessCategoryName,
      this.serviceCategoryName,
      this.isGreetingsSend,
      this.lastLoginTime,
      this.loginCount,
      this.logo,
      this.vistingCard});

  PartnerDetails.fromJson(Map<String, dynamic> json) {
    ohyesData = json['ohyes_data'] != null
        ? OhyesData.fromJson(json['ohyes_data'])
        : null;
    sId = json['_id'];
    location = json['location'].cast<double>();
    isVerified = json['is_verified'];
    averageRating = json['average_rating'];
    totalRating = json['total_rating'];
    documentsUploaded = json['documents_uploaded'];
    // if (json['images'] != null) {
    //   images = <Null>[];
    //   json['images'].forEach((v) {
    //     images!.add(Null.fromJson(v));
    //   });
    // }
    onlineStatus = json['online_status'];
    status = json['status'];
    phoneNo = json['phone_no'];
    userId = json['userId'];
    businessCategory = json['business_category'];
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
    noOfCustomers = json['no_of_customers'];
    businessCategoryName = json['business_category_name'];
    serviceCategoryName = json['service_category_name'].cast<String>();
    isGreetingsSend = json['is_greetings_send'];
    lastLoginTime = json['last_login_time'];
    loginCount = json['loginCount'];
    logo = json['logo'];
    vistingCard = json['visting_card'];
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
    data['documents_uploaded'] = documentsUploaded;
    // if (images != null) {
    //   data['images'] = images!.map((v) => v.toJson()).toList();
    // }
    data['online_status'] = onlineStatus;
    data['status'] = status;
    data['phone_no'] = phoneNo;
    data['userId'] = userId;
    data['business_category'] = businessCategory;
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
    data['no_of_customers'] = noOfCustomers;
    data['business_category_name'] = businessCategoryName;
    data['service_category_name'] = serviceCategoryName;
    data['is_greetings_send'] = isGreetingsSend;
    data['last_login_time'] = lastLoginTime;
    data['loginCount'] = loginCount;
    data['logo'] = logo;
    data['visting_card'] = vistingCard;
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

class PaginationDetails {
  int? totalLength;
  int? pageNo;
  int? limit;

  PaginationDetails({this.totalLength, this.pageNo, this.limit});

  PaginationDetails.fromJson(Map<String, dynamic> json) {
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
