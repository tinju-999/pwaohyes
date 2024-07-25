import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: white,
        width: Helper.width,
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 46, left: 46, right: 46),
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
                  style: TextStyle(height: 2.0, fontFamily: quicksand),
                ),
                Helper.allowWidth(60),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About Us",
                      style: TextStyle(fontFamily: quicksand),
                    ),
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
            ),
            Helper.allowHeight(20.0),
            const Divider(),
            Helper.allowHeight(30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("@Oh Yes. All rights reserved"),
                Row(
                  children: [
                    const Icon(Icons.apple),
                    Helper.allowWidth(10),
                    const Icon(Icons.apple),
                    Helper.allowWidth(10),
                    const Icon(Icons.apple),
                    Helper.allowWidth(10),
                  ],
                )
              ],
            ),
            Helper.allowHeight(60.0),
          ],
        ));
  }
}
