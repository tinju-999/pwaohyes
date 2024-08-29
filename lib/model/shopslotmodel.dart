class ShopSlotModel {
  bool? status;
  List<ShopSlotModelData>? data;
  ServiceInfo? serviceInfo;
  String? message;

  ShopSlotModel({this.status, this.data, this.serviceInfo, this.message});

  ShopSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ShopSlotModelData>[];
      json['data'].forEach((v) {
        data!.add(ShopSlotModelData.fromJson(v));
      });
    }
    serviceInfo = json['service_info'] != null
        ? ServiceInfo.fromJson(json['service_info'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (serviceInfo != null) {
      data['service_info'] = serviceInfo!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ShopSlotModelData {
  String? sId;
  int? noOfSlots;
  String? status;
  String? partnerId;
  String? serviceId;
  String? businessCategory;
  String? serviceCategoryId;
  String? slotStartTime;
  String? slotEndTime;
  String? createDate;
  String? updateDate;
  int? iV;
  bool? isAvailable;

  ShopSlotModelData(
      {this.sId,
      this.noOfSlots,
      this.status,
      this.partnerId,
      this.serviceId,
      this.businessCategory,
      this.serviceCategoryId,
      this.slotStartTime,
      this.slotEndTime,
      this.createDate,
      this.updateDate,
      this.iV,
      this.isAvailable});

  ShopSlotModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    noOfSlots = json['no_of_slots'];
    status = json['status'];
    partnerId = json['partner_id'];
    serviceId = json['service_id'];
    businessCategory = json['business_category'];
    serviceCategoryId = json['service_category_id'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['no_of_slots'] = noOfSlots;
    data['status'] = status;
    data['partner_id'] = partnerId;
    data['service_id'] = serviceId;
    data['business_category'] = businessCategory;
    data['service_category_id'] = serviceCategoryId;
    data['slot_start_time'] = slotStartTime;
    data['slot_end_time'] = slotEndTime;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['is_available'] = isAvailable;
    return data;
  }
}

class ServiceInfo {
  List<Null>? isDaywise;
  String? sId;
  int? amount;
  int? discountAmount;
  int? taxPercentage;
  List<String>? availableDays;
  bool? serviceShowToCustomers;
  int? averageRating;
  int? totalRating;
  String? slotType;
  String? status;
  String? userId;
  String? partnerId;
  ServiceCategoryId? serviceCategoryId;
  String? businessCategory;
  String? description;
  String? createDate;
  String? updateDate;
  int? iV;

  ServiceInfo(
      {this.isDaywise,
      this.sId,
      this.amount,
      this.discountAmount,
      this.taxPercentage,
      this.availableDays,
      this.serviceShowToCustomers,
      this.averageRating,
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

  ServiceInfo.fromJson(Map<String, dynamic> json) {
    // if (json['isDaywise'] != null) {
    //   isDaywise = <Null>[];
    //   json['isDaywise'].forEach((v) {
    //     isDaywise!.add(new Null.fromJson(v));
    //   });
    // }
    sId = json['_id'];
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
    // if (this.isDaywise != null) {
    //   data['isDaywise'] = this.isDaywise!.map((v) => v.toJson()).toList();
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
  int? sortingOrder;
  bool? visibleToPartnerOnly;
  String? status;
  String? businessCategory;
  String? serviceName;
  String? description;
  String? createDate;
  String? updateDate;
  int? iV;
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
