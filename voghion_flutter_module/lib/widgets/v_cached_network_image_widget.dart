import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:voghion_flutter_module/widgets/v_image_placeholder_widget.dart';

class VCachedNetworkImageWidget extends StatelessWidget {
  const VCachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.size,
    this.width,
    this.height,
  });
  final String imageUrl;
  final Widget? placeholder;
  final Size? size;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return _buildImage(imageUrl: imageUrl, placeholder: placeholder);
  }

  Widget _buildImage({required String imageUrl, Widget? placeholder}) {
    if (imageUrl.isEmpty) {
      return placeholder ?? _buildImagePlaceholder();
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: size?.width ?? width,
      height: size?.height ?? height,
      placeholder: (context, url) => placeholder ?? _buildImagePlaceholder(),
      errorWidget: (context, url, error) {
        return placeholder ?? _buildImagePlaceholder();
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return VImagePlaceholderWidget(size: size, width: width, height: height);
  }
}
