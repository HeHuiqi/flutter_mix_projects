import 'package:dio/dio.dart';
import 'package:voghion_flutter_module/network/v_network.dart';
import 'package:voghion_flutter_module/pages/home/model/v_home_goods/v_home_goods.dart';

class VHomeApi {
  static Future<List<VHomeGoods>> getHomeGoodsList({int page = 1}) async {
    Map<String, dynamic> params = {
      'pageNow': page,
      'pageSize': 10,
      'source': 3,
    };
    List<VHomeGoods> goodsList = [];
    try {
      Response rsp = await VNetwork().post(
        '/cms/pageTab/pageGoods',
        data: params,
      );
      Map<String, dynamic>? data = rsp.data['data'];
      if (data == null) {
        return goodsList;
      }
      List<dynamic> goods = data['records'];
      goodsList = goods.map((e) => VHomeGoods.fromMap(e)).toList();
      return goodsList;
    } catch (e) {
      return goodsList;
    }
  }
}
