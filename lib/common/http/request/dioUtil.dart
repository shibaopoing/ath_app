import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/response/respObj.dart';

class DioUtil {
  static const String GET = "get";
  static const String POST = "post";
  static Dio _getDio = null;
  static Dio _postDio = null;
  static Response get(String url) {
    if (_getDio == null) {
      _getDio = new Dio(DioConfig.getDioOptions(GET, url));
    }
    Future<Response<String>> response = _getDio.get(url);
    response.then((Response response) async {
      return response;
    });
  }

  static Future post(String url, Map<String, dynamic> data, Function callBack,
      Function errorCallBack, BuildContext context) async {
    if (_postDio == null) {
      _postDio = new Dio(DioConfig.getDioOptions(POST, url));
    }
    Response response;
    try {
      response = await _postDio.post(url, data: data);
      Navigator.pop(context);
    } catch (exception) {
      Navigator.pop(context);
      RespObj rspObj = new RespObj(false, "", "无法连接服务器", null);
      _handError(errorCallBack, rspObj);
      return;
    }
    int statusCode = response.statusCode;
    //处理错误部分
    if (statusCode != 200) {
      RespObj rspObj = new RespObj(
          false, statusCode, response.data.toString(), response.data);
      _handError(errorCallBack, rspObj);
    } else {
      RespObj rspObj = RespObj.fromJson(response.data);
      if (rspObj.success) {
        if (callBack != null) {
          callBack(rspObj);
        }
      } else {
        _handError(errorCallBack, rspObj);
      }
    }
  }

  //处理异常
  static void _handError(Function errorCallback, RespObj rspObj) {
    if (errorCallback != null) {
      errorCallback(rspObj);
    }
  }
}

class DioConfig {
  static BaseOptions getDioOptions(String method, String url) {
    return new BaseOptions(
        method: method,
        baseUrl: Api.BaseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        followRedirects: true,
        contentType: ContentType.json);
  }
}
