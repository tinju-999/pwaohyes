import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';
import 'package:pwaohyes/utils/screensize.dart';

class Header extends StatelessWidget {
  final dynamic route;
  final bool? removeBadge;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const Header(
      {super.key,
      this.route,
      required this.scaffoldKey,
      required this.removeBadge});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          current is LoggoutSuccess || current is OTPVerified,
      builder: (context, state) => ScreenSize(
        mobileView: MobileViewHeader(
          scaffoldKey: scaffoldKey,
          removeBadge: removeBadge,
        ),
        webView: const WebViewHeader(),
        tabView: MobileViewHeader(
          scaffoldKey: scaffoldKey,
          removeBadge: removeBadge,
        ),
      ),
    );
  }
}

class WebViewHeader extends StatelessWidget {
  const WebViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 46, right: 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Helper.pushNamed(allservices),
            child: Image.asset(
              logo,
              fit: BoxFit.contain,
              width: 160,
              height: 120,
            ),
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
                  InkWell(
                      onTap: () =>
                          Helper.openPage('https://ohyesworld.com/about/'),
                      child: const Text("About Us")),
                  Helper.allowWidth(20),
                  InkWell(
                      onTap: () => Helper.openPage(
                          'https://ohyesworld.com/app-download/'),
                      child: const Text("Get Started")),
                  if (Initializer.selectedAdddress!.loadingState !=
                      LoadingState.initial)
                    Helper.allowWidth(20),
                  if (Initializer.selectedAdddress!.loadingState !=
                      LoadingState.initial)
                    InkWell(
                        onTap: () => Helper.push(
                            const LocationPermissionView(route: null)),
                        child: Row(
                          children: [
                            const Icon(Icons.location_city),
                            Helper.allowWidth(5.0),
                            Text(Initializer.selectedAdddress!.locationName!),
                            Helper.allowWidth(5.0),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 16,
                            )
                          ],
                        )),
                  if (Initializer.userModel.isLoggedIn!) Helper.allowWidth(20),
                  if (Initializer.userModel.isLoggedIn!)
                    InkWell(
                        onTap: () {
                          if (Initializer.userModel.isLoggedIn!) {
                            // Initializer.authBloc.doLogout();
                            context.read<AuthBloc>().add(DoLogout());
                          } else {
                            Helper.pushAndRemoveNamedUntil(locationView);
                          }
                        },
                        child: const Text("Logout")),
                  Helper.allowWidth(20),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class MobileViewHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool? removeBadge;
  const MobileViewHeader(
      {super.key, required this.scaffoldKey, required this.removeBadge});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !removeBadge!
              ? InkWell(
                  onTap: () => Helper.pushNamed(allservices),
                  child: Image.asset(
                    logo,
                    fit: BoxFit.contain,
                    width: 100,
                    height: 80,
                  ),
                )
              : InkWell(
                  onTap: () => Helper.showSuccessMobile(),
                  child: const SizedBox(
                    width: 100,
                    height: 80,
                  ),
                ),
          Row(
            children: [
              Row(
                children: [
                  if (Initializer.selectedAdddress!.loadingState !=
                      LoadingState.initial)
                    Helper.allowWidth(20),
                  if (Initializer.selectedAdddress!.loadingState !=
                      LoadingState.initial)
                    InkWell(
                        onTap: () => Helper.push(
                            const LocationPermissionView(route: null)),
                        child: Row(
                          children: [
                            const Icon(Icons.location_city),
                            Helper.allowWidth(5.0),
                            Text(Initializer.selectedAdddress!.locationName!),
                            Helper.allowWidth(5.0),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 16,
                            )
                          ],
                        )),
                  if (Initializer.userModel.isLoggedIn!) Helper.allowWidth(20),
                  if (Initializer.userModel.isLoggedIn!)
                    InkWell(
                        onTap: () {
                          if (Initializer.userModel.isLoggedIn!) {
                            context.read<AuthBloc>().add(DoLogout());
                          } else {
                            Helper.pushAndRemoveNamedUntil(locationView);
                          }
                        },
                        child: const Text(
                          "Logout",
                          overflow: TextOverflow.ellipsis,
                        )),
                  // Helper.allowWidth(20),
                  // IconButton(
                  //     onPressed: () =>
                  //         scaffoldKey!.currentState!.openEndDrawer(),
                  //     icon: const Icon(Icons.menu))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
