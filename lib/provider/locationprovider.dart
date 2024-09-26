import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class LocationProvider extends ChangeNotifier {
  getLocation() async {
    try {
      Initializer.selectedAdddress2 = SelectedAddressModel(
          latLng: const LatLng(10.216069936633316, 76.37739596497103));
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
      } else {
        //  desiredAccuracy: LocationAccuracy.low
        await Geolocator.getCurrentPosition().then((position) async {
          // Address address = await geoCode.reverseGeocoding(
          //     latitude: position.latitude, longitude: position.longitude);

          Initializer.selectedAdddress2 = SelectedAddressModel(
            loadingState: LoadingState.success,
            latLng: LatLng(
              position.latitude,
              position.longitude,
            ),
          );
          // await Preferences.setLocation(
          //     jsonEncode(Initializer.selectedAdddress2!.toJson()));
        });
        notifyListeners();
      }
    } catch (e) {
      Helper.showLog("Location fetching error $e");
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
