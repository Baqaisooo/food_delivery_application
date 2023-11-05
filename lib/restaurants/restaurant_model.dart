

class Restaurant{
  late String _id;
  late String _imageURL;
  late String _name;



  Restaurant.from(Map<String,dynamic> data){
    _imageURL = data["imgURL"];
    _name = data["name"];
  }

  String get name => _name;


  String get iamgeURL => _imageURL;


  String get id => _id;

  set id(String value) {
    _id = value;
  }
}