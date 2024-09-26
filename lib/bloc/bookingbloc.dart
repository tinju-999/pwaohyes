import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/selectedservicedetailedmodel.dart';
import 'package:pwaohyes/model/useralladdressmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState()) {
    on<GetSelectedServiceDetails>(getSelectedServiceDetails);
    on<ConfirmBooking>(confirmBooking);
    on<GetUserAddress>(getUserAddress);
    on<DeleteAddress>(deleteAddress);
    on<ChangeAddress>(changeAddress);
  }

  Future<void> getSelectedServiceDetails(
      GetSelectedServiceDetails event, Emitter<BookingState> emit) async {
    // try {
    emit(GettingSelectedServiceDetails());
    Response response =
        await ServerHelper.get('services-selection/${event.id}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      Initializer.selectedServiceDetailsModel =
          SelectedServiceDetailsModel.fromJson(data);
      emit(SelectedServiceDetailsFetched());
      add(GetUserAddress());
    } else {
      Helper.showLog(response.reasonPhrase);
      emit(SelectedServiceDetailsNotFetched());
    }
    // } catch (e) {
    //   Helper.showLog("Exception on getting selected service details $e");
    //   emit(GettingSelectedServiceDetailsError());
    // }
  }

  Future<void> confirmBooking(
      ConfirmBooking event, Emitter<BookingState> emit) async {
    try {
      emit(BookingInProgress());
      Helper.showLoader();
      var data = {
        "requested_date": Initializer.bookingDateSuggestions
            .where((e) => e.isSelected!)
            .first
            .date
            .toString(),
        "requested_time": Initializer.bookingTimeSuggestions
            .where((e) => e.isSelected!)
            .first
            .date
            .toString(),
        "serviceTypeId": event.serviceId,
        "service_partner_id": Helper.isToday(Initializer.bookingDateSuggestions
                .where((e) => e.isSelected!)
                .first
                .date!)
            ? Initializer.providerClass!.selectedServicePartner
            : "",
        "coupon_code": 'null',
        "description": event.description,
        "is_wallet": "0"
      };
      Helper.showLog(data);
      Response response = await ServerHelper.post('cart/add', data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.pop();
        emit(BookingSuccess());
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
      } else {
        emit(BookingFailed());
        Helper.pop();
        Helper.showSnack("Booking Failed");
      }
    } catch (e) {
      Helper.pop();
      Helper.showLog("Exception on booking $e");
      Helper.showSnack("Booking Failed");
      emit(BookingError());
    }
  }

  Future<void> getUserAddress(
      GetUserAddress event, Emitter<BookingState> emit) async {
    try {
      emit(GettingUserAddress());
      Helper.showLoader();
      Response response = await ServerHelper.get('user/addresses');
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Initializer.userAllAddressModel = UserAllAddressModel.fromJson(data);
        Helper.pop();
        emit(UserAddressFetched());
      } else {
        Helper.showSnack(data['body']['message']);
        Helper.pop();
        emit(UserAddressNotFetched());
      }
    } catch (e) {
      Helper.pop();
      Helper.showLog("Exception on fetching addresses $e");
      Helper.showSnack("Smomething went wrong");
      emit(GettingUserAddressError());
    }
  }

  Future<void> deleteAddress(
      DeleteAddress event, Emitter<BookingState> emit) async {
    try {
      emit(DeletingAddress());
      Response response = await ServerHelper.delete('user/address/${event.id}');
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddressDeleted());
        add(GetSelectedServiceDetails(id: Initializer.selectedServiceId));
      } else {
        emit(AddressNotDeleted());
        Helper.showSnack(data['message']);
      }
    } catch (e) {
      Helper.showLog("Exception on deleting address $e");
      Helper.showSnack("Smomething went wrong");
      emit(DeletingAddressError());
    }
  }

  Future<void> changeAddress(
      ChangeAddress event, Emitter<BookingState> emit) async {
    try {
      emit(ChangingAddress());
      Helper.showLoader();
      Helper.showLog("the selected add id -----> ${event.id}");
      Response response = await ServerHelper.post(
          'user/address/select/${event.id}', {'is_selected': "true"});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddressChanged());
        Helper.showSnack(data['message']);
        Helper.pop();
        add(GetSelectedServiceDetails(id: Initializer.selectedServiceId));
      } else {
        Helper.pop();
        emit(AddressNotChanged());
        Helper.showSnack(data['message']);
      }
    } catch (e) {
      Helper.pop();
      Helper.showLog("Exception on changing address $e");
      Helper.showSnack("Smomething went wrong");
      emit(ChangingAddressError());
    }
  }
}

class BookingEvent {}

class BookingState {}

class GetSelectedServiceDetails extends BookingEvent {
  final String? id;
  GetSelectedServiceDetails({required this.id});
}

class GettingSelectedServiceDetails extends BookingState {}

class SelectedServiceDetailsFetched extends BookingState {}

class SelectedServiceDetailsNotFetched extends BookingState {}

class GettingSelectedServiceDetailsError extends BookingState {}

class ConfirmBooking extends BookingEvent {
  final String? serviceId, description;
  final DateTime selectedServiceDate, selectedServiceTime;
  ConfirmBooking({
    required this.serviceId,
    required this.description,
    required this.selectedServiceDate,
    required this.selectedServiceTime,
  });
}

class BookingInProgress extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingFailed extends BookingState {}

class BookingError extends BookingState {}

class GetUserAddress extends BookingEvent {}

class GettingUserAddress extends BookingState {}

class UserAddressFetched extends BookingState {}

class UserAddressNotFetched extends BookingState {}

class GettingUserAddressError extends BookingState {}

//----------------------------------------

class DeleteAddress extends BookingEvent {
  final String? id;
  DeleteAddress({required this.id});
}

class DeletingAddress extends BookingState {}

class AddressDeleted extends BookingState {}

class AddressNotDeleted extends BookingState {}

class DeletingAddressError extends BookingState {}

//----------------------------------------

class ChangeAddress extends BookingEvent {
  final String? id;
  ChangeAddress({required this.id});
}

class ChangingAddress extends BookingState {}

class AddressChanged extends BookingState {}

class AddressNotChanged extends BookingState {}

class ChangingAddressError extends BookingState {}

//----------------------------------------