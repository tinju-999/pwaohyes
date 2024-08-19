import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';

class LocationBloc extends Cubit<LocationState> {
  LocationBloc() : super(LocationState());

  getLocation() async {
    try {
      emit(GettingLocation());
      Initializer.selectedAdddress = SelectedAddressModel();
      bool isGranted = await seekLocationPermission();
      if (!isGranted) {
        Helper.showCustomDialog(
            title: "Geolocation is blocked",
            content:
                "Looks like your geolocation permissions are blocked. Please, provide geolocation access in your browser settings.",
            oneButtonDisabled: true,
            actionTwo: () async {
              Helper.pop();
            },
            actionTwoText: "Ok");

        emit(LocationNotFetched());
      } else {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.medium)
            .then((position) async {
          Initializer.selectedAdddress = SelectedAddressModel(
              locationName: "LatLong",
              // state: LoadingState.success,
              latLng: LatLng(position.latitude, position.longitude));
          await Preferences.setLocation(
              jsonEncode(Initializer.selectedAdddress!.toJson()));
          emit(LocationFetched());
        });
      }
    } catch (e) {
      Helper.showLog("Location fetching error $e");
      emit(LocationFetchingError());
    }
  }

  Future<bool> seekLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
    // Completer<bool> completer = Completer<bool>();
    // LocationPermission permission = await Geolocator.checkPermission();
    // Helper.showLog('permission $permission');
    // // if (!permission. &&
    // //     !locationPermission.isPermanentlyDenied) {
    // //   locationPermission = await Permission.location.request();
    // //   if (!locationPermission.isGranted) {
    // //     locationPermission = await Permission.location.request();
    // //     if (!locationPermission.isGranted) {
    // //       locationPermission = await Permission.location.request();
    // //       if (locationPermission.isPermanentlyDenied) {
    // //         completer.complete(false);
    // //       } else if (locationPermission.isGranted) {
    // //         completer.complete(true);
    // //       }
    // //     } else {
    // //       completer.complete(true);
    // //     }
    // //   } else {
    // //     completer.complete(true);
    // //   }
    // // } else {
    // //   if (locationPermission.isGranted) {
    // //     completer.complete(true);
    // //   } else {
    // //     completer.complete(false);
    // //   }
    // // }
    // return completer.future;
  }
}

class LocationState {}

class GettingLocation extends LocationState {}

class LocationFetched extends LocationState {}

class LocationNotFetched extends LocationState {}

class LocationFetchingError extends LocationState {}
