import 'dart:async';

import 'package:carousel_demo/repos/endpoint.dart';
import 'package:carousel_demo/repos/models/user_model.dart';
import 'package:carousel_demo/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../flt_exception.dart';

class RemoteProvider {
  Dio _dio;

  RemoteProvider({String baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
    );
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(
      responseBody: false,
      //true,
      responseHeader: false,
      error: true,
      request: true,
      requestHeader: true,
      requestBody: true,
    ));
  }

  Future<Response> _get({
    @required String requestName,
    @required String path,
    Map<String, dynamic> queryParams,
  }) async {
    Response response;
    response = await _dio.get(path, queryParameters: queryParams);
    print('$requestName response=${response.toString()}');
    return response;
  }

  Future<T> _handleGet<T>({
    @required String requestName,
    @required String path,
    Map<String, dynamic> queryParams,
    @required T Function(Response<dynamic>) convertToModel,
  }) async {
    try {
      final response = await _get(
        requestName: requestName,
        path: path,
        queryParams: queryParams,
      );
      return convertToModel(response);
    } on Exception catch (e) {
      final ex = ExceptionHelper.newInstance(e, endpoint: path);
      print('GET requestName=$requestName failed: ${ex.message}');
      throw ex;
    }
  }

  Future<UserModel> getUser() async {
    return _handleGet(
        requestName: 'getUser',
        path: AppUtils.mapURLPatternValue(Endpoint.getUser),
        convertToModel: (response) {
          return UserModel.fromJson(response.data);
        });
  }
}
