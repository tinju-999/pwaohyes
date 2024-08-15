import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/provider/provider.dart';

class SelectedAddressModel {
  LatLng? latLng;
  LoadingState? state;
  String? locationName;
  SelectedAddressModel({this.latLng, this.locationName, this.state});

  factory SelectedAddressModel.fromJson(Map<String, dynamic> json) {
    return SelectedAddressModel(
      locationName: json['locationName'],
      latLng: json['latLng'] != null ? LatLng.fromJson(json['latLng']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName,
      'latLng': latLng?.toJson(),
    };
  }
}
