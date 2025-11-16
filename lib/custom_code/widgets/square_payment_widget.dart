// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class SquarePaymentWidget extends StatefulWidget {
  const SquarePaymentWidget({
    Key? key,
    this.width,
    this.height,
    required this.buttonText,
    required this.amount,
    required this.currencyCode,
    this.buttonColor,
    this.textColor,
    this.borderRadius,
    this.squareApplicationId,
    this.locationId,
    this.paymentResultAction,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String buttonText;
  final double amount;
  final String currencyCode;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final String? squareApplicationId;
  final String? locationId;
  final Future<dynamic> Function(bool success, String message)?
      paymentResultAction;

  @override
  _SquarePaymentWidgetState createState() => _SquarePaymentWidgetState();
}

class _SquarePaymentWidgetState extends State<SquarePaymentWidget> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initSquarePayment();
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(
        widget.squareApplicationId ?? 'YOUR_SQUARE_APP_ID');
  }

  Future<void> _startCardEntryFlow() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCardEntryCancel,
        collectPostalCode: true,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (widget.paymentResultAction != null) {
        widget.paymentResultAction!(
            false, 'Failed to start card entry flow: ${e.toString()}');
      }
    }
  }

  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    try {
      // Note: You would normally process this payment on your server
      final String nonce = result.nonce;

      // Complete the card entry flow
      await InAppPayments.completeCardEntry(
        onCardEntryComplete: () {
          setState(() {
            _isLoading = false;
          });

          // In a real app, you would send the nonce to your server for processing
          if (widget.paymentResultAction != null) {
            widget.paymentResultAction!(true,
                'Payment successful! Transaction ID: ${nonce.substring(0, 8)}');
          }
        },
      );
    } catch (e) {
      await InAppPayments.completeCardEntry(
        onCardEntryComplete: () {
          setState(() {
            _isLoading = false;
          });
          if (widget.paymentResultAction != null) {
            widget.paymentResultAction!(
                false, 'Payment failed: ${e.toString()}');
          }
        },
      );
    }
  }

  void _onCardEntryCancel() {
    setState(() {
      _isLoading = false;
    });
    if (widget.paymentResultAction != null) {
      widget.paymentResultAction!(false, 'Payment cancelled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ElevatedButton(
              onPressed: _startCardEntryFlow,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor ?? Colors.blue,
                foregroundColor: widget.textColor ?? Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 8.0),
                ),
              ),
              child: Text(widget.buttonText),
            ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
