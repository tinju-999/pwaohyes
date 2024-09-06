import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class MobileAuthView extends StatelessWidget {
  const MobileAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      endDrawer: const Drawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Header(
                  removeBadge: false,
              route: const MobileAuthView(),
              scaffoldKey: scaffoldKey,
            ),
            Helper.allowHeight(20),
            const BookingAuthMobile(),
            Helper.allowHeight(20),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class BookingAuthMobile extends StatelessWidget {
  const BookingAuthMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Image.asset(
            authLogin,
            fit: BoxFit.contain,
          ),
        ),
        Helper.allowHeight(30),
        BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => current is OTPRequested,
            builder: (context, state) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: const TextStyle(fontSize: 13, color: grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )),
                    Helper.allowHeight(15),
                    TextFormField(
                        decoration: InputDecoration(
                      hintText: "Email Id",
                      hintStyle: const TextStyle(fontSize: 13, color: grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )),
                    Helper.allowHeight(15),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is OTPRequested) {
                          Initializer.providerClass!.startTimer();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is OTPRequested ||
                          current is RequestingOTP ||
                          current is OTPRequestingError,
                      builder: (context, state) => SizedBox(
                        width: Helper.width,
                        child: MaterialButton(
                          onPressed: () => state is! RequestingOTP
                              ? Initializer.authBloc.verifyPhone("")
                              : Helper.showToast(msg: "Please wait"),
                          elevation: 5.0,
                          color: primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 14),
                          child: state is RequestingOTP
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CupertinoActivityIndicator(color: white))
                              : const Text("Login Now",
                                  style: TextStyle(color: white)),
                        ),
                      ),
                    ),
                    Helper.allowHeight(30),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
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
                            text: '\nTerms & Conditions ',
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
                        // child: const Text(
                        //   "By continuing you agree to our Terms & Conditions and Privacy Policy",
                        //   style: TextStyle(fontSize: 12, color: grey),
                        // ),
                      ),
                    )
                  ],
                )

            // state is OTPRequested
            //     ? otpViewMobile(context) :
            //     state is OTPVerified ?
            //     registerView(context)
            //     : mobileNumberView(context)
            )
      ],
    );
  }
}
