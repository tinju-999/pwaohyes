import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/auth/authwebregisterview.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class WebAuth extends StatelessWidget {
  const WebAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const WebHeader(route: WebAuth()),
            Helper.allowHeight(10),
            const WebAuthView(),
            Helper.allowHeight(10),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}

class WebAuthView extends StatelessWidget {
  const WebAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
          color: white,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: SizedBox(
                    width: Helper.width / 4.5,
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
                  buildWhen: (previous, current) => current is OTPRequested,
                  builder: (context, state) => AuthWebRegisterView(
                        authBloc: Initializer.authBloc,
                        providerClass: Initializer.providerClass,
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
        ),
      ),
    );
  }
}
