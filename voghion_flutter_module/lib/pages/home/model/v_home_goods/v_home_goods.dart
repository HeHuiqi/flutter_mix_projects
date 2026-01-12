import 'dart:convert';

import 'tag_info_list.dart';
import 'tag_info_map.dart';

class VHomeGoods {
  String? dataType;
  dynamic site;
  String? type;
  String? value;
  String? imgUrl;
  dynamic recommendGoodsImg;
  String? title;
  dynamic subTitle;
  dynamic sort;
  dynamic imgUrlW;
  dynamic imgUrlH;
  int? id;
  dynamic videoUrl;
  double? price;
  double? marketPrice;
  dynamic grouponPrice;
  String? extraInfo;
  int? goodsId;
  int? sales;
  int? sold;
  dynamic description;
  DateTime? createTime;
  dynamic endTime;
  String? goodsName;
  String? originalName;
  dynamic remainLeft;
  String? discountLabel;
  dynamic tagList;
  dynamic routeUrl;
  dynamic onlyGoodsId;
  int? productType;
  dynamic selectedItem;
  dynamic goodsDesc;
  dynamic stock;
  double? score;
  int? commentNumber;
  int? shopId;
  String? shopName;
  dynamic shopScore;
  dynamic shopCommentNumber;
  dynamic qualityStoreImgsVo;
  dynamic goodsCardVo;
  int? categoryId;
  List<TagInfoList>? tagInfoList;
  TagInfoMap? tagInfoMap;
  dynamic status;
  dynamic skuId;
  bool? wishGoods;
  bool? valid;

  VHomeGoods({
    this.dataType,
    this.site,
    this.type,
    this.value,
    this.imgUrl,
    this.recommendGoodsImg,
    this.title,
    this.subTitle,
    this.sort,
    this.imgUrlW,
    this.imgUrlH,
    this.id,
    this.videoUrl,
    this.price,
    this.marketPrice,
    this.grouponPrice,
    this.extraInfo,
    this.goodsId,
    this.sales,
    this.sold,
    this.description,
    this.createTime,
    this.endTime,
    this.goodsName,
    this.originalName,
    this.remainLeft,
    this.discountLabel,
    this.tagList,
    this.routeUrl,
    this.onlyGoodsId,
    this.productType,
    this.selectedItem,
    this.goodsDesc,
    this.stock,
    this.score,
    this.commentNumber,
    this.shopId,
    this.shopName,
    this.shopScore,
    this.shopCommentNumber,
    this.qualityStoreImgsVo,
    this.goodsCardVo,
    this.categoryId,
    this.tagInfoList,
    this.tagInfoMap,
    this.status,
    this.skuId,
    this.wishGoods,
    this.valid,
  });

  factory VHomeGoods.fromMap(Map<String, dynamic> data) => VHomeGoods(
    dataType: data['dataType'] as String?,
    site: data['site'] as dynamic,
    type: data['type'] as String?,
    value: data['value'] as String?,
    imgUrl: data['imgUrl'] as String?,
    recommendGoodsImg: data['recommendGoodsImg'] as dynamic,
    title: data['title'] as String?,
    subTitle: data['subTitle'] as dynamic,
    sort: data['sort'] as dynamic,
    imgUrlW: data['imgUrlW'] as dynamic,
    imgUrlH: data['imgUrlH'] as dynamic,
    id: data['id'] as int?,
    videoUrl: data['videoUrl'] as dynamic,
    price: (data['price'] as num?)?.toDouble(),
    marketPrice: (data['marketPrice'] as num?)?.toDouble(),
    grouponPrice: data['grouponPrice'] as dynamic,
    extraInfo: data['extraInfo'] as String?,
    goodsId: data['goodsId'] as int?,
    sales: data['sales'] as int?,
    sold: data['sold'] as int?,
    description: data['description'] as dynamic,
    createTime: data['createTime'] == null
        ? null
        : DateTime.parse(data['createTime'] as String),
    endTime: data['endTime'] as dynamic,
    goodsName: data['goodsName'] as String?,
    originalName: data['originalName'] as String?,
    remainLeft: data['remainLeft'] as dynamic,
    discountLabel: data['discountLabel'] as String?,
    tagList: data['tagList'] as dynamic,
    routeUrl: data['routeUrl'] as dynamic,
    onlyGoodsId: data['onlyGoodsId'] as dynamic,
    productType: data['productType'] as int?,
    selectedItem: data['selectedItem'] as dynamic,
    goodsDesc: data['goodsDesc'] as dynamic,
    stock: data['stock'] as dynamic,
    score: data['score'] as double?,
    commentNumber: data['commentNumber'] as int?,
    shopId: data['shopId'] as int?,
    shopName: data['shopName'] as String?,
    shopScore: data['shopScore'] as dynamic,
    shopCommentNumber: data['shopCommentNumber'] as dynamic,
    qualityStoreImgsVo: data['qualityStoreImgsVO'] as dynamic,
    goodsCardVo: data['goodsCardVO'] as dynamic,
    categoryId: data['categoryId'] as int?,
    tagInfoList: (data['tagInfoList'] as List<dynamic>?)
        ?.map((e) => TagInfoList.fromMap(e as Map<String, dynamic>))
        .toList(),
    tagInfoMap: data['tagInfoMap'] == null
        ? null
        : TagInfoMap.fromMap(data['tagInfoMap'] as Map<String, dynamic>),
    status: data['status'] as dynamic,
    skuId: data['skuId'] as dynamic,
    wishGoods: data['wishGoods'] as bool?,
    valid: data['valid'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'dataType': dataType,
    'site': site,
    'type': type,
    'value': value,
    'imgUrl': imgUrl,
    'recommendGoodsImg': recommendGoodsImg,
    'title': title,
    'subTitle': subTitle,
    'sort': sort,
    'imgUrlW': imgUrlW,
    'imgUrlH': imgUrlH,
    'id': id,
    'videoUrl': videoUrl,
    'price': price,
    'marketPrice': marketPrice,
    'grouponPrice': grouponPrice,
    'extraInfo': extraInfo,
    'goodsId': goodsId,
    'sales': sales,
    'sold': sold,
    'description': description,
    'createTime': createTime?.toIso8601String(),
    'endTime': endTime,
    'goodsName': goodsName,
    'originalName': originalName,
    'remainLeft': remainLeft,
    'discountLabel': discountLabel,
    'tagList': tagList,
    'routeUrl': routeUrl,
    'onlyGoodsId': onlyGoodsId,
    'productType': productType,
    'selectedItem': selectedItem,
    'goodsDesc': goodsDesc,
    'stock': stock,
    'score': score,
    'commentNumber': commentNumber,
    'shopId': shopId,
    'shopName': shopName,
    'shopScore': shopScore,
    'shopCommentNumber': shopCommentNumber,
    'qualityStoreImgsVO': qualityStoreImgsVo,
    'goodsCardVO': goodsCardVo,
    'categoryId': categoryId,
    'tagInfoList': tagInfoList?.map((e) => e.toMap()).toList(),
    'tagInfoMap': tagInfoMap?.toMap(),
    'status': status,
    'skuId': skuId,
    'wishGoods': wishGoods,
    'valid': valid,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VHomeGoods].
  factory VHomeGoods.fromJson(String data) {
    return VHomeGoods.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VHomeGoods] to a JSON string.
  String toJson() => json.encode(toMap());
}
