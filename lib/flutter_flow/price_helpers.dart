import 'package:flutter/material.dart';

/// Helper class for price calculations and display
class PriceHelpers {
  /// Calculates the original price from current price and sale percentage
  /// 
  /// Formula: originalPrice = currentPrice + (currentPrice * salePercentage / 100)
  /// Example: If current price is $225 and sale is 25%
  ///          Original = 225 + (225 * 0.25) = 225 + 56.25 = 281.25
  static double calculateOriginalPrice(double currentPrice, double salePercentage) {
    if (salePercentage <= 0) return currentPrice;
    final discountAmount = currentPrice * (salePercentage / 100);
    return currentPrice + discountAmount;
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
    final currentPriceText = showDollarSign
        ? '\$${PriceHelpers.formatPrice(currentPrice)}'
        : PriceHelpers.formatPrice(currentPrice);

    // If no original price or same as current, show only current price
    if (originalPrice == null || originalPrice! <= currentPrice) {
      return Text(
        currentPriceText,
        style: currentPriceStyle,
      );
    }

    final originalPriceText = showDollarSign
        ? '\$${PriceHelpers.formatPrice(originalPrice!)}'
        : PriceHelpers.formatPrice(originalPrice!);

    final widgets = <Widget>[
      // Current/Sale Price
      Text(
        currentPriceText,
        style: currentPriceStyle,
      ),
      
      SizedBox(
        width: axis == Axis.horizontal ? spacing : 0,
        height: axis == Axis.vertical ? spacing : 0,
      ),
      
      // Original Price with strikethrough
      Text(
        originalPriceText,
        style: originalPriceStyle?.copyWith(
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.0,
        ) ?? TextStyle(
          decoration: TextDecoration.lineThrough,
          decorationThickness: 2.0,
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

