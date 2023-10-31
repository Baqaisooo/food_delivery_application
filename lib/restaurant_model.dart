

class Restaurant{
  late String _id;
  late String _iamgeURL;
  late String _name;


  Restaurant(this._id, this._iamgeURL, this._name);

  Restaurant.from(Map<String,dynamic> data){
    _iamgeURL = data["imgURL"];
    _name = data["name"];
  }

  String get name => _name;


  String get iamgeURL => _iamgeURL;


  String get id => _id;

  set id(String value) {
    _id = value;
  }
}