import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:voghion_flutter_module/network/v_net_base_config.dart';
import 'package:voghion_flutter_module/network/v_request_interceptors.dart';
// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class VNetwork {
  static Future<Response> requestConfigInfo() {
    Map<String, String> headers = VNetworkBaseConfig.baseHeaders();
    String baseUrl = VNetworkBaseConfig.baseUrl();
    // 初始选项
    var baseOptions = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);
    // // 配置dio.HttpClientAdapter以禁用证书验证
    // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //   HttpClient client = HttpClient();
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    final rsp = dio.get('/v1/iam/temporary');
    return rsp;
  }

  static final VNetwork _instance = VNetwork._internal();
  late Dio _dio;
  factory VNetwork() {
    return _instance;
  }
  VNetwork._internal() {
    // header 头
    Map<String, String> headers = VNetworkBaseConfig.baseHeaders();
    String baseUrl = VNetworkBaseConfig.baseUrl();

    // 初始选项
    var options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 5), // 5秒
      receiveTimeout: const Duration(seconds: 10), // 3秒
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    // 配置dio.HttpClientAdapter以禁用证书验证
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    //拦截器 - 设置token等
    _dio.interceptors.add(VRequestInterceptors());

    // 拦截器 - 日志打印
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        enabled: kDebugMode,
      ),
    );
  }

  /// get 请求
  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// post 请求
  Future<Response> post(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();

    Response response = await _dio.post(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// patch 请求
  Future<Response> patch(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.patch(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// put 请求
  Future<Response> put(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.put(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// delete 请求
  Future<Response> delete(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.delete(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  // file upload 请求
  Future<Response> upload(
    String url,
    List<int> fileBytes, {
    DioMediaType? mediaType,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();

    String fileName = 'files'; // 文件名

    // 创建 FormData 对象，包含文件和其他表单字段
    FormData formData = FormData.fromMap({
      'files': MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
        contentType: mediaType,
      ),
    });

    Response response = await _dio.post(
      url,
      data: formData,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}
