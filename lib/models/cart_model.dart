import 'package:food_delivery_app/models/popular_products_model.dart';

class CartModel {
  int? id;
  String? name;

  int? price;
  //! adding the quantity as an int because it is a cart i need to know the quantity that the user has chosen
  int? quantity;
  //! check if it exists in teh cart or not
  bool? exists;
  //! to save time of when it is created
  String? time;
  String? img;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.exists,
    this.time,
    this.img,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    exists = json['exists'];
    time = json['time'];

    price = json['price'];
    img = json['img'];

    product = ProductModel.fromJson(json['product']);
  }
//! converting the object to a string so this can work  cartList.forEach((element) {
  //   return cart.add(
  //     jsonEncode(
  //       element,
  //     ),
  //   );
  // });
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'quantity': this.quantity,
      'exists': this.exists,
      'time': this.time,
      //! because you want to convert from an object to string
      'product': this.product!.toJson(),
    };
  }
}
