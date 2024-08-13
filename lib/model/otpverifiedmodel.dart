class OtpVerifiedModel {
  int? errorCode;
  Data? data;
  bool? toast;
  String? message;

  OtpVerifiedModel({this.errorCode, this.data, this.toast, this.message});

  OtpVerifiedModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? refreshToken;
  bool? isRegistered;
  LocationSelected? locationSelected;

  Data(
      {this.accessToken,
      this.refreshToken,
      this.isRegistered,
      this.locationSelected});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    isRegistered = json['is_registered'];
    locationSelected = json['location_selected'] != null
        ? LocationSelected.fromJson(json['location_selected'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['is_registered'] = isRegistered;
    if (locationSelected != null) {
      data['location_selected'] = locationSelected!.toJson();
    }
    return data;
  }
}

class LocationSelected {
  double? latitude;
  double? longitude;
  String? name;
  String? sId;

  LocationSelected({this.latitude, this.longitude, this.name, this.sId});

  LocationSelected.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['_id'] = sId;
    return data;
  }
}
