import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/model/servicedetailedmodel.dart';
import 'package:pwaohyes/model/servicemodel.dart';
import 'package:pwaohyes/model/subcatmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceState()) {
    on<AddCustomerReview>(addReview);
    on<AddAddress>(addAddress);
    on<GetServices>(getServices);
    on<GetSubServices>(getSubServices);
    on<GetSubServicesDetail>(getServiceDetail);
    on<BookService>(bookService);
  }

  Future<void> addAddress(AddAddress event, Emitter<ServiceState> emit) async {
    try {
      emit(AddingAddress());
      Response response = await ServerHelper.post(
        'user/address',
        event.data,
      );
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.showLog(response.reasonPhrase);
        Helper.showSnack(decodedData['message']);
        Initializer.providerClass?.addAddressVisibility(false);
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

  Future<void> getServices(
      GetServices event, Emitter<ServiceState> emit) async {
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

  Future<void> getSubServices(
      GetSubServices event, Emitter<ServiceState> emit) async {
    try {
      emit(FetchingSubServices());
      Response response = await ServerHelper.get(
          'services/by_category/without_location/${event.id}?city=${Initializer.selectedAdddress!.cityId}');
      //&city=${Initializer.selectedAdddress!.cityId}
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
    } catch (e) {
      Helper.showLog("Exception on sub-services $e");
      emit(SubServicesNotFetched());
    }
  }

  Future<void> getServiceDetail(
      GetSubServicesDetail event, Emitter<ServiceState> emit) async {
    try {
      emit(GettingServiceDetail());
      Response response =
          await ServerHelper.get('services/by-guest-user/${event.catId}');
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

  Future<void> bookService(
      BookService event, Emitter<ServiceState> emit) async {
    try {
      emit(BookingService());
      Helper.showLoader();
      Response response = await ServerHelper.getMyQPostSpecial(
          '/booking/add/user/web', event.data);
      if (response.statusCode == 200 && jsonDecode(response.body)['status']) {
        Helper.pop();
        if (Initializer.selectedAdddress!.loadingState ==
            LoadingState.success) {
          Helper.pushReplacementNamed(allservices);
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

  Future<FutureOr<void>> addReview(
      AddCustomerReview event, Emitter<ServiceState> emit) async {
    try {
      emit(AddingReview());
      Helper.showLoader();
      Response response =
          await ServerHelper.getMyQPost('/rating/add/customer', event.map);
      Helper.showLog(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.pop();
        Helper.showSnack(jsonDecode(response.body)['message']);
       
        emit(ReviewAdded());
      } else {
        Helper.pop();
        Helper.showSnack(response.reasonPhrase);
        emit(ReviewNotAdded());
      }
    } catch (e) {
      Helper.pop();
      Helper.showLog("Exception on adding review $e");
      Helper.showSnack("Something went wrong, unable to add review");
      emit(ReviewAddingFailed());
    }
  }
}

class ServiceState {}

class ServiceEvent {}

//___________________________________________

class AddCustomerReview extends ServiceEvent {
  final Map<String, dynamic> map;
  AddCustomerReview({required this.map});
}

class AddingReview extends ServiceState {}

class ReviewAdded extends ServiceState {}

class ReviewNotAdded extends ServiceState {}

class ReviewAddingFailed extends ServiceState {}

//___________________________________________
class AddAddress extends ServiceEvent {
  final Map data;
  AddAddress({required this.data});
}

class BookService extends ServiceEvent {
  final Map data;
  BookService({required this.data});
}

class GetServices extends ServiceEvent {}

class GetSubServices extends ServiceEvent {
  final String id;
  GetSubServices({required this.id});
}

class GetSubServicesDetail extends ServiceEvent {
  final String catId;
  GetSubServicesDetail({required this.catId});
}

//GetSubServicesDetail

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
