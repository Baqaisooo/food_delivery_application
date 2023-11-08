

import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/my_cart.dart';
import 'package:food_delivery_application/restaurants/restaurantpage.dart';

class MyOrderDetailsPage extends StatelessWidget {
  final String orderNum;

  const MyOrderDetailsPage({super.key, required this.orderNum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Home"),
                onTap: () => Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => RestaurantPage()), (route) => false),
              ),

              PopupMenuItem(
                child: Text("My Cart"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCartPage())),
              ),


            ],
          ),
        ],
      ),

      body: Center(child: Text("ORDER Details"),),
    );
  }
}
