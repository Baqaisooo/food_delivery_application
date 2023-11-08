
import 'package:flutter/material.dart';

import '../my_cart/cart_model.dart';
import 'checkout_form.dart';

class CheckoutPage extends StatelessWidget {
  List<CartItem> items;
  double total;

  CheckoutPage({super.key, required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),

      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Final Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Center(child: Text("${total.toStringAsFixed(2)} SR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(child: Center(child: CheckoutForm(cartItems:items)))),
        ],
      ),
    );
  }
}


