import 'package:flutter/material.dart';
import 'package:voghion_flutter_module/pages/home/model/v_home_goods/v_home_goods.dart';
import 'package:voghion_flutter_module/utils/v_image_info.dart';
import 'package:voghion_flutter_module/utils/v_string.dart';
import 'package:voghion_flutter_module/widgets/v_cached_network_image_widget.dart';

class VHomeShopItemWidget extends StatefulWidget {
  const VHomeShopItemWidget({super.key, this.goods, this.onTap});
  final VHomeGoods? goods;
  final Function(VHomeGoods? goods)? onTap;

  @override
  State<VHomeShopItemWidget> createState() => _VHomeShopItemWidgetState();
}

class _VHomeShopItemWidgetState extends State<VHomeShopItemWidget> {
  @override
  Widget build(BuildContext context) {
    final goods = widget.goods;
    final imageUrl = goods?.imgUrl ?? '';
    final title = VString.formatPrice(price: goods?.price);
    final subTitle = VString.formatPrice(price: goods?.marketPrice);
    double width = (MediaQuery.of(context).size.width - 30) / 2.0;
    final imageInfo = VImageInfo.parseImageDimensions(imageUrl);
    double height = width;
    if (imageInfo?.height != null && imageInfo?.width != null) {
      height = imageInfo!.height / imageInfo.width * width;
    }

    return InkWell(
      onTap: () {
        widget.onTap?.call(goods);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            VCachedNetworkImageWidget(
              imageUrl: imageUrl,
              height: height,
              width: width,
            ),
            _buildShopItemTitle(
              title: title.toString(),
              subTitle: subTitle.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopItemTitle({required String title, String? subTitle}) {
    final newSubTitle = subTitle ?? "";
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          if (newSubTitle.isNotEmpty)
            Text(
              newSubTitle,

              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
