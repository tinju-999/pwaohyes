import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/common/animation.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServiceHomeMobileView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeMobileView({super.key, required this.providerClass});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const WebHeader(),
            Helper.allowHeight(15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
              color: white,
              child: CommonAnimationSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeInSine,
                switchOutCurve: Curves.elasticOut,
                child: Selector<ProviderClass, bool>(
                  selector: (p0, p1) => p1.showSubServices!,
                  builder: (context, value, child) => CommonAnimationSwitcher(
                    duration: const Duration(milliseconds: 600),
                    switchInCurve: Curves.easeInExpo,
                    switchOutCurve: Curves.easeInOut,
                    child: value
                        ? ohMobileSubServices(context, Initializer.subServices)
                        : ohMobileYesServices(context, Initializer.services),
                  ),
                ),
              ),
            ),
            Helper.allowHeight(15),
            const WebFooter(),
          ],
        ),
      ),
    );
  }

  ohMobileSubServices(BuildContext context, List<String> subServices) => Column(
        key: const ValueKey<int>(1),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Sub Serivces",
                  style: TextStyle(
                    fontFamily: quicksand,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () => providerClass!.showSubSerives(false),
                    icon: const Icon(
                      CupertinoIcons.clear,
                      color: black,
                    )),
              )
            ],
          ),
          // Helper.allowHeight(10),
          Helper.allowHeight(5),
          SizedBox(
              width: Helper.width / 4,
              child: const Divider(
                color: primaryColor,
                thickness: 1.0,
              )),
          Helper.allowHeight(30),
          Flexible(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.only(left: 18, right: 18),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: -16.0,
                  runSpacing: 18.0,
                  children: List.generate(
                      subServices.length,
                      (index) => InkWell(
                            onTap: () => providerClass!.showSubSerives(true),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: index == 0 ? primaryColor : white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: primaryColor)),
                                  child: Icon(
                                    CupertinoIcons.home,
                                    color: index != 0 ? primaryColor : white,
                                  ),
                                ),
                                Helper.allowHeight(15),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    subServices[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: quicksand,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                ),
              ),
            ),
          )
        ],
      );
  ohMobileYesServices(BuildContext context, List<String> services) => Column(
        key: const ValueKey<int>(2),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose Category",
            style: TextStyle(
              fontFamily: quicksand,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Helper.allowHeight(10),
          Helper.allowHeight(5),
          SizedBox(
              width: Helper.width / 4,
              child: const Divider(
                color: primaryColor,
                thickness: 1.0,
              )),
          Helper.allowHeight(30),
          Flexible(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.only(left: 18, right: 18),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: -16.0,
                  runSpacing: 18.0,
                  children: List.generate(
                      services.length,
                      (index) => InkWell(
                            onTap: () => providerClass!.showSubSerives(true),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: index == 0 ? primaryColor : white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: primaryColor)),
                                  child: Icon(
                                    CupertinoIcons.home,
                                    color: index != 0 ? primaryColor : white,
                                  ),
                                ),
                                Helper.allowHeight(15),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    services[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: quicksand,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                ),
              ),
            ),
          )
        ],
      );
}
