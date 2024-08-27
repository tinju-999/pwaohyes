import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class SlotBookingWebView extends StatelessWidget {
  const SlotBookingWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(scaffoldKey: null),
          Helper.allowHeight(10),
          const SlotBookingWebContent(),
          Helper.allowHeight(10),
          const Footer(),
        ],
      ),
    );
  }
}

class SlotBookingWebContent extends StatelessWidget {
  const SlotBookingWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    // CarouselSliderController buttonCarouselController =
    //     CarouselSliderController();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      color: white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CarouselSlider.builder(
          //   carouselController: buttonCarouselController,
          //   itemCount: Initializer.carouselItems.length,
          //   itemBuilder: (context, index, realIndex) => SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: Image.network(
          //       Initializer.carouselItems[index],
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   options: CarouselOptions(
          //       height: 300.0,
          //       autoPlay: true,
          //       autoPlayInterval: const Duration(seconds: 3),
          //       enlargeStrategy: CenterPageEnlargeStrategy.scale),
          // ),
          Helper.allowHeight(30),
          titleAndSearchView(),
          Helper.allowHeight(40),
          Center(
            child: Wrap(
              runSpacing: 16.0,
              children: List.generate(
                // Initializer.serviceImageUrls.length > 8
                //     ? 8
                //     :
                Initializer.serviceImageUrls.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: primaryColor, width: 2.0),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                            Initializer.serviceImageUrls[index],
                          ),
                          radius: 40,
                        ),
                      ),
                      Helper.allowHeight(15),
                      const Text(("Service Name"))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Helper.allowHeight(40),
          serviceView(),
          Helper.allowHeight(40),
        ],
      ),
    );
  }

  Widget serviceView() => SizedBox(
        width: Helper.width / 1.2,
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 26.0,
          spacing: 26,
          children: List.generate(
            4,
            (index) => Container(
              clipBehavior: Clip.hardEdge,
              constraints: BoxConstraints(
                maxHeight: 150,
                maxWidth: Helper.width / 4.5,
              ),
              height: 150,
              width: Helper.width / 4.5,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.blueGrey, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    Initializer.serviceImageUrls.last,
                    fit: BoxFit.cover,
                    height: Helper.height,
                    width: Helper.getPercentage(Helper.width / 4.5, 4),
                  ),
                  Helper.allowWidth(5.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            child: Text(
                              "Pet Shop",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Flexible(
                            child: Text(
                              "Pet Shop",
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Helper.allowHeight(2.5),
                          const Flexible(
                            child: Text(
                              "Aju Alex Manakkattu Vengathanam PO Palapra, Parathodu 686512",
                              maxLines: 6,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget titleAndSearchView() => SizedBox(
        width: Helper.width / 1.5,
        child: Column(
          children: [
            const Text(
              "Services",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Find The Perfect Service For You",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
              textAlign: TextAlign.center,
            ),
            Helper.allowHeight(15),
            SizedBox(
              width: Helper.width / 3.5,
              child: TextFormField(
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) =>
                    null,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                // controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "Search Services  \u{1F50D}"),
              ),
            ),
          ],
        ),
      );
}
