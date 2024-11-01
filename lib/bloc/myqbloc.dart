import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/model/myqpadcatmodel.dart';
import 'package:pwaohyes/model/myqpadshopsmodel.dart';
import 'package:pwaohyes/model/partnerreviewmodel.dart';
import 'package:pwaohyes/model/shopslotmodel.dart';
import 'package:pwaohyes/model/shopviewmodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class MyQBloc extends Bloc<MyQEvent, MyQState> {
  MyQBloc() : super(MyQState()) {
    on<GetMyQCats>(getMyQCats);
    on<GetMyQShops>(getMyQShops);
    on<GetMyQOneShop>(getMyQOneShop);
    on<GetShopsSlots>(getShopsSlots);
    on<GetRatingList>(getRatingList);
  }

  //---------------------------------------------------------------------------

  Future<FutureOr<void>> getMyQCats(
      GetMyQCats event, Emitter<MyQState> emit) async {
    try {
      emit(GettingMyQCats());
      Response response = await ServerHelper.getMyQPost(
          '/business/category/list/users', {"page": "1", "limit": "100"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Initializer.myqpadCategoryModel =
            MyqpadCategoryModel.fromJson(jsonDecode(response.body));
        Initializer.myqpadCategoryModel.data!.cateoryList!.first.isSelected =
            true;
        Initializer.selectedMyQCategory =
            Initializer.myqpadCategoryModel.data!.cateoryList!.first.sId;
        Initializer.selectedMyQCategoryName = Initializer
            .myqpadCategoryModel.data!.cateoryList!.first.businessName!;
        add(GetMyQShops(
          query: '',
          businessName: Initializer
              .myqpadCategoryModel.data!.cateoryList!.first.businessName!,
        ));

        emit(MyQCatsFetched());
      } else {
        emit(MyQCatsNotFetched());
      }
    } catch (e) {
      Helper.showLog("Exception on getting cats $e");
      emit(GettingMyQCatsError());
    }
  }

  Future<FutureOr<void>> getMyQShops(
      GetMyQShops event, Emitter<MyQState> emit) async {
    try {
      emit(GettingShopsList());
      Response response = await ServerHelper.getMyQPost('/partner/list/user', {
        "page": "1",
        "limit": "10",
        "keyword": event.query,
        "business_category": Initializer.selectedMyQCategory,
        "lat": "10.213142",
        "lon": "76.378480"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Initializer.myqpadShopsModel =
            MyqpadShopsModel.fromJson(jsonDecode(response.body));
        await Future.delayed(const Duration(milliseconds: 1200)).then((value) {
          if (Initializer.myqpadShopsModel.data!.isNotEmpty) {
            emit(ShopsListFetched());
          } else {
            Initializer.selectedMyQCategoryName = event.businessName;
            emit(ShopsListNotFound());
          }
        });
      } else {
        emit(ShopsListNotFetched());
      }
    } catch (e) {
      Helper.showLog("Exception on getting myqshops $e");
      emit(GettingShopsListError());
    }
  }

  Future<FutureOr<void>> getMyQOneShop(
      GetMyQOneShop event, Emitter<MyQState> emit) async {
    try {
      emit(GettingOneShop());
      Response response =
          await ServerHelper.getMyQPost('/partner/view/user', {"id": event.id});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Initializer.shopViewModel =
            ShopViewModel.fromJson(jsonDecode(response.body));
        if (Initializer.shopViewModel.services!.isNotEmpty) {
          Initializer.shopViewModel.services!.first.isSelected = true;
          Initializer.selectedShopServiceId =
              Initializer.shopViewModel.services!.first.sId;
          add(GetShopsSlots(
              serviceId: Initializer.selectedShopServiceId,
              selectedSlotedServiceDate:
                  Initializer.seletedShopSlotDate.toString()));
        }
        emit(OneShopFetched());

        // getRatingList(shopId: id);
      } else {
        emit(OneShopNotFetched());
      }
    } catch (e) {
      Helper.showLog("Exception on getting myqshops $e");
      emit(GettingOneShopError());
    }
  }

  Future<FutureOr<void>> getShopsSlots(
      GetShopsSlots event, Emitter<MyQState> emit) async {
    try {
      // Initializer.selectedShopServiceId = null;
      Initializer.selectedShopSlotId = null;
      emit(GettingSlotShop());
      await Future.delayed(const Duration(milliseconds: 800)).then((_) async {
        Response response =
            await ServerHelper.getMyQPost('/booking/get/slots/user', {
          "service_id": event.serviceId,
          "date": event.selectedSlotedServiceDate.toString(),
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          Initializer.shopSlotModel =
              ShopSlotModel.fromJson(jsonDecode(response.body));
          if (Initializer.shopSlotModel.data!.isNotEmpty) {
            // Initializer.shopSlotModel.data!.first.isSelected = true;
            // Initializer.selectedShopSlotId = Initializer.shopSlotModel.data!.first.sId;
            Initializer.shopSlotModel.data!.removeWhere((e) => !e.isAvailable!);
            if (Initializer.shopSlotModel.data!.isNotEmpty) {
              emit(SlotShopFetched(data: Initializer.shopSlotModel.data!));
            } else {
              emit(SlotShopNotFound());
            }
          } else {
            emit(SlotShopNotFound());
          }
        } else {
          emit(SlotShopNotFetched());
        }
      });
    } catch (e) {
      Helper.showLog("Exception on getting myqshops $e");
      emit(GettingSlotShopError());
    }
  }

  Future<FutureOr<void>> getRatingList(
      GetRatingList event, Emitter<MyQState> emit) async {
    try {
      // emit(GettingReviews());
      Response response = await ServerHelper.getMyQPost(
          '/rating/list/partner', {
        "page": event.page,
        "limit": event.limit,
        "partnerId": event.shopId
      });
      if (response.statusCode == 200) {
        Initializer.partnerReviewModel =
            PartnerReviewModel.fromJson(jsonDecode(response.body));
        emit(RreviewsFetched());
      } else {
        // emit(RreviewsNotFetched());
      }
    } catch (e) {
      Helper.showLog("Exception on getting ratinglist $e");
      // emit(GettingReviewsError());
    }
  }
}

class MyQState {}

class MyQEvent {}

class GetMyQCats extends MyQEvent {}

class GetMyQShops extends MyQEvent {
  final String? query, businessName;
  GetMyQShops({required this.query, required this.businessName});
}

class GetShopsSlots extends MyQEvent {
  final String? serviceId, selectedSlotedServiceDate;
  GetShopsSlots(
      {required this.serviceId, required this.selectedSlotedServiceDate});
}

class GetRatingList extends MyQEvent {
  final String? page, limit, shopId;
  GetRatingList(
      {required this.page, required this.limit, required this.shopId});
}

class RreviewsFetched extends MyQState {}

class GetMyQOneShop extends MyQEvent {
  final String? id;
  GetMyQOneShop({required this.id});
}

class GettingShopsList extends MyQState {}

class ShopsListFetched extends MyQState {}

class ShopsListNotFound extends MyQState {}

class ShopsListNotFetched extends MyQState {}

class GettingShopsListError extends MyQState {}

class GettingOneShop extends MyQState {}

class OneShopFetched extends MyQState {}

class OneShopNotFetched extends MyQState {}

class GettingOneShopError extends MyQState {}

//-----------
class GettingSlotShop extends MyQState {}

class SlotShopFetched extends MyQState {
  final List<ShopSlotModelData>? data;
  SlotShopFetched({required this.data});
}

class SlotShopNotFetched extends MyQState {}

class SlotShopNotFound extends MyQState {}

class GettingSlotShopError extends MyQState {}
//---------

class GettingMyQCats extends MyQState {}

class GettingMyQCatsError extends MyQState {}

class MyQCatsFetched extends MyQState {}

class MyQCatsNotFetched extends MyQState {}
