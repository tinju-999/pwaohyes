import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/helper.dart';

//colors
const backgroundcolor = Color(0xffefefef);
const primaryColor = Color(0xffF46523);
const white = Color(0xffffffff);
const black = Color(0xff000000);
const grey = Colors.grey;

const authLogin = 'assets/loging.png';
const logo = 'assets/logo.png';
const twitter = 'assets/icons/twitter.png';
const facebook = 'assets/icons/facebook.png';
const instagram = 'assets/icons/instagram.png';
const quicksand = 'Quicksand';

const Widget copyright = Text('\u{00A9} Oh Yes. All rights reserved.',
    style: TextStyle(color: grey));

String rupeeSymbol = '\u20B9';

InputDecoration underLineInputDecoration = InputDecoration(
  counter: Helper.shrink(),
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: grey, width: 2.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
  ),
);
