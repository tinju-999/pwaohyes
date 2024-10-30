import 'package:flutter/material.dart';
import 'package:pwaohyes/model/partnerreviewmodel.dart';
import 'package:pwaohyes/review/addreviewmobile.dart';
import 'package:pwaohyes/review/addreviewweb.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/screensize.dart';

class AddReviewPage extends StatefulWidget {
  final String? shopName,
      shopCat,
      partnerId,
      shopId,
      rating,
      comment,
      commentId;
  const AddReviewPage({
    super.key,
    this.shopCat,
    this.shopName,
    this.partnerId,
    this.shopId,
    this.commentId,
    this.rating,
    this.comment,
  });

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  Map data = {};
  @override
  void initState() {
    if (widget.commentId != null) {
      Initializer.providerClass!.setRatingValue(widget.rating);
      Initializer.ratingController!.text = widget.comment!;
      Initializer.myReviewId = widget.commentId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: AddReviewMobile(
        shopCat: widget.shopCat,
        shopName: widget.shopName,
        partnerId: widget.partnerId,
        shopId: widget.shopId,
      ),
      webView: const AddReviewWeb(),
      tabView: const AddReviewWeb(),
    );
  }
}
