import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
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
        "device_token": 'null',
        "device_type": 'web',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        Initializer.otpVerifiedModel = OtpVerifiedModel.fromJson(data);
        await Preferences.setToken(
            Initializer.otpVerifiedModel.data!.accessToken!);
        await Preferences.setRefreshToken(
            Initializer.otpVerifiedModel.data!.refreshToken!);

        await Preferences.setVerifiedData(
            jsonEncode(Initializer.otpVerifiedModel.toJson()));
        Helper.pushAndRemoveUntil(const BookingAddressWeb());
        Helper.showSnack(data['message']);
        emit(OTPVerified());
      } else {
        Helper.showLog(jsonDecode(response.body)['msg']);
        Helper.showLog(response.reasonPhrase);
        emit(OTPNotVerified());
      }
    } catch (e) {
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
        Initializer.userModel = UserModel();
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
