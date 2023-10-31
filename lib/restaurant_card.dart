import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/restaurant_model.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantCard({required this.restaurant});

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  String imgURL = "";

  getImageURL() async {
    await FirebaseStorage.instance
        .refFromURL(widget.restaurant.iamgeURL)
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
    return InkWell(
      child: Container(
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 140,
                child: imgURL.isEmpty?Center(child: CircularProgressIndicator(),):Image.network(
                  imgURL,
                  width: double.maxFinite,
                  height: 140,
                ),
              ),
              SizedBox(
                height: 8.0,
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text(
                  widget.restaurant.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print(widget.restaurant.id);
      },
    );
  }
}
