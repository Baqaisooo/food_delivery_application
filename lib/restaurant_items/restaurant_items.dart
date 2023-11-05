import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/my_cart.dart';
import 'package:food_delivery_application/my_orders/myOrders.dart';
import 'package:food_delivery_application/restaurant_items/item_model.dart';

import 'item_card.dart';

class RestaurantItems extends StatefulWidget {
  String restaurantId;
  RestaurantItems({super.key, required this.restaurantId});

  @override
  State<RestaurantItems> createState() => _RestaurantItemsState();
}

class _RestaurantItemsState extends State<RestaurantItems> {
  String restaurantName = "";

  getRestaurantName() async{
    FirebaseFirestore.instance.collection('Restaurant').doc(
        widget.restaurantId).get().then(
          (docSnapshot) {
        restaurantName = docSnapshot.get("name");
        setState(() {

        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getRestaurantName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [

              PopupMenuItem(
                child: const Text("My Order"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrdersPage())),
              ),

              PopupMenuItem(
                child: const Text("My Cart"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyCartPage())),
              ),


            ],
          ),
        ],
      ),

      body: ItemList(restaurantID: widget.restaurantId,),
    );
  }
}

class ItemList extends StatefulWidget {
  String restaurantID;
  ItemList({super.key, required this.restaurantID});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> items = [];

  late final restaurantName;

  getData() async {

    await FirebaseFirestore.instance.collection('Restaurant').doc(widget.restaurantID).collection("items").get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          items
              .add(Item.from(docSnapshot.data())..id = docSnapshot.id ..restaurantID= widget.restaurantID);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
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
    return Container(
      child: items.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ItemCard(
                  item: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
