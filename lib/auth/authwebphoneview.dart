import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class AuthWebPhoneView extends StatelessWidget {
  final AuthBloc? authBloc;
  final ProviderClass? providerClass;
  const AuthWebPhoneView(
      {super.key, required this.authBloc, required this.providerClass});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "WebView",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          const Text(
            "Enter your mobile number for verification",
            style: TextStyle(
              fontSize: 14,
              color: grey,
            ),
          ),
          Helper.allowHeight(5),
          SizedBox(
            width: Helper.width / 3,
            child: TextFormField(
                decoration: InputDecoration(
              hintText: "Mobile Number",
              hintStyle: const TextStyle(fontSize: 13, color: grey),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            )),
          ),
          Helper.allowHeight(15),
          SizedBox(
            width: Helper.width / 3,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is OTPRequested) {
                  providerClass!.startTimer();
                }
              },
              buildWhen: (previous, current) =>
                  current is OTPRequested ||
                  current is RequestingOTP ||
                  current is OTPRequestingError,
              builder: (context, state) => MaterialButton(
                onPressed: () => state is! RequestingOTP
                    ? context.read<AuthBloc>().add(VerifyPhone(phone: ''))
                    : Helper.showToast(msg: "Please wait"),
                elevation: 0.0,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                child: state is RequestingOTP
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CupertinoActivityIndicator(color: white))
                    : const Text("Get OTP", style: TextStyle(color: white)),
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
    );
  }
}
