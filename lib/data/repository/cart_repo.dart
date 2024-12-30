import 'dart:convert';

import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  //! list of string then we initialize it to cart like an array
  List<String> cart = [];
  //! creating list of String for the cart history
  List<String> cartHistory = [];
  //! cartList is actually a variable that we stored the list in cart model in
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    //! declare a time
    var time = DateTime.now().toString();
    //! converting the cart model from an object to string because shared preferences only accepts string
    // cartList.forEach((element) {
    //   return cart.add(
    //     jsonEncode(
    //       element,
    //     ),
    //   );
    // });
    cartList.forEach((element) {
      //! adding time to our element more likae adding the present time to our element or map
      element.time = time;
      return cart.add(
        jsonEncode(element),
      );
    });
    //! we are using list because we are passing a list to the function addtocartlist
    //! storing it as a string in shared preferences
    sharedPreferences.setStringList(AppConstants.CARTLIST, cart);
    // print(
    //   sharedPreferences.getStringList(
    //     AppConstants.CARTLIST,
    //   ),
    // );
    // getCartList();
  }

  //! function to get cart list with shared prefrences so our items in the apk will not be deleted when you restart the app and the number of items
  List<CartModel> getCartList() {
    //! removing them for debugging purposes so the apk will start with no stored data at first
    // sharedPreferences.remove(AppConstants.CARTHISTORYLIST);
    // sharedPreferences.remove(AppConstants.CARTLIST);
    List<String> carts = [];

    //! checking if the key exists then we retrieve all the information in it
    if (sharedPreferences.containsKey(AppConstants.CARTLIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CARTLIST)!;
      print(
        'Inside Get Cart List ' + carts.toString(),
      );
    }
    List<CartModel> cartList = [];
    //! element is just like the elements in the list
    // carts.forEach((element) {
    //   CartList.add(
    //     CartModel.fromJson(
    //       jsonDecode(element),
    //     ),
    //   );
    // });
    //! shorter version
    carts.forEach(
      (element) => cartList.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );
    return cartList;
  }

  //! returning the history or object
  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CARTHISTORYLIST)) {
      //! setting the cart history to an empty list
      cartHistory = [];
      //! then cartHistory should be
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CARTHISTORYLIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach(
      (element) => cartListHistory.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );
    return cartListHistory;
  }

  //! function to store the cart list with shared preferneces in the addCartHistory and remove it from the UI
  void addToCartHistoryList() {
    //! to keep the former information but update a new one to it
    if (sharedPreferences.containsKey(AppConstants.CARTHISTORYLIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CARTHISTORYLIST)!;
    }
    for (int j = 0; j < cart.length; j++) {
      print('History List' + cart[j]);
      //! every list has the add method
      cartHistory.add(cart[j]);
      //
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CARTHISTORYLIST, cartHistory);
    print(
      'The length of the history list is: ' +
          getCartHistoryList().length.toString(),
    );
    for (int i = 0; i < cart.length; i++) {
      print(
        'The time for the order is: ' + getCartHistoryList()[i].time.toString(),
      );
    }
  }

  //! function to remove everyting in the cart
  void removeCart() {
    //! setting the cart to an empty  array more like you want it to become zero back
    cart = [];
    //! you will have to remove the key before the checkout button works or in other words removing the lstored list
    sharedPreferences.remove(AppConstants.CARTLIST);
  }

  //! we need to clear the cart history when the user logs out
  void clearCartHistory() {
    removeCart();
    //! setting thr cartHistory back to an empty array or an empty list
    cartHistory = [];
    //! removing the cart list stored in shared preferences
    sharedPreferences.remove(
      AppConstants.CARTLIST,
    );
  }
}
