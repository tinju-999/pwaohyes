import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/screensize.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenSize(
      mobileView: const Center(child: Text("mobileView")),
      webView: webView(context, Helper.width, Helper.height),
      tabView: tabView(context),
    ));
  }

  mobileView(BuildContext context) => const Center(child: Text("mobileView"));

  webView(BuildContext context, double width, double height) =>
      SingleChildScrollView(
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
                                const Icon(Icons.phone, color: primaryColor),
                                Helper.allowWidth(5.0),
                                if (PWAInstall().installPromptEnabled)
                                  InkWell(
                                    onTap: () => PWAInstall().promptInstall_(),
                                    child: const Text(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: width / 3.5,
                        child: Image.asset(
                          authLogin,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Helper.allowWidth(120),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "WebView",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                        ),
                        const Text(
                          "Please enter your mobile number here",
                          style: TextStyle(
                            fontSize: 14,
                            color: grey,
                          ),
                        ),
                        Helper.allowHeight(5),
                        SizedBox(
                          width: width / 3,
                          child: TextFormField(
                              decoration: InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle:
                                const TextStyle(fontSize: 13, color: grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                        ),
                        Helper.allowHeight(15),
                        SizedBox(
                          width: width / 3,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 0.0,
                            color: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 14),
                            child: const Text("Get OTP",
                                style: TextStyle(color: white)),
                          ),
                        ),
                        Helper.allowHeight(20),
                        const Text(
                          "By continuing you agree to our Terms & Conditions and Privacy Policy",
                          style: TextStyle(fontSize: 12, color: grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Helper.allowHeight(15),
            Container(
                color: white,
                width: Helper.width,
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 46, left: 46, right: 46),
                child: Row(
                  children: [
                    Column(
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
                    )
                  ],
                )),
          ],
        ),
      );

  tabView(BuildContext context) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: Helper.height / 1.5,
                child: Image.asset(
                  authLogin,
                  fit: BoxFit.cover,
                ),
              ),
              Helper.allowWidth(20),
              Expanded(
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
                      hintStyle: const TextStyle(fontSize: 13, color: grey),
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
                        child: const Text("Get OTP",
                            style: TextStyle(color: white)),
                      ),
                    ),
                    Helper.allowHeight(10),
                    const Text(
                        "By continuing you agree to our Terms & Conditions and Privacy Policy",
                        style: TextStyle(fontSize: 12, color: grey),
                        textAlign: TextAlign.start)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
