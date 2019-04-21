import 'package:flutter/material.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/request/dioUtil.dart';
import 'package:ath_app/common/http/response/respObj.dart';
import 'package:ath_app/common/loadingDialog.dart';
//要查网络请求的日志可以使用过滤<net>
class HttpUtils {
  //get请求
  static void get(String url, Function callBack,BuildContext context,
      {Map<String, String> params, Function errorCallBack}) async {
    _request(Api.BaseUrl + url, callBack,context,
        method:DioUtil.GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void post(String url, Function callBack,BuildContext context,
      {Map<String, dynamic> params, Function errorCallBack}) async {
         _request(url, callBack,context,
        method: DioUtil.POST, params: params, errorCallBack: errorCallBack);
  }

  //具体的还是要看返回数据的基本结构
  //公共代码部分
  static void _request(String url, Function callBack,BuildContext context,
      {String method,
        Map<String, dynamic> params,
        Function errorCallBack}) async {
    try {
      if (method == DioUtil.GET) {
        //组合GET请求的参数
        if (params != null) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        //response =DioUtil.get(url);
      } else {
        if (params == null) {
          params = new Map();
        }
       // response = await DioUtil.post(url,params);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return new NetLoadingDialog(
                loadingText:"请稍后...",
                url:url,
                params: params,
                callBack: callBack,
                errorCallBack:errorCallBack ,
                context: context,
                outsideDismiss: true,
              );
            });
      }
    } catch (exception) {
      RespObj rspObj =new RespObj(false, "","无法连接服务器", null);
      _handError(errorCallBack,rspObj);
    }
  }
  //处理异常
  static void _handError(Function errorCallback,RespObj rspObj) {
    if (errorCallback != null) {
      errorCallback(rspObj);
    }
  }
}