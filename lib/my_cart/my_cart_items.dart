
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/cart_item_card.dart';
import 'package:food_delivery_application/my_cart/cart_model.dart';

class MyCartItems extends StatelessWidget {
  List<CartItem> items;
  MyCartItems({super.key, required this.items});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: items.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children:
                items.map((item) => CartItemCard(item: item)).toList()
            ),
    );
  }
}
