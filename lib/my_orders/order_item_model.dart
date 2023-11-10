

class OrderItem{
  late String productImgURL;
  late String productTitle;
  late String restaurantName;
  late int quantity;
  late double unitPrice;

  OrderItem.from(Map<String, dynamic> data){
    productImgURL = data["ImgURL"];
    productTitle = data["Title"];
    restaurantName = data["RestaurantName"];
    quantity = data["Quantity"];
    unitPrice = data["unitPrice"];
  }


}