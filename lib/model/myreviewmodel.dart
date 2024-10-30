import 'package:pwaohyes/model/partnerreviewmodel.dart';

class MyReviewModel {
  bool? status;
  bool? review;
  PartnerReviewData? data;
  String? message;

  MyReviewModel({this.status, this.review, this.data, this.message});

  MyReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    review = json['review'];
    data = json['data'] != null ? PartnerReviewData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['review'] = review;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class MyReviewData {
  String? sId;
  String? customerName;
  bool? isBookingReview;
  int? rating;
  String? status;
  String? partnerId;
  String? phoneNo;
  String? review;
  String? createDate;
  String? updateDate;
  int? iV;

  MyReviewData(
      {this.sId,
      this.customerName,
      this.isBookingReview,
      this.rating,
      this.status,
      this.partnerId,
      this.phoneNo,
      this.review,
      this.createDate,
      this.updateDate,
      this.iV});

  MyReviewData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerName = json['customerName'];
    isBookingReview = json['isBookingReview'];
    rating = json['rating'];
    status = json['status'];
    partnerId = json['partner_id'];
    phoneNo = json['phoneNo'];
    review = json['review'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerName'] = customerName;
    data['isBookingReview'] = isBookingReview;
    data['rating'] = rating;
    data['status'] = status;
    data['partner_id'] = partnerId;
    data['phoneNo'] = phoneNo;
    data['review'] = review;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
  }
}
