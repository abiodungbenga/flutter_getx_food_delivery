import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/popular_products_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({
    required this.popularProductRepo,
  });
  List<dynamic> _popularProductList = [];
  //! we need this method to accept the data
  List<dynamic> get popularProductsList => _popularProductList;
  //! creating a variable of type cartcontroller when using late variable you will have to initialize it before using it
  late CartController _cart;

  //! setting up a boolean for the preloaded
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  //! declaring an integer for the quantity
  int _quantity = 0;

  //! making a getter
  int get quantity => _quantity;
  //! trying to get the items in cart
  int _inCartItems = 0;
  //! making a getter
  int get inCartItems => _inCartItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductsList();
    if (response.statusCode == 200) {
      // print('got the request');
      // print(response.body);
      // print(_popularProductList);
      //! setting the product list to an empty list
      _popularProductList = [];
      //! just like inserting the data into the model
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //!for the preloader
      _isLoaded = true;
      //! this is just like set state
      update();
    } else {
      //! if it fails
    }
  }

  //! this methods are reusable because they all come from cart controller
  //! code to increase item based on click so it has to be boolean true or false
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // print(
      //   'Number Of Items ' + _quantity.toString(),
      // );
      //! if increment is true let the quantity increase by one
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    //! this is so that our ui will change and know about teh state whe we increase or decrease
    update();
  }

  int checkQuantity(int quantity) {
    //! minimum of zero item
    //! i want if the items in cart plus the quantity is less than zero because we cant reduce the item and we put a condition that if the item count is less than zero it should just return zero instead
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Item Count',
        'You Cant Reduce More!',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      //! there is a bug that if you minus it it becomes two immediately after minusing zero so this will ssolve it
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }
    //! maximum of 20 items
    else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        'Item Count',
        'You Cant Increase More!',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;

    //! it gets initialized over here
    _cart = cart;
    //! this is just trying to initialize the item in cart as zero
    _inCartItems = 0;
    var exists = false;
    exists = _cart.existInCart(product);
    // print(
    //   'exist or not ' + exists.toString(),
    // );
    //! that is if the item in the cart exists
    if (exists) {
      _inCartItems = cart.getQuantity(product);
    }
    // print(
    //   'the quantity in the cart is ' + _inCartItems.toString(),
    // );
  }

  //! function to add the item to the cart
  void addItemToCart(
    ProductModel product,
  ) {
    // if (_quantity > 0) {
    _cart.addItem(
      product,
      _quantity,
    );
    //! before adding the quantity is zero and after adding is zero and update by adding the old quantity with the new one you just made together
    _quantity = 0;
    //! set this state so that if you reduce it wont just show zero immediately
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      // print(
      //   'The Id is ' +
      //       value.id.toString() +
      //       'quantity is ' +
      //       value.quantity.toString(),
      // );
    });
    //! telling the UI to Update because we want to display it to the UI just like set state
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  //! using the getter here to get the total items in cart
  List<CartModel> get getItems {
    return _cart.getItemsInCart;
  }
}
