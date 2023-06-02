import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StripeCouponExample extends StatefulWidget {
  const StripeCouponExample({Key? key}) : super(key: key);

  @override
  _StripeCouponExampleState createState() => _StripeCouponExampleState();
}

class _StripeCouponExampleState extends State<StripeCouponExample> {
  String _couponCode = '';
  String _couponId = '';
  String _couponAmountOff = '';
  String _couponCurrency = '';

  Future<void> _retrieveCouponData(String couponCode) async {
    try {
      // Make GET request to Stripe API to retrieve coupon data
      final response = await http.get(
        Uri.parse('https://api.stripe.com/v1/coupons/$couponCode'),
        headers: {
          'Authorization': 'Bearer sk_test_1AuH6JvVPa2YbtyuyulwaZ0F',
        },
      );

      if (response.statusCode == 200) {
        final coupon = jsonDecode(response.body);

        // Extract relevant data from coupon object
        final couponId = coupon['id'];
        final couponAmountOff = coupon['amount_off'].toString();
        final couponCurrency = coupon['currency'];

        // Update state with retrieved coupon data
        setState(() {
          _couponId = couponId;
          _couponAmountOff = couponAmountOff;
          _couponCurrency = couponCurrency;
        });
      } else {
        print('Error retrieving coupon data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error retrieving coupon data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Coupon Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Coupon code',
              ),
              onChanged: (value) {
                setState(() {
                  _couponCode = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _retrieveCouponData(_couponCode);
              },
              child: const Text('Retrieve Coupon'),
            ),
            const SizedBox(height: 16.0),
            if (_couponId.isNotEmpty)
              Column(
                children: [
                  Text('Coupon ID: $_couponId'),
                  Text('Coupon Amount Off: $_couponAmountOff'),
                  Text('Coupon Currency: $_couponCurrency'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
