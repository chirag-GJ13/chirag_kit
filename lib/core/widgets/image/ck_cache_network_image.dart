import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class CKNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit fit;
  final Widget? fallbackWidget;

  const CKNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius = 0,
    this.fit = BoxFit.cover,
    this.fallbackWidget,
  });

  bool get _isNetwork => imageUrl.trim().toLowerCase().startsWith('http');

  bool get _isSvg => imageUrl.trim().toLowerCase().endsWith('.svg');

  // ─── Default Fallback ──────────────────────────────────────
  Widget get _defaultFallback => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Container(
      width: width ?? double.infinity,
      height: height ?? 150,
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.broken_image_outlined, color: Colors.grey),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // Empty ya local url — fallback dikhao
    if (imageUrl.trim().isEmpty || !_isNetwork) {
      return fallbackWidget ?? _defaultFallback;
    }

    // SVG
    if (_isSvg) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SvgPicture.network(
          imageUrl,
          fit: fit,
          height: height,
          width: width,
          placeholderBuilder: (_) => _shimmerBox(),
        ),
      );
    }

    // Normal Image
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        height: height,
        width: width,
        alignment: Alignment.topCenter,
        placeholder: (_, __) => _shimmerBox(),
        errorWidget: (_, url, error) {
          debugPrint('❌ CKNetworkImage failed: $url | error: $error');
          return fallbackWidget ?? _defaultFallback;
        },
      ),
    );
  }

  // ─── Shimmer ───────────────────────────────────────────────
  Widget _shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
