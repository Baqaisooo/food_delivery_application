

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/my_cart.dart';
import 'package:food_delivery_application/restaurants/restaurant_card.dart';
import 'package:food_delivery_application/restaurants/restaurant_model.dart';
import 'package:food_delivery_application/restaurants/restaurantpage.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
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
      
      body: Center(child: Text("MY ORDERS"),),
    );
  }
}
