import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/restaurant_card.dart';
import 'package:food_delivery_application/restaurant_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
      ),
      body: RestaurantList(),
    );
  }
}

class RestaurantList extends StatefulWidget {
  RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> restaurants = [];

  getData() async {
    await FirebaseFirestore.instance.collection('Restaurant').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print(docSnapshot.id);
          restaurants
              .add(Restaurant.from(docSnapshot.data())..id = docSnapshot.id);
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
    print(restaurants);
    return Container(
      child: restaurants.isEmpty? Center(child: CircularProgressIndicator(),) : ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: restaurants.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: restaurants[index],);
              },
            ),
          ),
        ],
      ),
    );
  }
}
