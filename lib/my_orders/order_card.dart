

import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_orders/order_model.dart';

import 'order_details.dart';

class OrderCard extends StatelessWidget {

  final OrderModel data;

  OrderCard({super.key, required this.data});
  
  
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(10), color: Colors.orangeAccent,),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Order # : " + data.orderId,style: TextStyle(fontWeight: FontWeight.bold),),
              Text("Track Status : " + data.orderStatus, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
            ],
          )
      ),

      onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderDetailsPage(orderModel: data,)))
      ,
    );
  }
}
