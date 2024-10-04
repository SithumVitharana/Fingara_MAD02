import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fingara_mad02/consts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {

  StripeService._();

  static final StripeService stripeInstance = StripeService._();

  Future<void> makePayment({
    required int amount,
    required VoidCallback addBooking,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(amount, "inr");

      if (paymentIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Fingara Country Club",
        ),
      );

      await _processPayment();

      // Call the addBooking callback only if the payment was successful
      addBooking();  // This will trigger the database update
    } catch (e) {
      print(e); // Handle errors (e.g., log them, show a message to the user)
    }
  }

  Future<String?> _createPaymentIntent( int amount, String currency) async {

    try {

      final Dio dio = Dio();
      Map<String, dynamic> paymentData = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
          "https://api.stripe.com/v1/payment_intents",
          data: paymentData,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {
              "Authorization": "Bearer $stripeSecretKey",
              "Content-Type": 'application/x-www-form-urlencoded'
            },
          ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch(e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch(e){
      print(e);
    }
  }

  String _calculateAmount (int amount){
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

}