import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwaohyes/booking/bookinghome.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class Initializer {
  static DateTime now = DateTime.now();
  static DateTime selectedServiceDate = now;
  static DateTime selectedServiceTime = now;
  static List<BookingDateTimeModel> bookingTimeSuggestions = [];
  static List<BookingDateTimeModel> bookingDateSuggestions = [];
  static List chooseService = [
    {"title": "Installation", "value": "0"},
    {"title": "Repair", "value": "1"},
    {"title": "Support", "value": "2"},
    {"title": "Installation & Support", "value": "3"}
  ];
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

  static ProviderClass? providerClass;

  static Widget ohSubServices(BuildContext context, List<String> services,
          ProviderClass? providerClass) =>
      Column(
        key: const ValueKey('ohSubServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: white,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.end,
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Choose Sub-Serivces",
                    textAlign: TextAlign.center,
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
                child: SizedBox(
                  width: Helper.width / 2,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: -16.0,
                    runSpacing: 18.0,
                    children: List.generate(
                        services.length,
                        (index) => InkWell(
                              onTap: () => Helper.push(const BookingHome()),
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
                                        color:
                                            index == 0 ? primaryColor : white,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: primaryColor)),
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
                child: SizedBox(
                  width: Helper.width / 2,
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
                                        color:
                                            index == 0 ? primaryColor : white,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: primaryColor)),
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
            ),
          )
        ],
      );
}
