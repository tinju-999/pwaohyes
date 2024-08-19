import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/screensize.dart';

class WebHeader extends StatelessWidget {
  final dynamic route;
  const WebHeader({super.key, this.route});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          current is LoggoutSuccess || current is OTPVerified,
      builder: (context, state) => ScreenSize(
        mobileView: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  logo,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Karukutty, Angamali"),
                    Helper.allowWidth(5.0),
                    const Icon(CupertinoIcons.chevron_down,
                        color: black, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        webView: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 46, right: 46),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                fit: BoxFit.contain,
                width: 160,
                height: 120,
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
                          ],
                        ),
                      ),
                      Helper.allowWidth(30),
                      const Text("About Us"),
                      Helper.allowWidth(20),
                      const Text("Get Started"),
                      if (Initializer.selectedAdddress!.state ==
                          LoadingState.success)
                        Helper.allowWidth(20),
                      if (Initializer.selectedAdddress!.state ==
                          LoadingState.success)
                        InkWell(
                            onTap: () => Helper.push(
                                LocationPermissionView(route: route)),
                            child: Row(
                              children: [
                                const Icon(Icons.location_city),
                                Helper.allowWidth(5.0),
                                Text(Initializer
                                    .selectedAdddress!.locationName!),
                                Helper.allowWidth(5.0),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 16,
                                )
                              ],
                            )),
                      if (Initializer.userModel.isLoggedIn!)
                        Helper.allowWidth(20),
                      if (Initializer.userModel.isLoggedIn!)
                        InkWell(
                            onTap: () => Initializer.authBloc.doLogout(),
                            child: const Text("Logout")),
                      Helper.allowWidth(20),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        tabView: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          decoration: const BoxDecoration(color: white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  logo,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Karukutty, Angamali"),
                    Helper.allowWidth(5.0),
                    const Icon(CupertinoIcons.chevron_down,
                        color: black, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
