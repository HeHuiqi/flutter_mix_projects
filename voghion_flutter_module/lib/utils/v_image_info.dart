/// 存储宽高信息的类
class Dimensions {
  final int width;
  final int height;

  Dimensions(this.width, this.height);
}

class VImageInfo {
  String? imageUrl;
  double? width;
  double? height;

  /// 解析图片文件名中的宽高信息
  static Dimensions? parseImageDimensions(String fileName) {
    // 正则表达式：匹配数字+x+数字的模式（如 1500x1500）
    final regex = RegExp(r'(\d+)x(\d+)');
    final match = regex.firstMatch(fileName);

    if (match != null && match.groupCount == 2) {
      final width = int.tryParse(match.group(1)!);
      final height = int.tryParse(match.group(2)!);

      if (width != null && height != null) {
        return Dimensions(width, height);
      }
    }

    return null;
  }

  /// 根据如下图片地址获取宽高
  /// https://g-images-process.desvips.com/?image=productImages/00baf7d2687c07cf26d97255015ca8e4_voghion1500x1500.jpg
  static VImageInfo? getImageSize(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    final queryParameters = uri.queryParameters;
    final image = queryParameters['image'];
    if (image == null) {
      return null;
    }

    // 解析图片文件名中的宽高信息
    final name = image.split('/').last;
    final size = VImageInfo.parseImageDimensions(name);
    if (size != null) {
      final imageInfo = VImageInfo();
      imageInfo.imageUrl = imageUrl;
      imageInfo.width = size.width.toDouble();
      imageInfo.height = size.height.toDouble();
    }
    return null;
  }
}
