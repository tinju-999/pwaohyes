class SelectedServiceDetailsModel {
  dynamic errorCode;
  Data? data;
  bool? toast;
  String? message;

  SelectedServiceDetailsModel(
      {this.errorCode, this.data, this.toast, this.message});

  SelectedServiceDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic debug;
  bool? imageUpload;
  bool? description;
  bool? technicianAvailable;
  dynamic rewardPointsLimit;
  String? today;
  Days? days;
  List<PaymentInfo>? paymentInfo;
  String? discountText;
  String? note;
  Address? address;
  bool? isAddressSelected;
  bool? isServiceAvailable;
  List<ServicePartners>? servicePartners;

  Data(
      {this.debug,
      this.imageUpload,
      this.description,
      this.technicianAvailable,
      this.rewardPointsLimit,
      this.today,
      this.days,
      this.paymentInfo,
      this.discountText,
      this.note,
      this.address,
      this.isAddressSelected,
      this.isServiceAvailable,
      this.servicePartners});

  Data.fromJson(Map<String, dynamic> json) {
    debug = json['debug'];
    imageUpload = json['image_upload'];
    description = json['description'];
    technicianAvailable = json['technician_available'];
    rewardPointsLimit = json['reward_points_limit'];
    today = json['today'];
    days = json['days'] != null ? Days.fromJson(json['days']) : null;
    if (json['payment_info'] != null) {
      paymentInfo = <PaymentInfo>[];
      json['payment_info'].forEach((v) {
        paymentInfo!.add(PaymentInfo.fromJson(v));
      });
    }
    discountText = json['discount_text'];
    note = json['note'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    isAddressSelected = json['is_address_selected'];
    isServiceAvailable = json['is_service_available'];
    if (json['service_partners'] != null) {
      servicePartners = <ServicePartners>[];
      json['service_partners'].forEach((v) {
        servicePartners!.add(ServicePartners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['debug'] = debug;
    data['image_upload'] = imageUpload;
    data['description'] = description;
    data['technician_available'] = technicianAvailable;
    data['reward_points_limit'] = rewardPointsLimit;
    data['today'] = today;
    if (days != null) {
      data['days'] = days!.toJson();
    }
    if (paymentInfo != null) {
      data['payment_info'] = paymentInfo!.map((v) => v.toJson()).toList();
    }
    data['discount_text'] = discountText;
    data['note'] = note;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['is_address_selected'] = isAddressSelected;
    data['is_service_available'] = isServiceAvailable;
    if (servicePartners != null) {
      data['service_partners'] =
          servicePartners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? startDate;
  String? endDate;

  Days({this.startDate, this.endDate});

  Days.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

class PaymentInfo {
  String? title;
  dynamic value;

  PaymentInfo({this.title, this.value});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}

class Address {
  String? name;
  bool? isSelected;
  String? title;
  String? landmark;
  String? addressLine1;
  String? city;
  String? contactNumber;
  double? latitude;
  double? longitude;
  String? sId;

  Address(
      {this.name,
      this.isSelected,
      this.title,
      this.landmark,
      this.addressLine1,
      this.city,
      this.contactNumber,
      this.latitude,
      this.longitude,
      this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isSelected = json['is_selected'];
    title = json['title'];
    landmark = json['landmark'];
    addressLine1 = json['address_line_1'];
    city = json['city'];
    contactNumber = json['contact_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['is_selected'] = isSelected;
    data['title'] = title;
    data['landmark'] = landmark;
    data['address_line_1'] = addressLine1;
    data['city'] = city;
    data['contact_number'] = contactNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['_id'] = sId;
    return data;
  }
}

class ServicePartners {
  String? sId;
  String? phoneNumber;
  List<String>? categories;
  List<Null>? subCategories;
  List<Null>? videos;
  List<String>? photos;
  List<Null>? serviceHistory;
  LastLocationCoordinates? lastLocationCoordinates;
  List<Null>? reviews;
  double? rating;
  String? otp;
  bool? isOnline;
  String? lastStatusReported;
  String? aadharFront;
  String? aadharBack;
  String? aadharNumber;
  String? gstNo;
  bool? isRegistered;
  bool? documentUploaded;
  Null selectedCity;
  bool? isDocumentApproved;
  bool? isServiceApproved;
  bool? isPricingApproved;
  double? creditOverdue;
  List<String>? operatingCities;
  String? status;
  bool? isLive;
  List<ServiceTypes>? serviceTypes;
  List<Devices>? devices;
  // List<Null>? documents;
  dynamic iV;
  String? email;
  String? userName;
  String? addressLine1;
  String? addressLine2;
  // Availability? availability;
  String? city;
  String? pinCode;
  String? profilePicture;
  String? description;
  bool? isArchived;
  bool? isSelected;
  double? distance;
  // Null? currentDayAvailability;
  dynamic paidBookingCount;

  ServicePartners(
      {this.sId,
      this.phoneNumber,
      this.categories,
      this.subCategories,
      this.videos,
      this.photos,
      this.serviceHistory,
      this.lastLocationCoordinates,
      this.reviews,
      this.rating,
      this.isSelected,
      this.otp,
      this.isOnline,
      this.lastStatusReported,
      this.aadharFront,
      this.aadharBack,
      this.aadharNumber,
      this.gstNo,
      this.isRegistered,
      this.documentUploaded,
      this.selectedCity,
      this.isDocumentApproved,
      this.isServiceApproved,
      this.isPricingApproved,
      this.creditOverdue,
      this.operatingCities,
      this.status,
      this.isLive,
      this.serviceTypes,
      this.devices,
      this.iV,
      this.email,
      this.userName,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.pinCode,
      this.profilePicture,
      this.description,
      this.isArchived,
      this.distance,
      this.paidBookingCount});

  ServicePartners.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phone_number'];
    isSelected = false;
    categories = json['categories'].cast<String>();
    // if (json['sub_categories'] != null) {
    // 	subCategories = <Null>[];
    // 	json['sub_categories'].forEach((v) { subCategories!.add(new Null.fromJson(v)); });
    // }
    // if (json['videos'] != null) {
    // 	videos = <Null>[];
    // 	json['videos'].forEach((v) { videos!.add(new Null.fromJson(v)); });
    // }
    photos = json['photos'].cast<String>();
    // if (json['service_history'] != null) {
    // 	serviceHistory = <Null>[];
    // 	json['service_history'].forEach((v) { serviceHistory!.add(new Null.fromJson(v)); });
    // }
    lastLocationCoordinates = json['last_location_coordinates'] != null
        ? LastLocationCoordinates.fromJson(json['last_location_coordinates'])
        : null;
    // if (json['reviews'] != null) {
    // 	reviews = <Null>[];
    // 	json['reviews'].forEach((v) { reviews!.add(new Null.fromJson(v)); });
    // }
    rating = json['rating'];
    otp = json['otp'];
    isOnline = json['is_online'];
    lastStatusReported = json['last_status_reported'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    aadharNumber = json['aadhar_number'];
    gstNo = json['gst_no'];
    isRegistered = json['is_registered'];
    documentUploaded = json['document_uploaded'];
    selectedCity = json['selected_city'];
    isDocumentApproved = json['is_document_approved'];
    isServiceApproved = json['is_service_approved'];
    isPricingApproved = json['is_pricing_approved'];
    creditOverdue = json['credit_overdue'];
    operatingCities = json['operating_cities'].cast<String>();
    status = json['status'];
    isLive = json['is_live'];
    if (json['service_types'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['service_types'].forEach((v) {
        serviceTypes!.add(ServiceTypes.fromJson(v));
      });
    }
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(Devices.fromJson(v));
      });
    }
    // if (json['documents'] != null) {
    // 	documents = <Null>[];
    // 	json['documents'].forEach((v) { documents!.add(new Null.fromJson(v)); });
    // }
    iV = json['__v'];
    email = json['email'];
    userName = json['user_name'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    // availability = json['availability'] != null ? new Availability.fromJson(json['availability']) : null;
    city = json['city'];
    pinCode = json['pin_code'];
    profilePicture = json['profile_picture'];
    description = json['description'];
    isArchived = json['is_archived'];
    distance = json['distance'];
    // currentDayAvailability = json['current_day_availability'];
    paidBookingCount = json['paidBookingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone_number'] = phoneNumber;
    data['categories'] = categories;
    // if (this.subCategories != null) {
    //   data['sub_categories'] = this.subCategories!.map((v) => v.toJson()).toList();
    // }
    // if (this.videos != null) {
    //   data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    // }
    data['photos'] = photos;
    // if (this.serviceHistory != null) {
    //   data['service_history'] = this.serviceHistory!.map((v) => v.toJson()).toList();
    // }
    if (lastLocationCoordinates != null) {
      data['last_location_coordinates'] = lastLocationCoordinates!.toJson();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    data['rating'] = rating;
    data['otp'] = otp;
    data['is_online'] = isOnline;
    data['last_status_reported'] = lastStatusReported;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    data['aadhar_number'] = aadharNumber;
    data['gst_no'] = gstNo;
    data['is_registered'] = isRegistered;
    data['document_uploaded'] = documentUploaded;
    data['selected_city'] = selectedCity;
    data['is_document_approved'] = isDocumentApproved;
    data['is_service_approved'] = isServiceApproved;
    data['is_pricing_approved'] = isPricingApproved;
    data['credit_overdue'] = creditOverdue;
    data['operating_cities'] = operatingCities;
    data['status'] = status;
    data['is_live'] = isLive;
    if (serviceTypes != null) {
      data['service_types'] = serviceTypes!.map((v) => v.toJson()).toList();
    }
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    // if (this.documents != null) {
    //   data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    // }
    data['__v'] = iV;
    data['email'] = email;
    data['user_name'] = userName;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    // if (this.availability != null) {
    //   data['availability'] = this.availability!.toJson();
    // }
    data['city'] = city;
    data['pin_code'] = pinCode;
    data['profile_picture'] = profilePicture;
    data['description'] = description;
    data['is_archived'] = isArchived;
    data['distance'] = distance;
    // data['current_day_availability'] = this.currentDayAvailability;
    data['paidBookingCount'] = paidBookingCount;
    return data;
  }
}

class LastLocationCoordinates {
  String? type;
  List<double>? coordinates;

  LastLocationCoordinates({this.type, this.coordinates});

  LastLocationCoordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class ServiceTypes {
  String? serviceType;
  String? image;
  dynamic amount;
  String? sId;
  String? description;

  ServiceTypes(
      {this.serviceType, this.image, this.amount, this.sId, this.description});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
    serviceType = json['service_type'];
    image = json['image'];
    amount = json['amount'];
    sId = json['_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_type'] = serviceType;
    data['image'] = image;
    data['amount'] = amount;
    data['_id'] = sId;
    data['description'] = description;
    return data;
  }
}

class Devices {
  String? deviceType;
  String? deviceToken;
  String? sId;

  Devices({this.deviceType, this.deviceToken, this.sId});

  Devices.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['_id'] = sId;
    return data;
  }
}

// class Availability {


// 	Availability({});

// 	Availability.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }
