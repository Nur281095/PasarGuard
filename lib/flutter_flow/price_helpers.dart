import 'package:flutter/material.dart';

/// Helper class for price calculations and display
class PriceHelpers {
  /// Calculates the discounted price from current price and sale percentage
  ///
  /// Formula: discountedPrice = currentPrice - (currentPrice * salePercentage / 100)
  /// Example: If current price is $400 and sale is 30%
  ///          Discounted = 400 - (400 * 0.30) = 400 - 120 = $280
  static double calculateOriginalPrice(double currentPrice, double salePercentage) {
    if (salePercentage <= 0) return currentPrice;
    final discountAmount = currentPrice * (salePercentage / 100);
    return currentPrice - discountAmount;
  }

  /// Formats price to 2 decimal places
  static String formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  /// Parse price from dynamic JSON field
  static double parsePrice(dynamic priceValue) {
    if (priceValue == null) return 0.0;
    if (priceValue is num) return priceValue.toDouble();
    if (priceValue is String) {
      return double.tryParse(priceValue) ?? 0.0;
    }
    return 0.0;
  }

  /// Parse integer from dynamic JSON field
  static int parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  /// Check if product is on sale
  static bool isOnSale(dynamic isSaleValue) {
    if (isSaleValue == null) return false;
    if (isSaleValue is bool) return isSaleValue;
    if (isSaleValue is num) return isSaleValue > 0;
    if (isSaleValue is String) {
      final parsed = int.tryParse(isSaleValue);
      return parsed != null && parsed > 0;
    }
    return false;
  }
}

/// Widget for displaying price with optional strikethrough original price
class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    Key? key,
    required this.currentPrice,
    this.originalPrice,
    this.currentPriceStyle,
    this.originalPriceStyle,
    this.showDollarSign = true,
    this.spacing = 0.0,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  final double currentPrice;
  final double? originalPrice;
  final TextStyle? currentPriceStyle;
  final TextStyle? originalPriceStyle;
  final bool showDollarSign;
  final double spacing;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    // If no original price, show only current price
    if (originalPrice == null) {
      final currentPriceText = showDollarSign
          ? '\$${PriceHelpers.formatPrice(currentPrice)}'
          : PriceHelpers.formatPrice(currentPrice);

      return Text(
        currentPriceText,
        style: currentPriceStyle,
      );
    }

    // originalPrice is the discounted price ($280)
    // currentPrice is the original price ($400)

    final discountedPriceText = showDollarSign
        ? '\$${PriceHelpers.formatPrice(originalPrice!)}'
        : PriceHelpers.formatPrice(originalPrice!);

    final originalPriceText = showDollarSign
        ? '\$${PriceHelpers.formatPrice(currentPrice)}'
        : PriceHelpers.formatPrice(currentPrice);

    final widgets = <Widget>[
      // Discounted Price (shown first) - Bold Black
      Text(
        discountedPriceText,
        style: currentPriceStyle ?? TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),

      SizedBox(
        width: axis == Axis.horizontal ? spacing : 0,
        height: axis == Axis.vertical ? spacing : 0,
      ),

      // Original Price with strikethrough (shown second) - Regular Gray
      Text(
        originalPriceText,
        style: originalPriceStyle?.copyWith(
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.0,
        ) ?? TextStyle(
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.0,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
          fontSize: (currentPriceStyle?.fontSize ?? 14) * 0.85, // Smaller font
        ),
      ),
    ];

    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      );
    }
  }
}