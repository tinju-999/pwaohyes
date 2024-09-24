import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/selectedservicedetailedmodel.dart';
import 'package:pwaohyes/model/useralladdressmodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState()) {
    on<GetSelectedServiceDetails>(getSelectedServiceDetails);
    on<ConfirmBooking>(confirmBooking);
    on<GetUserAddress>(getUserAddress);
    on<DeleteAddress>(deleteAddress);
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
      Response response = await ServerHelper.post('cart/add', {
        "requested_date": DateTime.now().toString(),
        // dateTimeToStringApi(DateFormat('dd-MM-yyyy').parse(selectedDate!)),
        "requested_time": DateTime.now().toString(),
        // Helper.timeOfDayTo24HourString(DateTime.now()),
        "serviceTypeId": event.serviceId,
        "coupon_code": 'null',
        "description": event.description,
        "is_wallet": "0"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.pop();
        emit(BookingSuccess());
        Helper.showSnack("Booking Success");
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
      Response response = await ServerHelper.get('user/addresses');
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Initializer.userAllAddressModel = UserAllAddressModel.fromJson(data);
        emit(UserAddressFetched());
      } else {
        Helper.showSnack(data['body']['message']);
        emit(UserAddressNotFetched());
      }
    } catch (e) {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddressDeleted());
      } else {
        emit(AddressNotDeleted());
      }
    } catch (e) {
      Helper.showLog("Exception on deleting address $e");
      Helper.showSnack("Smomething went wrong");
      emit(DeletingAddressError());
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
  ConfirmBooking({required this.serviceId, required this.description});
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
