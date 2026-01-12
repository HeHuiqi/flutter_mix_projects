import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter.dart';
import 'package:vg_native_mix_flutter/vg_widget_mixin.dart';
import 'package:voghion_flutter_module/pages/home/api/v_home_api.dart';
import 'package:voghion_flutter_module/pages/home/model/v_home_goods/v_home_goods.dart';
import 'package:voghion_flutter_module/pages/home/views/v_home_shop_item_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:voghion_flutter_module/widgets/v_empty_data_widget.dart';
import 'package:voghion_flutter_module/widgets/v_toast.dart';

class VHomePage extends StatefulWidget with VgWidgetMixin {
  const VHomePage({super.key, this.fromNativeOpen = false});
  @override
  final bool fromNativeOpen;

  @override
  State<VHomePage> createState() => _VHomePageState();
}

class _VHomePageState extends State<VHomePage> with VgWidgetMixinClosePage {
  late StreamSubscription<List<ConnectivityResult>>? subscription;
  int _page = 1;
  bool isLoading = true;
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  final List<VHomeGoods> _goodsList = [];

  @override
  void initState() {
    super.initState();
    _getGoodsList();
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.none)) {
        // 无网络
      } else {
        // 有网络
        setState(() {
          isLoading = true;
        });
        _getGoodsList();
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _getGoodsList() async {
    List<VHomeGoods> goods = await VHomeApi.getHomeGoodsList(page: _page);
    if (isLoading) {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      if (_page == 1 && goods.isNotEmpty) {
        _goodsList.clear();
      }
      _goodsList.addAll(goods);
      _refreshController.finishRefresh();
      if (goods.length < 10) {
        _refreshController.finishLoad(IndicatorResult.noMore);
      } else {
        _refreshController.finishLoad();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build VHomePage");
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            closePage(context: context, fromNativeOpen: widget.fromNativeOpen);
            // Navigator.pop(context);
          },
        ),
        title: Image.asset("assets/images/base/home_timg@2x.png", scale: 2),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return EasyRefresh(
      controller: _refreshController,
      onLoad: () {
        _page++;
        _getGoodsList();
      },
      onRefresh: () {
        _page = 1;
        _getGoodsList();
      },
      child: _buildWaterfall(),
    );
  }

  Widget _buildWaterfall() {
    if (_goodsList.isEmpty) {
      return VEmptyDataWidget(
        onTap: () {
          setState(() {
            isLoading = true;
          });
          _getGoodsList();
        },
      );
    }
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 10, right: 10),
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: _goodsList.length,
        itemBuilder: (context, index) {
          final goods = _goodsList[index];
          return VHomeShopItemWidget(
            goods: goods,
            onTap: (goods) {
              int goodsId = goods?.id ?? -1;
              VToast.show(message: "点击了商品$goodsId");
              VgNativeMixFlutter().openNativePageWithArgs(
                routeName: 'goodsDetail',
                args: {'goodsId': '$goodsId'},
              );
            },
          );
        },
      ),
    );
  }
}
