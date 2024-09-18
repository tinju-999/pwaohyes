class CitiesModel {
  int? errorCode;
  List<CityData>? data;
  bool? toast;
  String? message;

  CitiesModel({this.errorCode, this.data, this.toast, this.message});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
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

class CityData {
  Location? location;
  String? sId;
  String? name;
  bool? isAvailable;
  String? lat;
  String? lng;
  String? icon;

  CityData(
      {this.location,
      this.sId,
      this.name,
      this.isAvailable,
      this.lat,
      this.lng,
      this.icon});

  CityData.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    isAvailable = json['is_available'];
    lat = json['lat'];
    lng = json['lng'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['is_available'] = isAvailable;
    data['lat'] = lat;
    data['lng'] = lng;
    data['icon'] = icon;
    return data;
  }
}

class Location {
  String? type;
  List<List>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = <List>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v).toList();
    }
    return data;
  }
}
