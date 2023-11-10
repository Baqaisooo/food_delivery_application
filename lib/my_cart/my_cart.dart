import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/checkout/checkout.dart';
import 'package:food_delivery_application/my_cart/my_cart_items.dart';
import 'package:food_delivery_application/my_orders/myOrders.dart';
import 'package:food_delivery_application/restaurants/restaurantpage.dart';

import 'cart_model.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<CartItem> items = [];
  double _totalPrice = 0;

  bool cartIsEmpty = false;

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
    await db
        .collection('CartItem')
        .doc(deviceID)
        .collection("items")
        .get()
        .then(
      (querySnapshot) async {
        for (var docCartItems in querySnapshot.docs) {
          String itemID = docCartItems.data()["itemID"];
          String restaurantID = docCartItems.data()["restaurantID"];

          await db
              .collection("Restaurant")
              .doc(restaurantID)
              .get()
              .then((restaurant) async {
            await db
                .collection("Restaurant")
                .doc(restaurantID)
                .collection("items")
                .doc(itemID)
                .get()
                .then((docItem) {
              items.add(CartItem.form(
                  docCartItems.data(), docItem.data()!, restaurant.data()!));
              _totalPrice +=
                  docCartItems.data()["quantity"] * docItem.data()!["price"];
            });
          });
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    setState(() {
      cartIsEmpty = items.isEmpty;
    });
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
        title: const Text("My Cart"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Home"),
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const RestaurantPage()),
                    (route) => false),
              ),
              PopupMenuItem(
                child: const Text("My Order"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrdersPage())),
              ),
            ],
          ),
        ],
      ),
      body: cartIsEmpty? Center(child: Text("Cart Is Empty")) : items.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            )
          : Column(children: [
              Expanded(
                  child: MyCartItems(
                items: items,
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(items: items, total: _totalPrice)));
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow)),
                    ),
                    Center(
                        child: Text(
                      "Total : ${_totalPrice.toStringAsFixed(2)} SR",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )),
                  ],
                ),
              )
            ]),
    );
  }
}
