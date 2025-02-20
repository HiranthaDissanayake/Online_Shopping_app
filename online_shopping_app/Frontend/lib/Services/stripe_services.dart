import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StripePaymentService {
  static const String _stripeSecretKey =
      "sk_test_51QOMw0LI2fV9th4crNxS9iSbzmyPdepqGXko2W14mqoQzMG1VeAIP7U6t7yfqVZeFVaoBtUp0RN7cvyTrzvxcgQR00GcBJxp8T"; // Replace with your secret key

  static Future<Map<String, dynamic>?> createPaymentIntent(double amount) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $_stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          "amount": (amount * 100).toInt().toString(), // Convert to cents
          "currency": "LKR",
          "payment_method_types[]": "card"
        },
      );

      return json.decode(response.body);
    } catch (e) {
      print("Error creating Payment Intent: $e");
      return null;
    }
  }

  static Future<bool> processPayment(double amount) async {
    try {
      final paymentIntent = await createPaymentIntent(amount);
      if (paymentIntent == null) return false;

      // Initialize the Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent["client_secret"],
          merchantDisplayName: "Tasty Foods",
          style: ThemeMode.light,
        ),
      );

      // Display the Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      print("Payment successful!");
      return true;
    } on StripeException catch (e) {
      print("Stripe Exception: ${e.error.localizedMessage}");
      return false;
    } catch (e) {
      print("General Error: $e");
      return false;
    }
  }
}
