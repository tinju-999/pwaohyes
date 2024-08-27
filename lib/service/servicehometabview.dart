import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/common/animation.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class ServiceHomeTabView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeTabView({super.key, this.providerClass});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Header(
                route: ServiceHomeTabView(providerClass: providerClass),
                scaffoldKey: scaffoldKey),
            Helper.allowHeight(20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
              color: white,
              child: Selector<ProviderClass, bool>(
                selector: (p0, p1) => p1.showSubServices!,
                builder: (context, value, child) => CommonAnimationSwitcher(
                    switchInCurve: Curves.easeInExpo,
                    switchOutCurve: Curves.easeInOut,
                    child: value ? Container() : Container()
                    // Initializer.ohYesServices(
                    //     context, Initializer.services, providerClass),
                    ),
              ),
            ),
            Helper.allowHeight(20),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
