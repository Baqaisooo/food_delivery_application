import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/my_cart.dart';
import 'package:food_delivery_application/my_orders/order_card.dart';
import 'package:food_delivery_application/restaurants/restaurantpage.dart';

import 'order_model.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late List<OrderModel> orders = [];
  bool isOrdersEmpty = false;

  getData() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceID = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceID = androidInfo.id; // unique ID on Android
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: const Text('YOU SHOULD USE THIS APP ON ANDROID ONLY'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return;
    }

    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("Order")
        .doc(deviceID)
        .collection("deviceOrders")
        .get()
        .then((querySnapshot) async {
      for (var order in querySnapshot.docs) {
        orders.add(OrderModel.from(
            data: order.data(), orderId: order.id));
      }
    });

    if (orders.isEmpty) {
      isOrdersEmpty = true;
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Home"),
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RestaurantPage()),
                    (route) => false),
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
      body: Center(
        child: isOrdersEmpty
            ? Text("You Don't Order ever")
            : orders.isEmpty
                ? CircularProgressIndicator()
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        OrderCard(data: orders[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                    itemCount: orders.length),
      ),
    );
  }
}
