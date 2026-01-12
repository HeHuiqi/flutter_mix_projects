import 'package:flutter/material.dart';

class VImagePlaceholderWidget extends StatelessWidget {
  const VImagePlaceholderWidget({
    super.key,
    this.placeholder,
    this.size,
    this.width,
    this.height,
  });
  final Widget? placeholder;
  final Size? size;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return placeholder ?? _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
    return Image.asset(
      "assets/images/base/goods_place@2x.png",
      scale: 2,
      width: size?.width ?? width,
      height: size?.height ?? height,
    );
  }
}
