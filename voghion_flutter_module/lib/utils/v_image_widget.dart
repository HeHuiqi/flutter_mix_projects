import 'package:flutter/material.dart';

class VImageWidget extends StatefulWidget {
  /// 图片路径
  final String image;
  final BoxFit? fit;
  const VImageWidget({super.key, required this.image, this.fit});

  @override
  State<VImageWidget> createState() => _VImageWidgetState();
}

class _VImageWidgetState extends State<VImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(widget.image, scale: 2, fit: widget.fit);
  }
}
