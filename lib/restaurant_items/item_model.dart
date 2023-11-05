


class Item{
  late String id;
  late String restaurantID;
  late String _imageURL;
  late String _title;
  late double _price;



  Item.from(Map<String,dynamic> data){
    _imageURL = data["imgURL"];
    _title = data["title"];
    _price = data["price"];
  }

  double get price => _price;

  String get title => _title;

  String get imageURL => _imageURL;
}