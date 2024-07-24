import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';

class OtpWebView extends StatelessWidget {
  final ProviderClass? providerClass;
  const OtpWebView({super.key, required this.providerClass});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Verify your mobile number",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          const Text(
            "Please enter the verification code send to your\nnumber +8129322316",
            style: TextStyle(
              fontSize: 14,
              color: grey,
            ),
          ),
          Helper.allowHeight(5),
          // SizedBox(
          //   width: Helper.width / 3,
          //   child: TextFormField(
          //       decoration: InputDecoration(
          //     hintText: "Mobile Number",
          //     hintStyle: const TextStyle(fontSize: 13, color: grey),
          //     border: OutlineInputBorder(
          //       borderSide: const BorderSide(color: grey),
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //   )),
          // ),
          SizedBox(
            width: Helper.width / 3,
            child: OtpTextField(
              numberOfFields: 6,
              showFieldAsBox: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              fieldWidth: 60,
            ),
          ),
          Helper.allowHeight(15),
          SizedBox(
            width: Helper.width / 3,
            child: MaterialButton(
              onPressed: () {},
              elevation: 0.0,
              color: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
              child: const Text("Verify OTP", style: TextStyle(color: white)),
            ),
          ),
          Helper.allowHeight(10),
          Selector<ProviderClass, CombinedData>(
            selector: (p0, p1) => p1.combineData,
            builder: (context, value, child) => value.isTimerRunning!
                ? RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Resent OTP in ',
                        style: TextStyle(
                          fontSize: 12,
                          color: grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: '${value.remainingTime} sec',
                        style: const TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ]),
                    // child: const Text(
                    //   "By continuing you agree to our Terms & Conditions and Privacy Policy",
                    //   style: TextStyle(fontSize: 12, color: grey),
                    // ),
                  )
                : InkWell(
                    onTap: () => providerClass!.startTimer(),
                    child: const Text("Resent OTP",
                        style: TextStyle(fontSize: 12, color: primaryColor)),
                  ),
          ),
          Helper.allowHeight(15),
          RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: 'By continuing you agree to our ',
                style: TextStyle(
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'Terms & Conditions ',
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'and ',
                style: TextStyle(
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ]),
            // child: const Text(
            //   "By continuing you agree to our Terms & Conditions and Privacy Policy",
            //   style: TextStyle(fontSize: 12, color: grey),
            // ),
          )
        ],
      ),
    );
  }
}
