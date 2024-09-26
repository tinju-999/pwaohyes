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
        data!.add(Data.fromJson(v));
      });
    }
    toast = json['toast'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['toast'] = toast;
    data['message'] = message;
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
