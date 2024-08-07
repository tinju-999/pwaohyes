import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/model/servicemodel.dart';
import 'package:pwaohyes/model/subcatmodel.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServiceBloc extends Cubit<ServiceState> {
  ServiceBloc() : super(ServiceState());

  getServices() async {
    // try {
    emit(FetchingServices());
    Response response = await ServerHelper.get('home-public');
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      Initializer.serviceModel =
          ServiceModel.fromJson(jsonDecode(response.body));
      if (Initializer.serviceModel.errorCode == 0) {
        Initializer.serviceCategory = Initializer.serviceModel.data!.content!
            .where((e) => e.type == "category")
            .first
            .categoryItems!
            .toList();
        emit(ServicesFetched());
      } else {
        emit(ServicesNotFetched());
      }
    } else {
      emit(ServicesNotFetched());
    }
    // } catch (e) {
    //   Helper.showLog("Exception on services $e");
    //   emit(ServicesNotFetched());
    // }
  }

  getSubServices(String id) async {
    // try {
    emit(FetchingSubServices());
    Response response =
        await ServerHelper.get('services/by_category/without_location/$id');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Initializer.subCatModel = SubCatModel.fromJson(data);
      if (Initializer.subCatModel.errorCode == 0) {
        emit(SubServicesFetched());
      } else {
        emit(SubServicesNotFetched());
      }
    } else {
      emit(SubServicesNotFetched());
    }
    // } catch (e) {
    //   Helper.showLog("Exception on sub-services $e");
    //   emit(SubServicesNotFetched());
    // }
  }
}

class ServiceState {}

class FetchingServices extends ServiceState {}

class ServicesFetched extends ServiceState {}

class ServicesNotFetched extends ServiceState {}

class FetchingSubServices extends ServiceState {}

class SubServicesFetched extends ServiceState {}

class SubServicesNotFetched extends ServiceState {}
