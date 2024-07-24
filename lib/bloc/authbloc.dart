import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState());

  void getOtp() {
    emit(GettingOtp());
  }

  verifyPhone() async {
    emit(RequestingOTP());
    await Future.delayed(const Duration(seconds: 5));
    emit(OTPRequested());
    await Future.delayed(const Duration(seconds: 5));
    emit(OTPVerified());
    // emit(PhoneNotVerified());
  }
}

class AuthState {}

class AuthEvent {}

class GettingOtp extends AuthState {}

class RequestingOTP extends AuthState {}

class OTPRequested extends AuthState {}

class OTPRequestingError extends AuthState {}

class OTPVerified extends AuthState {}
