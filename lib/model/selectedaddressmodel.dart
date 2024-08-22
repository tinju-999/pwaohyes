import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/provider/provider.dart';

class SelectedAddressModel {
  LatLng? latLng;
  LoadingState? loadingState;
  String? locationName, cityId;
  SelectedAddressModel({
    this.latLng,
    this.locationName,
    this.cityId,
    this.loadingState = LoadingState.initial,
  });

  factory SelectedAddressModel.fromJson(Map<String, dynamic> json) {
    return SelectedAddressModel(
      locationName: json['locationName'],
      cityId: json['cityId'],
      loadingState: LoadingState.values.firstWhere((e)=> e.name == json['loadingState']),
      latLng: json['latLng'] != null ? LatLng.fromJson(json['latLng']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName,
      'loadingState': loadingState!.name,
      'cityId': cityId,
      'latLng': latLng?.toJson(),
    };
  }
}
