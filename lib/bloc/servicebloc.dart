import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/servicedetailedmodel.dart';
import 'package:pwaohyes/model/servicemodel.dart';
import 'package:pwaohyes/model/subcatmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class ServiceBloc extends Cubit<ServiceState> {
  ServiceBloc() : super(ServiceState());

  addAddress(Map data) async {
    try {
      emit(AddingAddress());
      Response response = await ServerHelper.post('user/address', data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.showLog(response.reasonPhrase);
        Helper.showSnack(response.reasonPhrase);
        emit(AddressAdded());
      } else {
        Helper.showSnack(response.reasonPhrase);
        Helper.showLog(response.reasonPhrase);
        emit(AddressNotAdded());
      }
    } catch (e) {
      Helper.showLog("Exception on adding address $e");
      Helper.showSnack("Unexpected Exception");
      emit(AddressAddingFailed());
    }
  }

  getServices() async {
    try {
      emit(FetchingServices());
      Helper.showLog(Initializer.selectedAdddress!.latLng.toString());
      // Response authResponse = await ServerHelper.post('refresh', {"refreshToken": Initializer.userModel.refreshToken ?? ""});
      // if (authResponse.statusCode == 200 || authResponse.statusCode == 201) {
      // Helper.showLog(jsonDecode(authResponse.body));
      Response response = await ServerHelper.get(
          'home-public?lat=${Initializer.selectedAdddress!.latLng!.latitude}&lng=${Initializer.selectedAdddress!.latLng!.longitude}&city=${Initializer.selectedAdddress!.cityId}');
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body);
        Initializer.serviceModel =
            ServiceModel.fromJson(jsonDecode(response.body));
        if (Initializer.serviceModel.errorCode == 0) {
          Initializer.serviceCategory = Initializer.serviceModel.data!.content!
              .where((e) => e.type == "category")
              .first
              .categoryItems!
              .toList();

          emit(ServicesFetched());
          Initializer.myQBloc.getMyQCats();
        } else {
          Helper.showSnack(response.reasonPhrase);
          emit(ServicesNotFetched());
        }
      } else {
        Helper.showSnack(response.reasonPhrase);
        emit(ServicesNotFetched());
      }
      // }
    } catch (e) {
      Helper.showLog("Exception on services $e");
      emit(ServicesNotFetched());
    }
  }

  getSubServices(String id) async {
    // try {
    emit(FetchingSubServices());
    Response response =
        await ServerHelper.get('services/by_category/without_location/$id');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Initializer.subCatModel = SubCatModel.fromJson(data);
      if (Initializer.subCatModel.errorCode == 0) {
        emit(SubServicesFetched());
      } else {
        emit(SubServicesNotFetched());
      }
    } else {
      emit(SubServicesNotFetched());
    }
    // } catch (e) {
    //   Helper.showLog("Exception on sub-services $e");
    //   emit(SubServicesNotFetched());
    // }
  }

  Future<void> getServiceDetail(String? catId) async {
    try {
      emit(GettingServiceDetail());
      Response response =
          await ServerHelper.get('services/by-guest-user/$catId');
      if (response.statusCode == 200) {
        Initializer.serviceDetailedModel =
            ServiceDetailedModel.fromJson(jsonDecode(response.body));
        if (Initializer.serviceDetailedModel.data!.serviceTypes!.isNotEmpty) {
          Initializer.providerClass!.setServiceIdAndPrice(
              Initializer.serviceDetailedModel.data!.serviceTypes!.first);
        }

        //Initializer.providerClass!.amount
        emit(ServiceDetailFetched());
      } else {
        emit(ServiceDetailNotFetched());
      }
    } catch (e) {
      Helper.showLog("exception on getting service detailed view $e");
      emit(ServiceDetailNotFetched());
    }
  }

  void bookService(Map map) async {
    try {
      emit(BookingService());
      Helper.showLoader();
      Response response =
          await ServerHelper.getMyQPostSpecial('/booking/add/user/web', map);
      if (response.statusCode == 200 && jsonDecode(response.body)['status']) {
        Helper.pop();
        if (Initializer.selectedAdddress!.loadingState ==
            LoadingState.success) {
          Helper.pushReplacementNamed(services);
        } else {
          Helper.pushReplacementNamed(locationView);
        }
        if (Helper.isMobile()) {
          Helper.showSuccessMobile();
        } else {
          Helper.showSuccessWeb();
        }

        emit(ServiceBooked());
      } else {
        Helper.pop();
        Helper.showLog("Unable to book the service ${response.reasonPhrase}");
        Helper.showSnack(response.reasonPhrase);
        emit(ServiceNotBooked());
      }
    } on Exception catch (e) {
      Helper.pop();
      Helper.showLog("Exception on booking service $e");
      emit(ServiceBookingError());
    }
  }
}

class ServiceState {}

//___________________________________________

class BookingService extends ServiceState {}

class ServiceBooked extends ServiceState {}

class ServiceNotBooked extends ServiceState {}

class ServiceBookingError extends ServiceState {}

//___________________________________________

class AddingAddress extends ServiceState {}

class AddressAdded extends ServiceState {}

class AddressNotAdded extends ServiceState {}

class AddressAddingFailed extends ServiceState {}

//___________________________________________

class GettingServiceDetail extends ServiceState {}

class ServiceDetailFetched extends ServiceState {}

class ServiceDetailNotFetched extends ServiceState {}

class GettingServiceDetailError extends ServiceState {}
//___________________________________________

class FetchingServices extends ServiceState {}

class ServicesFetched extends ServiceState {}

class ServicesNotFetched extends ServiceState {}

class FetchingSubServices extends ServiceState {}

class SubServicesFetched extends ServiceState {}

class SubServicesNotFetched extends ServiceState {}
