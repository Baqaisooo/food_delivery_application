



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order_item_model.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem orderItem;

  const OrderItemCard({super.key, required this.orderItem});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {

  String imgURL = "";


  getImageURL() async {
    await FirebaseStorage.instance
        .refFromURL(widget.orderItem.productImgURL)
        .getDownloadURL()
        .then((value) {
      imgURL = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getImageURL();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              child: imgURL.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Image.network(
                imgURL, width: 100,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.orderItem.productTitle, ),
                  Text("Restaurant : ${widget.orderItem.restaurantName}",style: TextStyle(color: Colors.redAccent),),
                  Text("Per Unit : ${widget.orderItem.unitPrice} S.R.")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Quantity"),
                  Text("${widget.orderItem.quantity}"),
                ],
              ),
            )
          ],
        )
    );
  }
}
