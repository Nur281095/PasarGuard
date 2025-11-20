import 'package:flutter/material.dart';

/// A safe Image.network wrapper that handles all error cases without crashing
/// 
/// This widget ensures that:
/// - Theme and context lookups are cached BEFORE the builder callbacks
/// - No inherited widget lookups happen inside errorBuilder/loadingBuilder
/// - All image loading errors are gracefully handled with a placeholder
/// - The widget tree never crashes due to invalid/null/404 image URLs
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderAssetPath = 'assets/images/placeholder.jpg',
    this.iconSize = 40.0,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String placeholderAssetPath;
  final double iconSize;
  final int? cacheWidth;
  final int? cacheHeight;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    // Cache theme values OUTSIDE the builders to avoid unsafe context lookups
    final theme = Theme.of(context);
    final alternateColor = theme.colorScheme.surfaceVariant;
    final secondaryTextColor = theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey;

    // Sanitize URL
    String url = imageUrl.trim();
    if (url.isEmpty || url.toLowerCase() == 'null') {
      url = 'https://fakeimg.pl/600x400?text=No+Image';
    }
    if (url.startsWith('//')) {
      url = 'https:$url';
    }
    url = url.replaceAll(' ', '%20');

    final imageWidget = Image.network(
      url,
      key: ValueKey(url),
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      // Safe errorBuilder - uses CACHED theme colors, no context lookups
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: alternateColor,
            borderRadius: borderRadius,
          ),
          child: Image.asset(
            placeholderAssetPath,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              // Final fallback to icon if asset also fails
              return Icon(
                Icons.image_not_supported,
                color: secondaryTextColor,
                size: iconSize,
              );
            },
          ),
        );
      },
      // Safe loadingBuilder - uses CACHED theme colors, no context lookups
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: alternateColor,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2.0,
            ),
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

