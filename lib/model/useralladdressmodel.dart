class UserAllAddressModel {
  int? errorCode;
  List<Data>? data;
  bool? toast;
  String? message;

  UserAllAddressModel({this.errorCode, this.data, this.toast, this.message});

  UserAllAddressModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    toast = json['toast'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['toast'] = this.toast;
    data['message'] = this.message;
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['is_selected'] = this.isSelected;
    data['title'] = this.title;
    data['landmark'] = this.landmark;
    data['address_line_1'] = this.addressLine1;
    data['city'] = this.city;
    data['contact_number'] = this.contactNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['_id'] = this.sId;
    return data;
  }
}
