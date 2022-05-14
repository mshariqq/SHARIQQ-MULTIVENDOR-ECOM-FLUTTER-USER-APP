import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/datasource/remote/dio/dio_client.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/datasource/remote/exception/api_error_handler.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/response/base/api_response.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/app_constants.dart';

class BrandRepo {
  final DioClient dioClient;
  BrandRepo({@required this.dioClient});

  Future<ApiResponse> getBrandList() async {
    try {
      final response = await dioClient.get(AppConstants.BRANDS_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
