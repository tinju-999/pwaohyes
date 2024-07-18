import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/helper.dart';

class ScreenSize extends StatelessWidget {
  final Widget? mobileView, webView;
  final Widget? tabView;
  const ScreenSize(
      {super.key,
      required this.mobileView,
      required this.webView,
      required this.tabView});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Helper.showLog('${constraints.maxWidth} -- ${Helper.width}');
      if (constraints.maxWidth < 600) {
        return mobileView!;
      } else if (constraints.maxWidth < 1000) {
        return tabView!;
      } else {
        return webView!;
      }
    });
  }
}
