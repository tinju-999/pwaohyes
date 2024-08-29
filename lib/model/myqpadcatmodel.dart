class MyqpadCategoryModel {
  bool? status;
  int? statusCode;
  String? message;
  MyqpadCatData? data;

  MyqpadCategoryModel({this.status, this.statusCode, this.message, this.data});

  MyqpadCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? MyqpadCatData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyqpadCatData {
  List<CateoryList>? cateoryList;
  Pagination? pagination;

  MyqpadCatData({this.cateoryList, this.pagination});

  MyqpadCatData.fromJson(Map<String, dynamic> json) {
    if (json['cateoryList'] != null) {
      cateoryList = <CateoryList>[];
      json['cateoryList'].forEach((v) {
        cateoryList!.add(CateoryList.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cateoryList != null) {
      data['cateoryList'] = cateoryList!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class CateoryList {
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
  bool? isSelected;
  int? iV;
  String? logo;

  CateoryList(
      {this.sId,
      this.visibleToPartnerOnly,
      this.status,
      this.addedBy,
      this.isSelected,
      this.businessName,
      this.sortingOrder,
      this.description,
      this.uniqueCode,
      this.createDate,
      this.updateDate,
      this.iV,
      this.logo});

  CateoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    visibleToPartnerOnly = json['visible_to_partner_only'];
    status = json['status'];
    isSelected = false;
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
