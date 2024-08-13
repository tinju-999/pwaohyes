import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class AuthWebRegisterView extends StatefulWidget {
  final AuthBloc? authBloc;
  final ProviderClass? providerClass;
  const AuthWebRegisterView(
      {super.key, required this.authBloc, required this.providerClass});

  @override
  State<AuthWebRegisterView> createState() => _AuthWebRegisterViewState();
}

class _AuthWebRegisterViewState extends State<AuthWebRegisterView> {
  final _otpController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is OTPRequested,
        builder: (context, mainState) => mainState is OTPRequested
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Verify your mobile number',
                      style: TextStyle(fontSize: 26, color: primaryColor)),
                  Helper.allowHeight(2.5),
                  const Text(
                    "Please enter the verification code send to your\nnumber +8129322316",
                    style: TextStyle(
                      fontSize: 14,
                      color: grey,
                    ),
                  ),
                  Helper.allowHeight(15),
                  SizedBox(
                    width: Helper.width / 3.5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OtpTextField(
                        numberOfFields: 4,
                        showFieldAsBox: true,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        fieldWidth: 60,
                        onSubmit: (value) => _otpController.text = value,
                      ),
                    ),
                  ),
                  Helper.allowHeight(15),
                  SizedBox(
                    width: Helper.width / 3.5,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is OTPRequested) {
                          widget.providerClass!.startTimer();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is OTPRequested ||
                          current is RequestingOTP ||
                          current is OTPRequestingError,
                      builder: (context, state) => MaterialButton(
                        onPressed: () => state is! RequestingOTP
                            ? widget.authBloc!.verifyOtp(
                                _otpController.text, mainState.phone!)
                            : Helper.showToast(msg: "Please wait"),
                        elevation: 0.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 14),
                        child: state is RequestingOTP
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: white))
                            : const Text("Verify OTP",
                                style: TextStyle(color: white)),
                      ),
                    ),
                  ),
                  Helper.allowHeight(15),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'By continuing you agree to our ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Terms & Conditions ',
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ]),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Regiter Now',
                    style: TextStyle(fontSize: 36, color: primaryColor),
                  ),
                  Helper.allowHeight(20),
                  SizedBox(
                    width: Helper.width / 3,
                    child: TextFormField(
                        maxLength: 10,
                        controller: _phoneController,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) =>
                            Helper.shrink(),
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: const TextStyle(fontSize: 13, color: grey),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )),
                  ),
                  Helper.allowHeight(5),
                  SizedBox(
                    width: Helper.width / 3,
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is OTPRequested) {
                          widget.providerClass!.startTimer();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is OTPRequested ||
                          current is RequestingOTP ||
                          current is OTPNotRequested ||
                          current is OTPRequestingError,
                      builder: (context, state) => MaterialButton(
                        onPressed: () => state is! RequestingOTP
                            ? widget.authBloc!
                                .verifyPhone(_phoneController.text)
                            : Helper.showToast(msg: "Please wait"),
                        elevation: 0.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 14),
                        child: state is RequestingOTP
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: white))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text("Continue",
                                      style: TextStyle(color: white)),
                                  Helper.allowWidth(10),
                                  const Icon(Icons.arrow_right_alt,
                                      color: white),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Helper.allowHeight(15),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'By continuing you agree to our ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Terms & Conditions ',
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ]),
                  )
                ],
              ),
      ),
    );
  }
}
