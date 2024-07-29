import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/common/animation.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/service/servicehomewebview.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServiceHomeTabView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeTabView({super.key, this.providerClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const WebHeader(),
            Helper.allowHeight(20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
              color: white,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: Helper.height / 1.5,
                        // padding:
                        //     const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(18.0),
                          // border: Border.all(color: primaryColor)
                          // boxShadow: <BoxShadow>[
                          //   // BoxShadow(
                          //   //   color: primaryColor.withOpacity(0.2),
                          //   //   spreadRadius: 1.5,
                          //   //   blurRadius: 2,
                          //   //   offset: const Offset(6, 0),
                          //   // )
                          // ],
                        ),
                        child: Image.network(
                          'https://scontent-maa2-2.xx.fbcdn.net/v/t39.30808-6/446789762_474325451777406_8073053602585418142_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_ohc=0uassRk9BIMQ7kNvgEfGkJR&_nc_ht=scontent-maa2-2.xx&oh=00_AYA341o2CUmQEVx6jR2H_v8v2SWlzD2CDUWDkMon1VS5uA&oe=66A7C864',
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  // Helper.allowWidth(30),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: Helper.height / 2,
                      padding: const EdgeInsets.symmetric(  
                          vertical: 0, horizontal: 0),
                      // decoration: const BoxDecoration(
                      //   color: Colors.blue,
                      // ),
                      child: Selector<ProviderClass, bool>(
                        selector: (p0, p1) => p1.showSubServices!,
                        builder: (context, value, child) =>
                            CommonAnimationSwitcher(
                          switchInCurve: Curves.linear,
                          child: value
                              ? Initializer.ohSubServices(context,
                                  Initializer.subServices, providerClass)
                              : Initializer.ohYesServices(
                                  context, Initializer.services, providerClass),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Helper.allowHeight(20),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}
