import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class AddReviewMobile extends StatelessWidget {
  final String? shopName, shopCat, partnerId, shopId;
  const AddReviewMobile(
      {super.key, this.shopName, this.shopCat, this.partnerId, this.shopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ReviewAdded) {
            Helper.pop();
            context.read<MyQBloc>().add(GetRatingList(
                  page: '1',
                  limit: '100',
                  shopId: Initializer.shopViewModel.data!.sId,
                ));
            context.read<AuthBloc>().add(
                  GetMyReview(
                    partnerId: Initializer.shopViewModel.data!.sId,
                    phoneNo: Initializer.userModel.phone,
                  ),
                );
          }
        },
        child: ListView(
          children: [
            const Header(
              scaffoldKey: null,
              removeBadge: true,
            ),
            Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 26),
              width: Helper.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.grey.withOpacity(0.2), // Light grey shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(
                        0, 3), // Horizontal and vertical shadow offset
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Helper.allowHeight(15),
                  Text(shopName!),
                  Helper.allowHeight(5),
                  Text(shopCat!),
                  Helper.allowHeight(10),
                  RatingBar.builder(
                    onRatingUpdate: (value) =>
                        Initializer.providerClass?.updateRating(value),
                    unratedColor: Colors.grey,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    initialRating: Initializer.providerClass!.ratingValue,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  // Helper.allowHeight(2.5),
                  // Selector<ProviderClass, double>(
                  //   selector: (p0, p1) => p1.ratingValue,
                  //   builder: (context, value, child) => Text(
                  //     value.toString(),
                  //     style: const TextStyle(fontSize: 18),
                  //   ),
                  // ),
                  Helper.allowHeight(15),
                  TextFormField(
                    maxLines: 6,
                    controller: Initializer.ratingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Write a review",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Helper.allowHeight(15),
                  SizedBox(
                    width: Helper.width,
                    child: Selector<ProviderClass, double>(
                      selector: (p0, p1) => p1.ratingValue,
                      builder: (context, value, child) => MaterialButton(
                        onPressed: () {
                          if (value > 0.0) {
                            context
                                .read<ServiceBloc>()
                                .add(AddCustomerReview(map: {
                                  "rating": value.toString(),
                                  "review": Initializer.ratingController!.text,
                                  "partner_id": partnerId,
                                  "phone_no": Initializer.userModel.phone,
                                  "id": Initializer.myReviewId,
                                }));
                          } else {
                            Helper.showLog("disabled");
                          }
                          // if (!Initializer.userModel.isLoggedIn!) {
                          //   showAuthView(context, formKey, phoneController,
                          //       otpController, false);
                          // } else {
                          //   Helper.pushNamed(addReviewPage);
                          // }
                        },
                        elevation: 5.0,
                        color: value > 0.0 ? primaryColor : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: const Text("Submit Reiew",
                            style: TextStyle(color: white, fontFamily: "")),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
