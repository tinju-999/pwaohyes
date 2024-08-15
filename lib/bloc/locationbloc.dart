import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class LocationBloc extends Cubit<LocationState> {
  LocationBloc() : super(LocationState());

  getLocation() async {
    try {
      emit(GettingLocation());
      Initializer.selectedAdddress =
          SelectedAddressModel(state: LoadingState.loading);
      bool isGranted = await seekLocationPermission();
      if (!isGranted) {
        Helper.showCustomDialog(
            title: "Location Permission Needed",
            content: "Please enable location permission in device settings",
            oneButtonDisabled: false,
            actionOne: () => Helper.pop(),
            actionOneText: "Cancel",
            actionTwo: () async {
              Helper.pop();
              await seekLocationPermission();
              Initializer.selectedAdddress =
                  SelectedAddressModel(state: LoadingState.loading);
            },
            actionTwoText: "Enable");
        emit(LocationNotFetched());
      } else {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.medium)
            .then((position) async {
          // if (!kIsWeb) {
          Initializer.selectedAdddress = SelectedAddressModel(
              latLng: LatLng(position.latitude, position.longitude),
              locationName: "Current Address");
          // }
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
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
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
