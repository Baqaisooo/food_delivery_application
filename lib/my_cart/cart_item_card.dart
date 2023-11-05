
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/cart_model.dart';

class CartItemCard extends StatefulWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  String imgURL = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  getImageURL() async {
    await FirebaseStorage.instance
        .refFromURL(widget.item.itemImgURL)
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
                Text(widget.item.productTitle, ),
                Text("Restaurant : ${widget.item.restaurantName}",style: TextStyle(color: Colors.redAccent),),
                Text("Per Unit : ${widget.item.price} S.R.")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Quantity"),
                Text("${widget.item.quantity}"),
              ],
            ),
          )
        ],
      )
    );
  }
}
