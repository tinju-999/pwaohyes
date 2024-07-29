import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class Initializer {
  static List<String> services = [
    "Home Builders",
    "Electrician",
    "Plumber",
    "AC Mechanic",
    "Appliances Repair",
    "Gardening",
    "Painting",
    "Cleaning And Pest",
    "Interior",
  ];
  static List<String> subServices = [
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
  ];

  static Widget ohSubServices(BuildContext context, List<String> services,
          ProviderClass? providerClass) =>
      Column(
        key: const ValueKey('ohSubServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Sub Serivces",
            style: TextStyle(
              fontFamily: quicksand,
              fontSize: 32,
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
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: -16.0,
                  runSpacing: 18.0,
                  children: List.generate(
                      services.length,
                      (index) => InkWell(
                            onTap: () => providerClass!.showSubSerives(false),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: 75,
                                  height: 75,
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
                                    "${services[index]} $index",
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

  static ohYesServices(BuildContext context, List<String> services,
          ProviderClass? providerClass) =>
      Column(
        key: const ValueKey('ohYesServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Services",
            style: TextStyle(
              fontFamily: quicksand,
              fontSize: 32,
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
              padding: const EdgeInsets.only(left: 18, right: 18),
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
                                  width: 75,
                                  height: 75,
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
