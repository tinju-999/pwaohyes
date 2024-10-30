// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/model/servicedetailedmodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

enum LoadingState { initial, loading, success, failed, error }

class ProviderClass extends ChangeNotifier {
  bool _isServiceParnterSelected = false;
  bool get isServiceParnterSelected => _isServiceParnterSelected;

  confirmServicePartner(bool value) {
    _isServiceParnterSelected = value;
    if (!value) {
      for (var e
          in Initializer.selectedServiceDetailsModel.data!.servicePartners!) {
        e.isSelected = false;
      }
      _selectedServicePartner = "";
    }
    notifyListeners();
  }

  bool _showAllReviewsStatus = false;
  bool get showAllReviewsStatus => _showAllReviewsStatus;
  showAllReviews(bool bool) {
    _showAllReviewsStatus = bool ? false : true;
    notifyListeners();
  }

  String _selectedServicePartner = "";
  String get selectedServicePartner => _selectedServicePartner;

  changeServicePartner(String? sId) {
    String newVal = "";
    for (var e
        in Initializer.selectedServiceDetailsModel.data!.servicePartners!) {
      if (e.sId == sId) {
        e.isSelected = true;
        newVal = sId!;
      } else {
        e.isSelected = false;
      }
    }
    _selectedServicePartner = newVal;
    notifyListeners();
  }

  bool _agreed = false;
  bool get agreed => _agreed;

  void setRatingValue(String? rating) =>
      _ratingValue = double.tryParse(rating!)!;

  double _ratingValue = 0.0;
  double get ratingValue => _ratingValue;
  setAgreement(bool? value) {
    _agreed = value!;
    notifyListeners();
  }

  //--------------------------------
  DateTime? _serviceTime = Initializer.now;
  DateTime get serviceTime => _serviceTime!;
  Timer? _timer;
  int _remainingTime = 60;
  int get remainingTime => _remainingTime;
  // bool? _isTimerRemaining = false;
  bool get isTimerRunning => _remainingTime > 0;
  bool? _showSubServices = false;
  bool? get showSubServices => _showSubServices;

  String _selectedServiceId = '';
  String get selectedServiceId => _selectedServiceId;

  String _selectedServiceAmount = '';
  String get selectedServiceAmount => _selectedServiceAmount;

  SelectedAddressModel _selectedAddressModel = SelectedAddressModel();
  SelectedAddressModel get selectedAddressModel => _selectedAddressModel;

  //_selectedServiceAmount

  bool _isAddAddressVisible = false;
  bool? get isAddAddressVisible => _isAddAddressVisible;

  CombinedData get combineData => CombinedData(
      remainingTime: _remainingTime, isTimerRunning: isTimerRunning);

  justChange() => notifyListeners();

  void selectSlotServiceDate(DateTime value) {
    _serviceTime = value;
    Initializer.seletedShopSlotDate = _serviceTime;
    notifyListeners();
    MyQBloc().add(GetShopsSlots(
        serviceId: Initializer.selectedShopServiceId,
        selectedSlotedServiceDate: Initializer.seletedShopSlotDate.toString()));
    // Initializer.myQBloc.getShopsSlots(
    //     Initializer.selectedShopServiceId, Initializer.seletedShopSlotDate);
  }

  startTimer() {
    _remainingTime = 60;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer!.cancel();
        notifyListeners();
      }
    });
  }

  resetTimer() {
    _timer!.cancel();
    startTimer();
  }

  showSubSerives(bool? value) {
    _showSubServices = value;
    notifyListeners();
  }

  chooseService(String id, int index) {
    _selectedServiceId = id;
    _selectedServiceAmount = Initializer
        .serviceDetailedModel.data!.serviceTypes![index].price
        .toString();
    notifyListeners();
  }

  setServiceIdAndPrice(ServiceTypes first) {
    _selectedServiceId = first.sId!;
    _selectedServiceAmount = first.price.toString();
    notifyListeners();
  }

  void changeServiceTime(TimeOfDay value) {
    DateTime selectedDate = Initializer.selectedServiceDate;
    Initializer.selectedServiceTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        value.hour,
        value.minute,
        0,
        0,
        0);
    Initializer.bookingTimeSuggestions.forEach((e) => e.isSelected = false);
    if (!Initializer.bookingTimeSuggestions.any((e) {
      if (e.date != null) {
        if (e.date!.hour == value.hour && e.date!.minute == value.minute) {
          e.isSelected = true;
          return true;
        } else {
          e.isSelected = false;
          return false;
        }
      } else {
        return false;
      }
    })) {
      Helper.showLog("haa");

      Initializer.bookingTimeSuggestions.last = BookingDateTimeModel(
        isSelected: true,
        date: Initializer.selectedServiceTime,
        label: Helper.setDateFormat(
            dateTime: Initializer.selectedServiceTime, format: "hh:mm a"),
      );
    }
    notifyListeners();
  }

  void selectServiceDate(DateTime? value) {
    Helper.showLog("Service date selected");
    Initializer.bookingDateSuggestions.forEach((e) => e.isSelected = false);
    var today = Initializer.bookingDateSuggestions[0].date;
    var tomorrow = Initializer.bookingDateSuggestions[1].date;
    if (isDatesEqual(value!, today)) {
      Initializer.bookingDateSuggestions[0].isSelected = true;
    } else if (isDatesEqual(value, tomorrow)) {
      Initializer.bookingDateSuggestions[1].isSelected = true;
    } else {
      Initializer.bookingDateSuggestions[2].isSelected = true;
      Initializer.bookingDateSuggestions[2].date = value;
    }
    Initializer.selectedServiceDate = value;
    // Helper.setTimings(Initializer.selectedServiceDate);
    notifyListeners();
  }

  bool isDatesEqual(DateTime value, DateTime? date) =>
      value.year == date!.year &&
      value.month == date.month &&
      value.day == date.day;

  selectServiceDateIndex(
      int index, BookingDateTimeModel bookingDateSuggestion) {
    Initializer.bookingDateSuggestions.forEach((e) => e.isSelected = false);
    Initializer.bookingDateSuggestions[index].isSelected = true;
    Initializer.selectedServiceDate = bookingDateSuggestion.date!;
    Initializer.selectedServiceDate = DateTime(
      Initializer.selectedServiceDate.year,
      Initializer.selectedServiceDate.month,
      Initializer.selectedServiceDate.day,
    );
    // if (isToday(Initializer.selectedServiceDate)) {
    //   Helper.showLog("Selected today");
    // }
    // if (Initializer.bookingDateSuggestions.first.isSelected!) {
    //   Helper.showLog("Selected today");
    // } else {
    //   Helper.showLog("Not Selected today");
    // }
    notifyListeners();
  }

  selectServiceTimeIndex(int index) {
    Initializer.bookingTimeSuggestions.forEach((e) => e.isSelected = false);
    Initializer.bookingTimeSuggestions[index].isSelected = true;
    notifyListeners();
  }

  bool isToday(DateTime selectedServiceDate) =>
      DateTime.now().difference(selectedServiceDate).inDays == 0;

  addAddressVisibility(bool bool) {
    _isAddAddressVisible = bool;
    notifyListeners();
  }

  Future<bool> getLocation() async {
    //  _currentModel =
    //     type == LocationType.address ? addressLocation : searchLocation;
    Completer<bool> completer = Completer<bool>();
    try {
      _selectedAddressModel =
          SelectedAddressModel(loadingState: LoadingState.loading);
      notifyListeners();
      bool isGranted = await seekLocationPermission();
      if (!isGranted) {
        // _currentModel = LocationModel(state: LoadingState.denied);
        notifyListeners();
        Helper.showCustomDialog(
            title: "Location Permission Needed",
            content: "Please enable location permission in device settings",
            oneButtonDisabled: false,
            actionOne: () => Helper.pop(),
            actionOneText: "Cancel",
            actionTwo: () async {
              Helper.pop();
              await seekLocationPermission();
              _selectedAddressModel =
                  SelectedAddressModel(loadingState: LoadingState.loading);
              notifyListeners();
            },
            actionTwoText: "Enable");
        completer.complete(false);
      } else {
        // bool serviceEnabled = await location!.requestService();
        // if (serviceEnabled) {
        // desiredAccuracy: LocationAccuracy.medium
        await Geolocator.getCurrentPosition().then((position) async {
          // await getNearbyAddress(position).then((foundNearby) async {
          if (!kIsWeb) {
            _selectedAddressModel = SelectedAddressModel(
                loadingState: LoadingState.success,
                latLng: LatLng(position.latitude, position.longitude),
                locationName: "Current Address");
            // if (!foundNearby) {
            // _initialCameraPosition = CameraPosition(
            //   target:
            //       // LatLng(25.137386, 55.648788),
            //       LatLng(position.latitude, position.longitude),
            //   zoom: 14.4746,
            // );
            // List<Placemark> placemarks = await placemarkFromCoordinates(
            //   position.latitude,
            //   position.longitude,
            //   // 25.137386,
            //   // 55.648788,
            // );

            // String? postalCode = placemarks.first.postalCode ?? "";
            // String? country = placemarks.first.country ?? "";
            // String? state = placemarks.first.administrativeArea ?? "";
            // String? locality = placemarks.first.locality ?? "";

            // String one = placemarks.first.locality!.isNotEmpty
            //     ? "${placemarks.first.locality!}"
            //     : "";
            // String two = placemarks.first.administrativeArea!.isNotEmpty
            //     ? ", ${placemarks.first.administrativeArea!}"
            //     : "";
            // String three = placemarks.first.subLocality!.isNotEmpty
            //     ? ", ${placemarks.first.subLocality!}"
            //     : "";
            // String address = one + two + three;

            // _currentModel = LocationModel(
            //   address: address,
            //   locality: locality,
            //   postalCode: postalCode,
            //   stateN: state,
            //   country: country,
            //   isNearby: foundNearby,
            //   position:
            //       // LatLng(25.137386, 55.648788),
            //       LatLng(position.latitude, position.longitude),
            //   state: LoadingState.success,
            //   cameraPosition: _initialCameraPosition,
            // );
          } else {
            _selectedAddressModel = SelectedAddressModel(
                loadingState: LoadingState.success,
                latLng: LatLng(position.latitude, position.longitude),
                locationName: "Current Address");
            // LatLng nearByPostion = LatLng(
            //     double.parse(Initializer.nearbyAddress.first.latitude!),
            //     double.parse(Initializer.nearbyAddress.first.longitude!));
            // _initialCameraPosition = CameraPosition(
            //   target:
            //       // LatLng(25.137386, 55.648788),
            //       nearByPostion,
            //   zoom: 14.4746,
            // );
            // _currentModel = LocationModel(
            //   isNearby: foundNearby,
            //   address: Initializer.nearbyAddress.first.nickName,
            //   locality: Initializer.nearbyAddress.first.addressLine1,
            //   postalCode: Initializer.nearbyAddress.first.postcode,
            //   stateN: Initializer.nearbyAddress.first.state,
            //   country: Initializer.nearbyAddress.first.country,
            //   position:
            //       // LatLng(25.137386, 55.648788),
            //       nearByPostion,
            //   state: LoadingState.success,
            //   cameraPosition: _initialCameraPosition,
            // );
            // }

            completer.complete(true);
            // } else {
            //   // _currentModel = LocationModel(
            //   //   address: "N/A",
            //   //   position: LatLng(position.latitude, position.longitude),
            //   //   state: LoadingState.success,
            //   //   cameraPosition: _initialCameraPosition,
            //   // );
            //   completer.complete(true);
            //   // GeoCode geoCode = GeoCode();
            //   // Address address = await geoCode.reverseGeocoding(
            //   //     latitude: position.latitude, longitude: position.longitude);
            //   // Helper.showLog(address.region);
            // }

            // markers.clear();
            // markers.add(Marker(
            //   draggable: true,
            //   markerId: MarkerId('dragLoc'),
            //   position: initialCameraPosition.target,
            // ));
            notifyListeners();
          }
        });
        // } else {
        //   // _searchLocation.state = LoadingState.denied;
        //   // _currentModel = LocationModel(state: LoadingState.denied);
        //   notifyListeners();
        //   Helper.showCustomDialog(
        //     title: "Location Service",
        //     content: "To search with us, please provide your current location.",
        //     oneButtonDisabled: true,
        //     actionTwo: () async {
        //       Helper.pop();
        //     },
        //     actionTwoText: "Ok",
        //   );
        //   completer.complete(false);
        // }
      }
      return completer.future;
    } catch (e) {
      Helper.showLog('exception on fetching location $e');
      // _searchLocation = LocationModel(state: LoadingState.error);
      completer.complete(false);
      // _currentModel = LocationModel(state: LoadingState.denied);
      notifyListeners();
      return completer.future;
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

  changeSlotService(int index) {
    for (var e in Initializer.myqpadCategoryModel.data!.cateoryList!) {
      e.isSelected = false;
    }
    Initializer.myqpadCategoryModel.data!.cateoryList![index].isSelected = true;
    Initializer.selectedMyQCategory =
        Initializer.myqpadCategoryModel.data!.cateoryList![index].sId;
    Helper.showLog(
        "Selected cat id : ${Initializer.myqpadCategoryModel.data!.cateoryList![index].sId}");
    Initializer.selectedMyQCategoryName =
        Initializer.myqpadCategoryModel.data!.cateoryList![index].businessName!;
    MyQBloc().add(GetMyQShops(
        query: "", businessName: Initializer.selectedMyQCategoryName));
    // Initializer.myQBloc.getMyQShops(
    //     businessName: Initializer.selectedMyQCategoryName, query: '');
    notifyListeners();
  }

  changeSlotShopService(int index) {
    for (var e in Initializer.shopViewModel.services!) {
      e.isSelected = false;
    }
    Initializer.shopViewModel.services![index].isSelected = true;
    Initializer.selectedShopServiceId =
        Initializer.shopViewModel.services![index].sId;
    notifyListeners();
    MyQBloc().add(GetShopsSlots(
        serviceId: Initializer.selectedShopServiceId,
        selectedSlotedServiceDate: Initializer.seletedShopSlotDate.toString()));
    // Initializer.myQBloc.getShopsSlots(
    //     Initializer.selectedShopServiceId, Initializer.seletedShopSlotDate);
  }

  void changeShopServiceSlot(int index) {
    for (var e in Initializer.shopSlotModel.data!) {
      e.isSelected = false;
    }
    Initializer.shopSlotModel.data![index].isSelected = true;
    Initializer.selectedShopSlotId = Initializer.shopSlotModel.data![index].sId;
    notifyListeners();
    // Initializer.myQBloc.getShopsSlots(
    //     Initializer.shopViewModel.services![index].sId, Initializer.selectedSlotedServiceDate);
  }

  void checkSelectedPartner() => _selectedServicePartner = "";

  updateRating(double value) {
    _ratingValue = value;
    notifyListeners();
  }
}

class CombinedData {
  bool? isTimerRunning;
  int? remainingTime;
  CombinedData({this.isTimerRunning, this.remainingTime});
}
