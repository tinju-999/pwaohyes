import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/screensize.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: mobileView(context),
      webView: webView(context),
      tabView: tabView(context),
    );
  }

  Widget content(String content, [bool? center = false]) => Text(content,
      textAlign: center! ? TextAlign.center : TextAlign.start,
      style: const TextStyle(height: 2.0, fontFamily: quicksand));

  mobileView(BuildContext context) => Container(
      color: white,
      padding:
          const EdgeInsets.only(top: 36.0, bottom: 46, left: 26, right: 26),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.2,
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
                width: 140,
              ),
            ),
            Helper.allowHeight(25),
            SizedBox(
              width: Helper.width / 1.5,
              child: content(
                "OH YES is a digital platform where\nhundreds of services comes together.\nWe will act as service providers hub for\ncustomers",
                true,
              ),
            ),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Helper.showToast(msg: "Toast"),
                  child: content("About Us"),
                ),
                Helper.allowWidth(25),
                InkWell(
                  onTap: () => Helper.showToast(msg: "Toast"),
                  child: content("About Us"),
                ),
              ],
            ),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            content(
                "Gigvoc Technologies PVT LTD\nSpringfield Avenue NH Road\nAngamaly , Kerala 683572",
                true),
            Helper.allowWidth(20),
            content(
                "Talisman Centre, 2640 Golf Rd\nGlenview, Illinois. USA", true),
            Helper.allowWidth(20),
            content(
                "INQ Innovation Second floor, #59\n100 Feet Rd, Defence Colony\nIndiranagar, Bengaluru, Karnataka\n560038",
                true),
            Helper.allowWidth(25),
            content("support@ohyesworld.com", true),
            Helper.allowWidth(10),
            content("+91 7034444303", true),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            content("Terms & Conditions"),
            content("Privacy Policy"),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(20),
            copyright,
            Helper.allowHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  facebook,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
                Image.asset(
                  instagram,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
                Image.asset(
                  twitter,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
              ],
            ),
            Helper.allowHeight(60.0),
          ]));

  webView(BuildContext context) => Container(
      color: white,
      padding: const EdgeInsets.only(top: 8.0, bottom: 46, left: 46, right: 46),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                logo,
                fit: BoxFit.contain,
                width: 140,
                height: 140,
              ),
              // ColorFiltered(
              //   colorFilter: ColorFilter.mode(
              //       Colors.black.withOpacity(0.5), BlendMode.dstOut),
              //   child: Image.asset(
              //     logo,
              //     fit: BoxFit.contain,
              //     width: 180,
              //     height: 180,
              //   ),
              // ),
            ],
          ),
          Helper.allowHeight(5.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: content(
                  "OH YES is a digital platform where hundreds of services comes together. We will act as service providers hub for customers.",
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    content("About Us"),
                    // Helper.allowHeight(2.5),
                    content("About Us"),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    content(
                        "Gigvoc Technologies PVT LTD\nSpringfield Avenue NH Road\nAngamaly , Kerala 683572"),
                    Helper.allowHeight(10),
                    content(
                      "Talisman Centre, 2640 Golf Rd\nGlenview, Illinois. USA",
                    ),
                    Helper.allowHeight(10),
                    content(
                      "INQ Innovation Second floor, #59\n100 Feet Rd, Defence Colony\nIndiranagar, Bengaluru, Karnataka\n560038",
                    ),
                    Helper.allowHeight(10),
                    content("support@ohyesworld.com"),
                    Helper.allowHeight(10),
                    content("+91 7034444303"),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    content("Terms & Conditions"),
                    Helper.allowHeight(10),
                    content("Privacy Policy"),
                    //
                  ],
                ),
              ),
            ],
          ),
          Helper.allowHeight(20.0),
          const Divider(),
          Helper.allowHeight(30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                flex: 8,
                child: copyright,
              ),
              Row(
                children: [
                  // const Icon(Icons.apple),
                  Image.asset(
                    facebook,
                    fit: BoxFit.fitHeight,
                    height: 30,
                  ),
                  Helper.allowWidth(10),
                  Image.asset(
                    instagram,
                    fit: BoxFit.fitHeight,
                    height: 30,
                  ),
                  Helper.allowWidth(10),
                  Image.asset(
                    twitter,
                    fit: BoxFit.fitHeight,
                    height: 30,
                  ),
                  Helper.allowWidth(10),
                ],
              )
            ],
          ),
          Helper.allowHeight(60.0),
        ],
      ));

  Widget tabView(BuildContext context) => Container(
      color: white,
      padding:
          const EdgeInsets.only(top: 36.0, bottom: 46, left: 26, right: 26),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.85), BlendMode.dstOut),
              child: Image.asset(
                logo,
                fit: BoxFit.fitWidth,
                width: 160,
              ),
            ),
            Helper.allowHeight(25),
            SizedBox(
              width: Helper.width / 1.5,
              child: content(
                "OH YES is a digital platform where hundreds of\nservices comes together. We will act as service\nproviders hub for customers",
                true,
              ),
            ),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Helper.showToast(msg: "Toast"),
                  child: content("About Us"),
                ),
                Helper.allowWidth(25),
                InkWell(
                  onTap: () => Helper.showToast(msg: "Toast"),
                  child: content("About Us"),
                ),
              ],
            ),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            content(
                "Gigvoc Technologies PVT LTD\nSpringfield Avenue NH Road\nAngamaly , Kerala 683572",
                true),
            Helper.allowWidth(20),
            content(
                "Talisman Centre, 2640 Golf Rd\nGlenview, Illinois. USA", true),
            Helper.allowWidth(20),
            content(
                "INQ Innovation Second floor, #59\n100 Feet Rd, Defence Colony\nIndiranagar, Bengaluru, Karnataka\n560038",
                true),
            Helper.allowWidth(25),
            content("support@ohyesworld.com", true),
            Helper.allowWidth(10),
            content("+91 7034444303", true),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(12.5),
            content("Terms & Conditions"),
            content("Privacy Policy"),
            Helper.allowHeight(12.5),
            const Divider(),
            Helper.allowHeight(20),
            copyright,
            Helper.allowHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  facebook,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
                Image.asset(
                  instagram,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
                Image.asset(
                  twitter,
                  fit: BoxFit.fitHeight,
                  height: 25,
                ),
                Helper.allowWidth(10),
              ],
            ),
            Helper.allowHeight(60.0),
          ]));
}
