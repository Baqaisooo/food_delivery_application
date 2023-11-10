import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/my_cart.dart';
import 'package:food_delivery_application/my_orders/order_model.dart';
import 'package:food_delivery_application/restaurants/restaurantpage.dart';

import 'order_item_card.dart';
import 'order_item_model.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel orderModel;

  OrderDetailsPage({super.key, required this.orderModel});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  double totalPrice = 0;
  List<OrderItem> orderItems = [];

  getData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection("OrderItems")
        .doc(widget.orderModel.orderId)
        .collection("orderItems")
        .get()
        .then((docSnapshot) {
      for (var orderItem in docSnapshot.docs) {
        totalPrice += orderItem.data()["unitPrice"] * orderItem.data()["Quantity"];
        orderItems.add(OrderItem.from(orderItem.data()));
      }
    });

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
        title: const Text("Order Details"),
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
        child: orderItems.isEmpty
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Text("ORDER NUMBER\n#${widget.orderModel.orderId}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),textAlign: TextAlign.center,),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.deepOrangeAccent,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Status : ${widget.orderModel.orderStatus}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            OrderItemCard(orderItem: orderItems[index]),
                        separatorBuilder: (contxt, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: orderItems.length),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.indigo,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Total :",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          " ${totalPrice} SR",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
      ),
    );
  }
}
