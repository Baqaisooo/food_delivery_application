import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'item_model.dart';

class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String imgURL = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  getImageURL() async {
    await FirebaseStorage.instance
        .refFromURL(widget.item.imageURL)
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
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: imgURL.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Image.network(
                        imgURL,
                        width: double.maxFinite,
                        height: 140,
                      ),
              ),
            ),
            const SizedBox(
              height: 8.0,
              child: Divider(),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    widget.item.title,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${widget.item.price} SR",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.redAccent,
                        size: 35,
                      ),
                      onTap: () async {
                        final DeviceInfoPlugin deviceInfoPlugin =
                            DeviceInfoPlugin();
                        String deviceID = "";
                        if (Platform.isAndroid) {
                          AndroidDeviceInfo androidInfo =
                              await deviceInfoPlugin.androidInfo;
                          deviceID = androidInfo.id; // unique ID on Android
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: const Text(
                                  'YOU SHOULD USE THIS APP ON ANDROID ONLY'),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Added To Cart Successfully'),
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );



                        DocumentReference docRef = db.collection('CartItem').doc(deviceID).collection("items").doc(widget.item.id);

                        // Define the data you want to update or create
                        Map<String, dynamic> cartItem = {
                          "restaurantID": widget.item.restaurantID,
                          "itemID": widget.item.id,
                          "quantity": FieldValue.increment(1)
                        };


                        // Use set with merge option to update the existing document or create a new one if it doesn't exist
                        docRef.set(cartItem, SetOptions(merge: true))
                            .then((_) {
                          print("Document updated or created successfully!");
                        })
                            .catchError((error) {
                          print("Error updating or creating document: $error");
                        });



                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
