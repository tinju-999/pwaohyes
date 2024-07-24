import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/auth/authwebphoneview.dart';
import 'package:pwaohyes/auth/authwebregisterview.dart';
import 'package:pwaohyes/auth/otpwebview.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/screensize.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc? authBloc;
  ProviderClass? providerClass;
  @override
  initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    providerClass = context.read<ProviderClass>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ScreenSize(
        mobileView: mobileAuthView(context),
        webView: webView(context, Helper.width, Helper.height),
        tabView: tabView(context),
      )),
    );
  }

  mobileView(BuildContext context) => const Center(child: Text("mobileView"));

  webView(BuildContext context, double width, double height) => Expanded(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: white,
                  padding: const EdgeInsets.only(left: 46, right: 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        logo,
                        fit: BoxFit.contain,
                        width: 120,
                        height: 100,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone,
                                        color: primaryColor),
                                    Helper.allowWidth(10.0),
                                    const InkWell(
                                      // onTap: () => PWAInstall().promptInstall_(),
                                      child: Text(
                                        "Call +91 7034444303",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    // if (PWAInstall().installPromptEnabled)
                                    //   InkWell(
                                    //     onTap: () => PWAInstall().promptInstall_(),
                                    //     child: const Text(
                                    //       "Call +91 7034444303",
                                    //       style: TextStyle(
                                    //         fontSize: 16,
                                    //         color: primaryColor,
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                              Helper.allowWidth(30),
                              const Text("About Us"),
                              Helper.allowWidth(20),
                              const Text("Get Started"),
                              Helper.allowWidth(20),
                              const Text("Blog"),
                              Helper.allowWidth(20),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Helper.allowHeight(60),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: SizedBox(
                          width: width / 4,
                          child: Image.asset(
                            authLogin,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Helper.allowWidth(120),
                    // const OtpWebView(),
                    BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (previous, current) =>
                            current is OTPRequested,
                        builder: (context, state) => AuthWebRegisterView(
                              authBloc: authBloc,
                              providerClass: providerClass,
                            )
                        // state is OTPRequested
                        //     ? OtpWebView(providerClass: providerClass)
                        //     : AuthWebPhoneView(
                        //         authBloc: authBloc,
                        //         providerClass: providerClass,
                        //       ),
                        ),
                  ],
                ),
                Helper.allowHeight(60),
                Container(
                    color: white,
                    width: Helper.width,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 46, left: 46, right: 46),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          logo,
                          fit: BoxFit.contain,
                          width: 120,
                          height: 100,
                        ),
                        Helper.allowHeight(5.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "OH YES is a digital platform where\nhundreds of services comes\ntogether. We will act as service\nproviders hub for customers.",
                              style: TextStyle(height: 2.0),
                            ),
                            Helper.allowWidth(60),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("About Us"),
                                Helper.allowHeight(10.0),
                                const Text("Get Started"),
                                Helper.allowHeight(10.0),
                                const Text("Contact Us"),
                              ],
                            ),
                            Helper.allowWidth(60),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Gigvoc Technologies PVT LTD\nSpringfield Avenue NH Road\nAngamaly , Kerala 683572",
                                  style: TextStyle(height: 2.0),
                                ),
                                Helper.allowHeight(10.0),
                                const Text(
                                  "Talisman Centre, 2640 Golf Rd\nGlenview, Illinois. USA",
                                  style: TextStyle(height: 2.0),
                                ),
                                Helper.allowHeight(10.0),
                                const Text(
                                  "INQ Innovation Second floor, #59\n100 Feet Rd, Defence Colony\nIndiranagar, Bengaluru, Karnataka\n560038",
                                  style: TextStyle(height: 2.0),
                                ),
                                Helper.allowHeight(10.0),
                                const Text("support@ohyesworld.com"),
                                Helper.allowHeight(10.0),
                                const Text("+91 7034444303"),
                              ],
                            ),
                            Helper.allowWidth(60),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(height: 2.0),
                                ),
                                Helper.allowHeight(5.0),
                                const Text(
                                  "Privacy Policy",
                                  style: TextStyle(height: 2.0),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      );

  tabView(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.only(left: 46, right: 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    fit: BoxFit.contain,
                    width: 120,
                    height: 100,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                const Icon(Icons.phone, color: primaryColor),
                                Helper.allowWidth(5.0),
                                const InkWell(
                                  // onTap: () => PWAInstall().promptInstall_(),
                                  child: Text(
                                    "Call +91 7034444303",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                // if (PWAInstall().installPromptEnabled)
                                //   InkWell(
                                //     onTap: () => PWAInstall().promptInstall_(),
                                //     child: const Text(
                                //       "Call +91 7034444303",
                                //       style: TextStyle(
                                //         fontSize: 16,
                                //         color: primaryColor,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                          Helper.allowWidth(30),
                          const Text("About Us"),
                          Helper.allowWidth(20),
                          const Text("Get Started"),
                          Helper.allowWidth(20),
                          const Text("Blog"),
                          Helper.allowWidth(20),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Helper.allowHeight(15),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        height: Helper.height / 1.5,
                        child: Image.asset(
                          authLogin,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Helper.allowWidth(20),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "TabView",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                          const Text(
                            "Please enter your mobile number here",
                            style: TextStyle(
                              fontSize: 12,
                              color: grey,
                            ),
                          ),
                          Helper.allowHeight(5),
                          TextFormField(
                              decoration: InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle:
                                const TextStyle(fontSize: 13, color: grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                          Helper.allowHeight(15),
                          SizedBox(
                            width: Helper.width,
                            child: MaterialButton(
                              onPressed: () {},
                              elevation: 0.0,
                              color: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 14),
                              child: const Text(
                                "Get OTP",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Helper.allowHeight(40),
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
        ),
      );

  mobileAuthView(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: SafeArea(
          child: Column(
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
                  builder: (context, state) => registerView(context)
                  // state is OTPRequested
                  //     ? otpViewMobile(context) :
                  //     state is OTPVerified ?
                  //     registerView(context)
                  //     : mobileNumberView(context)
                  )
            ],
          ),
        ),
      );

  mobileNumberView(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Welcome  to OhYes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          const Text(
            "Please enter your mobile number here",
            style: TextStyle(color: grey, fontSize: 16),
          ),
          Helper.allowHeight(10),
          SizedBox(
            width: Helper.width,
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is OTPRequested) {
                providerClass!.startTimer();
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
                    ? authBloc!.verifyPhone()
                    : Helper.showToast(msg: "Please wait"),
                elevation: 5.0,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                child: state is RequestingOTP
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: white))
                    : const Text("Get OTP", style: TextStyle(color: white)),
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
      );

  otpViewMobile(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Verify Your Mobile Number",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          const Text(
            "Please enter the verification code send to your number +8129322316",
            style: TextStyle(color: grey, fontSize: 14),
          ),
          Helper.allowHeight(10),
          OtpTextField(
            numberOfFields: 6,
            showFieldAsBox: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: Helper.width / 8,
          ),
          Helper.allowHeight(15),
          SizedBox(
            width: Helper.width,
            child: MaterialButton(
              onPressed: () => {},
              elevation: 5.0,
              color: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
              child: const Text("Verify OTP", style: TextStyle(color: white)),
            ),
          ),
          Helper.allowHeight(30),
          Selector<ProviderClass, CombinedData>(
            selector: (p0, p1) => p1.combineData,
            builder: (context, value, child) => value.isTimerRunning!
                ? SizedBox(
                    width: Helper.width,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Resent OTP in ',
                          style: TextStyle(
                            fontSize: 12,
                            color: grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: '${value.remainingTime} sec',
                          style: const TextStyle(
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
                : Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => providerClass!.startTimer(),
                      child: const Text("Resent OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: primaryColor)),
                    ),
                  ),
          ),
          Helper.allowHeight(15),
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
      );

  registerView(BuildContext context) => Column(
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
                providerClass!.startTimer();
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
                    ? authBloc!.verifyPhone()
                    : Helper.showToast(msg: "Please wait"),
                elevation: 5.0,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                child: state is RequestingOTP
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: white))
                    : const Text("Register Now",
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
      );
}
