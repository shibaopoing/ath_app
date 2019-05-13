import './BaseRsp.dart';

class RespObj extends BaseRsp<Map> {
  RespObj(success, code, message, data) : super(success, code, message, data);
  getBlockHash() {
    return data;
  }

  factory RespObj.fromJson(Map<String, dynamic> json) {
    return RespObj(
        json['success'], json['code'], json['message'], json['data']);
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'success': this.success,
        'code': this.code,
        'message': this.message,
        'data': this.data
      };
}
