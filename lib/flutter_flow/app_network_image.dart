import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// AppNetworkImage - Memory-Optimized Image Widget
///
/// Professional image loading widget that prevents memory leaks and crashes:
/// - ✅ Handles null/empty/invalid URLs gracefully
/// - ✅ Shows placeholder on error
/// - ✅ Prevents huge in-memory bitmap decoding
/// - ✅ Uses cached_network_image for efficient caching
/// - ✅ Limits memory with cacheWidth/cacheHeight
/// - ✅ Never crashes the app
/// - ✅ Supports custom border radius
/// - ✅ Shows loading indicator
///
/// Usage:
/// ```dart
/// AppNetworkImage(
///   imageUrl: product.imageUrl,
///   width: 100,
///   height: 100,
///   fit: BoxFit.cover,
/// )
/// ```
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor,
    this.errorIconColor,
    this.errorIconSize = 32.0,
    this.showLoadingIndicator = true,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? placeholderColor;
  final Color? errorIconColor;
  final double errorIconSize;
  final bool showLoadingIndicator;
  final Alignment alignment;

  /// Safely convert any image value to a usable URL
  String? _getSafeUrl(String? url) {
    if (url == null || url.isEmpty || url.toLowerCase() == 'null') {
      return null;
    }
    
    // Handle protocol-relative URLs
    if (url.startsWith('//')) {
      return 'https:$url';
    }
    
    // Handle relative URLs (add your base URL if needed)
    if (url.startsWith('/') && !url.startsWith('//')) {
      // You can add your base URL here if needed
      return url;
    }
    
    return url;
  }

  /// Calculate optimal cache dimensions to prevent huge in-memory bitmaps
  /// 
  /// Firebase recommends: memCacheWidth/Height should be ~2x display size
  /// for high-DPI screens, but we cap at reasonable limits to prevent OOM
  int? _getCacheDimension(double? displaySize) {
    if (displaySize == null || displaySize.isNaN || displaySize.isInfinite) {
      return null;
    }
    
    // Convert logical pixels to physical pixels (assume 3x for safety)
    // But cap at 1024 to prevent excessive memory usage
    final cacheSize = (displaySize * 3).toInt();
    return cacheSize > 1024 ? 1024 : cacheSize;
  }

  @override
  Widget build(BuildContext context) {
    final safeUrl = _getSafeUrl(imageUrl);
    
    // If URL is invalid, show error placeholder immediately
    if (safeUrl == null) {
      return _buildErrorPlaceholder(context);
    }

    final cacheWidth = _getCacheDimension(width);
    final cacheHeight = _getCacheDimension(height);

    Widget imageWidget = CachedNetworkImage(
      imageUrl: safeUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      
      // CRITICAL: Limit in-memory bitmap size to prevent OOM
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      
      // Reduce image quality slightly for better performance
      filterQuality: FilterQuality.medium,
      
      // Loading placeholder
      placeholder: showLoadingIndicator
          ? (context, url) => _buildLoadingPlaceholder(context)
          : null,
      
      // Error placeholder
      errorWidget: (context, url, error) {
        debugPrint('⚠️ Image load error: $url - $error');
        return _buildErrorPlaceholder(context);
      },
      
      // Fade in animation (subtle)
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );

    // Apply border radius if provided
    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  /// Build loading placeholder
  Widget _buildLoadingPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? const Color(0xFFE0E0E0),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  /// Build error placeholder
  Widget _buildErrorPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? const Color(0xFFE0E0E0),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: errorIconColor ?? const Color(0xFF9E9E9E),
        size: errorIconSize,
      ),
    );
  }
}
