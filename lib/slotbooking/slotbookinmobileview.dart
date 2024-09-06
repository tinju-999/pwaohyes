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

class SlotBookingMobileView extends StatelessWidget {
  const SlotBookingMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(scaffoldKey: null,    removeBadge: false,),
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
                  : SlotBookingMobileContent(
                      data: Initializer.myqpadCategoryModel)),
          Helper.allowHeight(10),
          const Footer(),
        ],
      ),
    );
  }
}

class SlotBookingMobileContent extends StatelessWidget {
  final MyqpadCategoryModel? data;
  const SlotBookingMobileContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Helper.allowHeight(30),
        titleAndSearchView(),
        Helper.allowHeight(20),
        Consumer<ProviderClass>(
          builder: (context, value, child) => SizedBox(
            width: Helper.width / 1.2,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 12,
              spacing: 12,
              children: List.generate(
                data!.data!.cateoryList!.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: data!.data!.cateoryList![index].isSelected!
                                  ? primaryColor
                                  : Colors.transparent,
                              width: 3.0),
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          if (!data!.data!.cateoryList![index].isSelected!) {
                            Initializer.providerClass!.changeSlotService(index);
                          }
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 55,
                          height: 55,
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
                    Helper.allowHeight(7.5),
                    SizedBox(
                      width: Helper.width / 5,
                      child: Text(
                        data!.data!.cateoryList![index].businessName!,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: data!.data!.cateoryList![index].isSelected!
                              ? primaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
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
                            style: const TextStyle(fontSize: 12),
                          ))
                        : Helper.shrink()),
      ],
    );
  }

  Widget serviceView(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: List.generate(
            Initializer.myqpadShopsModel.data!.length,
            (index) => Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context,
                      '/slotBookingShop?id=${Initializer.myqpadShopsModel.data![index].sId}'),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      maxWidth: Helper.width,
                    ),
                    width: Helper.width,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey, width: 01.5),
                      borderRadius: BorderRadius.circular(12.0),
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
                            child:
                                CupertinoActivityIndicator(color: Colors.grey),
                          ),
                          width: Helper.getPercentage(Helper.width, 5),
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
                                      .myqpadShopsModel
                                      .data![index]
                                      .businessName!),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
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
                if (index != Initializer.myqpadShopsModel.data!.length + 1)
                  Helper.allowHeight(15)
              ],
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: Helper.width / 1.2,
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
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  hintText: "Search Shop/Services  \u{1F50D}",
                ),
              ),
            ),
          ],
        ),
      );
}
