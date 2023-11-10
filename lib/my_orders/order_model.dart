

class OrderModel{
  late final String orderId;
  late final String orderStatus;
  late final String customerName;
  late final String customerPhone;
  late final String customerCity;
  late final String customerDistrict;
  late final String customerStreetName;


  OrderModel.from({required Map<String, dynamic> data,required this.orderId}){
    orderStatus = data["orderStatus"];
    customerName = data["customerName"];
    customerPhone = data["customerPhone"];
    customerCity = data["customerCity"];
    customerDistrict = data["customerDistrict"];
    customerStreetName = data["customerStreet"];
  }
}