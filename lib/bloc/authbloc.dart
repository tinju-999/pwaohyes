import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/citiesmodel.dart';
import 'package:pwaohyes/model/otpverifiedmodel.dart';
import 'package:pwaohyes/model/usermodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState());

  void getOtp() {
    emit(GettingOtp());
  }

  verifyPhone(String phoneController) async {
    try {
      emit(RequestingOTP());
      String mobileNumber = "+91$phoneController";
      Response response =
          await ServerHelper.post('auth', {"mobileNumber": mobileNumber});
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(OTPRequested(phone: phoneController));
      } else {
        Helper.showLog(jsonDecode(response.body)['msg']);
        Helper.showSnack(response.reasonPhrase);
        emit(OTPNotRequested());
      }
    } catch (e) {
      emit(OTPNotRequested());
    }
  }

  verifyOtp(String otp, String phone) async {
    try {
      emit(VerifyingOTP());
      Response response = await ServerHelper.post('verify', {
        "mobileNumber": '+91$phone',
        "otp": otp,
        "device_token": 'xxx',
        "device_type": 'web',
      });
      var data = jsonDecode(response.body);
      Helper.showLog(data['error_code']);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Helper.showLog('auth data $data');
        Initializer.otpVerifiedModel = OtpVerifiedModel.fromJson(data);
        await Preferences.setToken(
            Initializer.otpVerifiedModel.data!.accessToken!);
        await Preferences.setPhone(phone);

        //7034444303
        await Preferences.setVerifiedData(
            jsonEncode(Initializer.otpVerifiedModel.toJson()));
        // Helper.pushReplacement(const BookingAddressWeb());
        Helper.showSnack(data['message']);

        Initializer.userModel = UserModel(
            phone: phone,
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

  doLogout() async {
    try {
      emit(LoggingOut());
      Response response = await ServerHelper.post(
          'logout', {"device_token": "", "device_type": 'web'});
      if (response.statusCode == 200 || response.statusCode == 204) {
        // var data = jsonDecode(response.body);
        await Preferences.clearAll();
        Initializer.userModel = UserModel(isLoggedIn: false);
        emit(LoggoutSuccess());
      } else {
        emit(LoggoutFailed());
      }
    } catch (e) {
      Helper.showLog("Logout exception $e");
      emit(LoggingOutError());
    }
  }

  Future<void> fetchCities() async {
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
}

class AuthState {}

class AuthEvent {}

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
