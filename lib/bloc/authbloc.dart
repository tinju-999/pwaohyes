import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/citiesmodel.dart';
import 'package:pwaohyes/model/myreviewmodel.dart';
import 'package:pwaohyes/model/otpverifiedmodel.dart';
import 'package:pwaohyes/model/usermodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';
import 'package:pwaohyes/utils/routes.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<VerifyOtp>(verifyOtp);
    on<VerifyPhone>(verifyPhone);
    on<DoLogout>(doLogout);
    on<FetchCities>(fetchCities);
    on<GetMyReview>(getMyReview);
  }

  Future<void> verifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    try {
      emit(VerifyingOTP());
      Response response = await ServerHelper.post(
        'verify',
        {
          "mobileNumber": '+91${event.phone}',
          "otp": event.otp!,
          "device_token": 'xxx',
          "device_type": 'web',
        },
      );
      var data = jsonDecode(response.body);
      Helper.showLog(data['error_code']);
      if (response.statusCode == 200 && data['message'] != "Invalid OTP") {
        var data = jsonDecode(response.body);
        Helper.showLog('auth data $data');
        Initializer.otpVerifiedModel = OtpVerifiedModel.fromJson(data);
        await Preferences.setToken(
            Initializer.otpVerifiedModel.data!.accessToken!);
        await Preferences.setRefreshToken(
            Initializer.otpVerifiedModel.data!.refreshToken!);
        await Preferences.setPhone(event.phone!);

        //7034444303
        await Preferences.setVerifiedData(
            jsonEncode(Initializer.otpVerifiedModel.toJson()));
        // Helper.pushReplacement(const BookingAddressWeb());
        // Helper.showSnack(data['message']);

        Initializer.userModel = UserModel(
            phone: event.phone,
            token: Initializer.otpVerifiedModel.data!.accessToken!,
            isLoggedIn: true,
            refreshToken: Initializer.otpVerifiedModel.data!.refreshToken!);
        emit(OTPVerified());
      } else {
        Helper.showLog(jsonDecode(response.body)['msg']);
        Helper.showSnack(data['message']);
        Initializer.userModel =
            UserModel(token: "", isLoggedIn: false, refreshToken: "");
        emit(OTPNotVerified());
      }
    } catch (e) {
      Initializer.userModel =
          UserModel(token: "", isLoggedIn: false, refreshToken: "");
      Helper.showLog('Exception on verifying otp $e');
      emit(VerifyingOTPError());
    }
  }

  Future<void> verifyPhone(VerifyPhone event, Emitter<AuthState> emit) async {
    try {
      emit(RequestingOTP());
      String mobileNumber = "+91${event.phone}";
      Response response = await ServerHelper.post(
        'auth',
        {"mobileNumber": mobileNumber},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(OTPRequested(phone: event.phone));
      } else {
        Helper.showLog(jsonDecode(response.body)['msg']);
        Helper.showSnack(response.reasonPhrase);
        emit(OTPNotRequested());
      }
    } catch (e) {
      emit(OTPNotRequested());
    }
  }

  Future<void> doLogout(DoLogout event, Emitter<AuthState> emit) async {
    try {
      emit(LoggingOut());
      Response response = await ServerHelper.post(
        'logout',
        {"device_token": "", "device_type": 'web'},
      );
      // var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 204) {
        // var data = jsonDecode(response.body);
        await Preferences.clearAll();
        Initializer.userModel = UserModel(isLoggedIn: false);
        Helper.pushAndRemoveNamedUntil(locationView);
        Helper.showSnack("Session Expired.");
        emit(LoggoutSuccess());
      } else {
        Helper.showSnack("Something went wrong -- ${response.reasonPhrase}");
        await Preferences.clearAll();
        Helper.pushAndRemoveNamedUntil(locationView);
        emit(LoggoutFailed());
      }
    } catch (e) {
      Helper.showLog("Logout exception $e");
      emit(LoggingOutError());
    }
  }

  Future<void> fetchCities(FetchCities event, Emitter<AuthState> emit) async {
    try {
      emit(FetchingCitiesData());
      Response response = await ServerHelper.get('cities');
      if (response.statusCode == 200 || response.statusCode == 204) {
        var data = jsonDecode(response.body);
        Initializer.citiesModel = CitiesModel.fromJson(data);
        emit(CitiesDataFetched());
      } else {
        emit(CitiesDataNotFetched());
      }
    } catch (e) {
      Helper.showLog("Exception on fetching cities $e");
      emit(FetchingCitiesDataError());
    }
  }

  Future<FutureOr<void>> getMyReview(
      GetMyReview event, Emitter<AuthState> emit) async {
    try {
      emit(GettingMyReview());
      Helper.showLoader();
      Response response = await ServerHelper.getMyQPost('/rating/get/my/review',
          {"partnerId": event.partnerId, "phone_no": event.phoneNo});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper.pop();
        Initializer.myReviewModel =
            MyReviewModel.fromJson(jsonDecode(response.body));
        emit(MyReviewsFetched());
      } else {
        Helper.pop();
        Initializer.myReviewModel = MyReviewModel(review: false);
        emit(MyReviewsNotFetched());
      }
    } catch (e) {
      Helper.pop();
      Helper.showLog('Exception on gettingmy review $e');
      Initializer.myReviewModel = MyReviewModel(review: false);
      emit(GettingMyReviewError());
    }
  }
}

class AuthState {}

class AuthEvent {}

//-----------------------------------

class GetMyReview extends AuthEvent {
  final String? partnerId, phoneNo;
  GetMyReview({required this.partnerId, required this.phoneNo});
}

class GettingMyReview extends AuthState {}

class MyReviewsFetched extends AuthState {}

class MyReviewsNotFetched extends AuthState {}

class GettingMyReviewError extends AuthState {}

//-----------------------------------

class VerifyOtp extends AuthEvent {
  final String? phone, otp;
  VerifyOtp({required this.otp, required this.phone});
}

class VerifyPhone extends AuthEvent {
  final String? phone;
  VerifyPhone({required this.phone});
}

class DoLogout extends AuthEvent {}

class FetchCities extends AuthEvent {}

//VerifyPhone

class FetchingCitiesData extends AuthState {}

class CitiesDataFetched extends AuthState {}

class CitiesDataNotFetched extends AuthState {}

class FetchingCitiesDataError extends AuthState {}

class GettingOtp extends AuthState {}

class RequestingOTP extends AuthState {}

class OTPRequested extends AuthState {
  final String? phone;
  OTPRequested({required this.phone});
}

class OTPNotRequested extends AuthState {}

class OTPRequestingError extends AuthState {}

class VerifyingOTP extends AuthState {}

class OTPVerified extends AuthState {}

class OTPNotVerified extends AuthState {}

class VerifyingOTPError extends AuthState {}

class LoggingOut extends AuthState {}

class LoggoutSuccess extends AuthState {}

class LoggoutFailed extends AuthState {}

class LoggingOutError extends AuthState {}
