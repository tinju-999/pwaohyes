import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class WebHeader extends StatelessWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Helper.allowWidth(20),
                  const Text("Blog"),
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
