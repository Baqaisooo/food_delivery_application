


class CartItem{
  late final String _itemID;
  late final String _restaurantID;
  late final int _quantity;
  late final String _itemImgURL;
  late final String _restaurantName;
  late final String _productTitle;
  late final double _price;

  CartItem.form(Map<String,dynamic> cartItemData, Map<String,dynamic> itemData, Map<String,dynamic> restaurantData ){

    _itemID = cartItemData["itemID"];
    _restaurantID = cartItemData["restaurantID"];
    _quantity = cartItemData["quantity"];

    _itemImgURL = itemData["imgURL"];
    _productTitle = itemData["title"];
    _price = itemData["price"];

    _restaurantName = restaurantData["name"];

  }

  double get price => _price;

  String get productTitle => _productTitle;

  String get restaurantName => _restaurantName;

  String get itemImgURL => _itemImgURL;

  int get quantity => _quantity;

  String get restaurantID => _restaurantID;

  String get itemID => _itemID;
}