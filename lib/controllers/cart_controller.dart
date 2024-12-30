import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/popular_products_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/repository/cart_repo.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  //! creating an instance of the cart repository
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });

  //! this is where we store the value that has been added to the cart that is the number of products added to cart through out our app
  Map<int, CartModel> _items = {};
  //! making a getter so we can acees it in the product controller and items becomes a global variable
  Map<int, CartModel> get items => _items;
  //! only for storage and sharedpreferences
  List<CartModel> storageItems = [];
  //! it should take the product model as product and it should take the quantity because we need it

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    // print(
    //   'Number of Items in The cart Is :' + _items.length.toString(),
    // );
    //! note the id of the product is the primary key from the response body or from the backend
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        //! here i am checking the old value and the new one whatever is giving then i check on it
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          //! we add the value that was given to us to the other value
          quantity: value.quantity! + quantity,
          exists: true,
          time: DateTime.now().toString(),
          price: value.price,
          img: value.img,
          product: product,
        );
      });
      //! if the item is less than or equals to zero that item should be removed
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      //! add it to map only if quantity is greater than zero
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          // print(
          //   'adding item to the cart ' +
          //       product.id.toString() +
          //       ' Quantity: ' +
          //       quantity.toString(),
          // );
          // _items.forEach((key, value) {
          //   print(
          //     'Quantity is ' + value.quantity.toString(),
          //   );
          // });
          return CartModel(
            id: product.id,
            name: product.name,
            //! we save whatever quantity the user passes to us
            quantity: quantity,
            exists: true,
            time: DateTime.now().toString(),
            price: product.price,
            img: product.img,
            product: product,
          );
        });
      } else {
        Get.snackbar(
          'Item Count',
          'You should at least add one item in the cart',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItemsInCart);

    //! so the ui can update
    update();
  }

//! return true or false if item exists in the cart or not
  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  //! to get the quantity in that has been added to the cart
  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      //! the key in the condition which is the product id  is the same as the one in the items.foreach
      _items.forEach((key, value) {
        //! storing the instance of the quantity into the quantity that was just created
        quantity = value.quantity!;
      });
    }
    //! returning the quantity
    return quantity;
  }

  //! return a field not a function it will return int or a field
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      //! whatever the first value add the new value and save it to totalQuantity we get the value and the value from the quantity object and add it and store it in totalQuantity
      totalQuantity = totalQuantity + value.quantity!;
    });
    return totalQuantity;
  }

  //! to get all the objects stored in the cart model it will return all the cart model that is stored in the cart model
  List<CartModel> get getItemsInCart {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  //! to get total items in the cart and calculate the total or amount
  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total = total + (value.quantity! * value.price!);
    });
    return total;
  }

  //! function to getCartData with shared preferences and persist the data
  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  //! set is the opposite of get it accepts something because get will return you something and with set you have to accept something in your parameters
  set setCart(List<CartModel> items) {
    storageItems = items;
    // print(
    //   'length in cart items' + storageItems.length.toString(),
    // );
    //! creating a loop
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
        storageItems[i].product!.id!,
        () => storageItems[i],
      );
    }
  }

  //! function to add the stored data to history and delete it from the cart list
  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  //! function to clear
  void clear() {
    //! setting it to an empty list
    _items = {};
    update();
  }

  //! creating  a new function to get Cart history list
  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    //! making sure the _items is empty
    _items = {};
    //! then set whtat ever is being send from _items
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItemsInCart);
    //! so the ui can update
    update();
  }

  void clearCartHistory() {
    //! calling the cart repo function to clear the cart history
    cartRepo.clearCartHistory();
    //! updating it so it can show in our UI or let it know things have been updated
    update();
  }
}
