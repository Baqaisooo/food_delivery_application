import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/my_cart/cart_model.dart';
import 'package:food_delivery_application/my_orders/myOrders.dart';

import '../my_orders/order_details.dart';

class CheckoutForm extends StatefulWidget {
  List<CartItem> cartItems;

  CheckoutForm({super.key, required this.cartItems});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameFieldController = TextEditingController();

  TextEditingController phoneFieldController = TextEditingController();

  TextEditingController cityFieldController = TextEditingController();

  TextEditingController districtFieldController = TextEditingController();

  TextEditingController streetFieldController = TextEditingController();

  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Your Info To Delivery",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          SizedBox(height: 17),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Should not be empty";
                      }
                    },
                    controller: nameFieldController,
                    decoration: InputDecoration(
                      hintText: "your name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Should not be empty";
                      }
                    },
                    controller: phoneFieldController,
                    decoration: InputDecoration(
                      hintText: "your phone 055XXXXXXX",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Should not be empty";
                      }
                    },
                    controller: cityFieldController,
                    decoration: InputDecoration(
                      hintText: "your City",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Should not be empty";
                      }
                    },
                    controller: districtFieldController,
                    decoration: InputDecoration(
                      hintText: "your District",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Should not be empty";
                      }
                    },
                    controller: streetFieldController,
                    decoration: InputDecoration(
                      hintText: "street name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isSubmitting? CircularProgressIndicator():Text(
                          "Confirm Order",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              CupertinoColors.activeOrange)),
                      onPressed: () async {

                        if (_formKey.currentState!.validate()) {

                          setState(() {
                            isSubmitting = true;
                          });

                          FirebaseFirestore db = FirebaseFirestore.instance;

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
                            setState(() {
                              isSubmitting = false;
                            });
                            return;
                          }

                          // Add order data
                          DocumentReference OrderDocRef = db
                              .collection('Order')
                              .doc(deviceID)
                              .collection("deviceOrders")
                              .doc();

                          // Define the data you want to update or create
                          Map<String, dynamic> orderInfo = {
                            "customerName": nameFieldController.text,
                            "customerPhone": phoneFieldController.text,
                            "customerCity": cityFieldController.text,
                            "customerDistrict": districtFieldController.text,
                            "customerStreet": streetFieldController.text,
                            "orderStatus": "Received"
                          };

                          // Use set with merge option to update the existing document or create a new one if it doesn't exist
                          await OrderDocRef.set(orderInfo).then((_) async {
                            //   Add order items to the order
                            for (CartItem orderItem in widget.cartItems) {
                              DocumentReference cartItemDocRef = db
                                  .collection('OrderItems')
                                  .doc(OrderDocRef.id)
                                  .collection("orderItems")
                                  .doc();
                              // Use set with merge option to update the existing document or create a new one if it doesn't exist
                              await cartItemDocRef
                                  .set(orderItem.toMap())
                                  .catchError((error) {
                                print(
                                    "Error updating or creating document: $error");
                              });
                            }
                          }).catchError((error) {
                            print(
                                "Error updating or creating document: $error");
                          });

                          deleteDocumentWithSubcollection("CartItem", deviceID, "items");

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyOrderDetailsPage(orderNum: OrderDocRef.id,)),
                                  (route) => false);
                        }
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );

  }

  void deleteDocumentWithSubcollection(String collectionName, String documentID, String subcollectionName) async {
    // Get a reference to the document
    DocumentReference docRef = FirebaseFirestore.instance.collection(collectionName).doc(documentID);

    // Get all the documents in the subcollection
    QuerySnapshot subcollectionSnapshot = await docRef.collection(subcollectionName).get();

    // Delete each document in the subcollection
    for (QueryDocumentSnapshot doc in subcollectionSnapshot.docs) {
      await docRef.collection(subcollectionName).doc(doc.id).delete();
    }

    // Delete the subcollection itself
    await docRef.collection(subcollectionName).parent?.collection(subcollectionName).doc(docRef.id).delete();

    // Finally, delete the main document
    await docRef.delete();
  }
}
