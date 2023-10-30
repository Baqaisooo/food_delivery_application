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

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.lightGreenAccent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                children: <Widget>[
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's dfjl jl dsld fjsdl jfl",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),
                  RestaurantCard(imageUrl: 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30151550/1317.png', name: "Mcdonald's",),

                ],

              ),
          ),
        ],
      ),
    );
  }
}
