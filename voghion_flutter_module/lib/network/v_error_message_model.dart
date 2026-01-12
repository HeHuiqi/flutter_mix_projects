/// 错误体信息
class VErrorMessageModel {
  int? statusCode;
  String? rtnCode;
  String? error;
  String? message;
  VErrorMessageModel({this.statusCode, this.error, this.rtnCode, this.message});
  factory VErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return VErrorMessageModel(
      statusCode: json['code'] as int?,
      rtnCode: json['rtn_code'] as String?,
      error: json['rtn_ext'] as String?,
      message: json['rtn_msg'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'error': error,
    'rtnCode': rtnCode,
    'message': message,
  };
}
