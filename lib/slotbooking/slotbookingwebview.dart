import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/model/myqpadcatmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
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
          const Header(
                removeBadge: false,scaffoldKey: null),
          Helper.allowHeight(10),
          BlocConsumer<MyQBloc, MyQState>(
              buildWhen: (previous, current) =>
                  current is GettingMyQCats ||
                  current is MyQCatsFetched ||
                  current is MyQCatsNotFetched ||
                  current is GettingMyQCatsError,
              listener: (context, state) {},
              builder: (context, state) => state is GettingMyQCats
                  ? const Center(child: CupertinoActivityIndicator())
                  : state is MyQCatsFetched
                      ? SlotBookingWebContent(
                          data: Initializer.myqpadCategoryModel)
                      : Helper.shrink()),
          Helper.allowHeight(10),
          const Footer(),
        ],
      ),
    );
  }
}

class SlotBookingWebContent extends StatelessWidget {
  final MyqpadCategoryModel? data;
  const SlotBookingWebContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // CarouselSliderController buttonCarouselController =
    //     CarouselSliderController();
    return Column(
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
        Helper.allowHeight(40),
        titleAndSearchView(),
        Helper.allowHeight(40),
        Center(
          child: Consumer<ProviderClass>(
            builder: (context, value, child) => Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 16.0,
              children: List.generate(
                data!.data!.cateoryList!.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color:
                                    data!.data!.cateoryList![index].isSelected!
                                        ? primaryColor
                                        : Colors.transparent,
                                width: 3.0),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            if (!data!.data!.cateoryList![index].isSelected!) {
                              Initializer.providerClass!
                                  .changeSlotService(index);
                            }
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: ServerHelper.myQPadUrlImage +
                                  data!.data!.cateoryList![index].logo!,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_not_supported_rounded),
                              progressIndicatorBuilder:
                                  (context, url, progress) => const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.grey,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Helper.allowHeight(15),
                      Text(
                        data!.data!.cateoryList![index].businessName!,
                        style: TextStyle(
                          color: data!.data!.cateoryList![index].isSelected!
                              ? primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Helper.allowHeight(40),
        BlocBuilder<MyQBloc, MyQState>(
            buildWhen: (previous, current) =>
                current is GettingShopsList ||
                current is ShopsListFetched ||
                current is ShopsListNotFetched ||
                current is ShopsListNotFound ||
                current is GettingShopsListError,
            builder: (context, state) => state is ShopsListFetched
                ? serviceView(context)
                : state is GettingShopsList
                    ? const Center(child: CupertinoActivityIndicator())
                    : state is ShopsListNotFound
                        ? Center(
                            child: Text(
                            "No Shops Listed In '${Initializer.selectedMyQCategoryName}' Category",
                          ))
                        : Helper.shrink()),
        Helper.allowHeight(40),
      ],
    );
  }

  Widget serviceView(BuildContext context) => SizedBox(
        width: Helper.width / 1.2,
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 26.0,
          spacing: 26,
          children: List.generate(
            Initializer.myqpadShopsModel.data!.length,
            (index) => InkWell(
              onTap: () {
                Helper.showLog(
                    "Shop Id : ${Initializer.myqpadShopsModel.data![index].sId}");
                Navigator.pushNamed(context,
                    '/slotBookingShop?id=${Initializer.myqpadShopsModel.data![index].sId}');
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                constraints: BoxConstraints(
                  maxHeight: 150,
                  maxWidth: Helper.width / 4,
                ),
                height: 150,
                width: Helper.width / 3.5,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 01.5),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: ServerHelper.myQPadUrlImage +
                          Initializer.myqpadShopsModel.data![index].logo!,
                      fit: BoxFit.cover,
                      height: Helper.height,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported_rounded),
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.grey,
                        ),
                      ),
                      width: Helper.getPercentage(Helper.width / 3.5, 5),
                    ),
                    Helper.allowWidth(5.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Helper.toTitleCase(Initializer
                                  .myqpadShopsModel.data![index].businessName!),
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                Helper.toTitleCase(Initializer
                                    .myqpadShopsModel
                                    .data![index]
                                    .businessCategory!
                                    .businessName!),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Helper.allowHeight(2.5),
                            Expanded(
                              child: Text(
                                Helper.toTitleCase(
                                    "${Initializer.myqpadShopsModel.data![index].addressLine1!} ${Initializer.myqpadShopsModel.data![index].addressLine2 ?? ""}"),
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  overflow: TextOverflow.visible,
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
                onChanged: (value) => Initializer.myQBloc.getMyQShops(
                    query: value.toLowerCase(),
                    businessName: Initializer.selectedMyQCategoryName),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Search Shop/Services  \u{1F50D}",
                ),
              ),
            ),
          ],
        ),
      );
}
