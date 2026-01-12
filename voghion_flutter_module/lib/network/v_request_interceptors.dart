import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:voghion_flutter_module/network/v_error_message_model.dart';
import 'package:voghion_flutter_module/widgets/v_toast.dart';

class VRequestInterceptors extends Interceptor {
  Future<String> getClientinfo({required String token}) async {
    // Map<String, dynamic>? info = await VFlutterNativieBridge().getDeviceInfo();
    // if (info != null) {
    //   info['userToken'] = token;
    // }
    // return json.encode(info);
    return '{"currency":"EUR","appVersion":"2.0.0","appSystemVersion":"18.5","appSystem":"iOS","clientIp":"10.104.42.121","netType":"Wi-Fi","systemZone":"GMT+08:00","deviceCode":"134BC6C6-9E9A-42D8-95BB-BBAB7FB76A9B","tradeName":"iOS","country":"GB","gender":"3","userToken":"$token","language":"en","systemCountry":"CN","systemLanguage":"en","interfaceVersion":"66","appName":"Voghion","phoneType":"iPhone15","channel":"3"}';
  }

  /// 发送请求
  /// 我们这里可以添加一些公共参数，或者对参数进行加密
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // String token = VUserService.getToken();
    String token = '';

    // String clientinfo =
    //     '{"currency":"EUR","appVersion":"2.0.0","appSystemVersion":"18.5","appSystem":"iOS","clientIp":"10.104.42.121","netType":"Wi-Fi","systemZone":"GMT+08:00","deviceCode":"134BC6C6-9E9A-42D8-95BB-BBAB7FB76A9B","tradeName":"iOS","country":"GB","gender":"3","userToken":"$token","language":"en","systemCountry":"CN","systemLanguage":"en","interfaceVersion":"66","appName":"Voghion","phoneType":"iPhone15","channel":"3"}';
    String clientinfo = await getClientinfo(token: token);
    debugPrint('hq-clientinfo:$clientinfo');
    options.headers['clientinfo'] = clientinfo;

    handler.next(options);
    // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }

  /// 响应
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('hq-onResponse');

    // 200 请求成功, 201 添加成功
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> data = response.data;
        // 处理返回的数据
        final errorMessage = VErrorMessageModel.fromJson(data);
        if (errorMessage.rtnCode != '0000') {
          String msg = errorMessage.message ?? '';
          if (msg.isEmpty) {
            msg = errorMessage.error ?? '';
          }
          if (msg.isNotEmpty) {
            VToast.show(message: msg);
          }
          _matchLogin(errorMessage: errorMessage);
        }
      }
      handler.next(response);
    }
  }

  // 退出并重新登录
  Future<void> _matchLogin({VErrorMessageModel? errorMessage}) async {
    if (errorMessage != null) {
      final rtnCode = errorMessage.rtnCode ?? '';
      if (rtnCode == '50300021' ||
          rtnCode == '50300020' ||
          rtnCode == '201000002' ||
          rtnCode == '201000003') {
        // 通知native 弹出登录页面 重新登录
      }
    }
  }

  /// 错误
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('hq-onError');
    switch (err.type) {
      case DioExceptionType.badResponse: // 服务端自定义错误体处理
        {
          final response = err.response;
          var data = response?.data;
          debugPrint('DioExceptionType.badResponse:rsp-data:$data');
          if (data == null || data is! Map<String, dynamic>) {
            // 显示错误信息
            // if (data is String) {
            //   HqToast.showToast(data);
            // }
            break;
          }
          final errorMessage = VErrorMessageModel.fromJson(data);
          switch (errorMessage.statusCode) {
            // 401 未登录
            case 401:
              // 注销 并跳转到登录页面
              _matchLogin();
              break;
            case 404:
              break;
            case 406:
              /*
             "code": 406,
              "message": "token authorization has expired"
             */
              await _matchLogin();
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
          // 显示错误信息
          if (errorMessage.message != null) {
            // HqToast.showToast(errorMessage.message!);
          }
        }
        break;
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionTimeout:
        VToast.show(message: 'Request Timeout');

        break;
      case DioExceptionType.connectionError:
        //Mac和iOS 端要配置网络权限，再试！如果还报错，就可能手机没有网络了，提醒检查网络
        VToast.show(message: 'Connect Error: Please check your network!');
        break;
      default:
        break;
    }
    DioException errNext = err.copyWith(error: err.error);
    handler.next(errNext);
  }
}
