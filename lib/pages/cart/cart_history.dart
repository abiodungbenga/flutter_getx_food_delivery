import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    //! looking for the controller so we can use it in our UI files it a list of all the data
    //! i used .reversed so that new items in the list can come first and i converted it to a list because if you use .reversed it is an object
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    //! this is just trying to say that if there are items with the same time it should just be increasing the values of the items like if they have the same time let it take it as an item with the same time whether they apperar three to four times
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      //!getCartHistoryList[i]["time"] is the key
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        //! add items with the same time together to achieve this {2023-11-21 17:09:39.305653: 3, 2023-11-22 17:09:39.305653: 1, 2023-11-23 17:09:39.305653: 2}
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        //!The PutIfAbsent method is implemented by the Map class in Dart, which is used to insert a key-value pair into the map if the specified key is not already mapped to a value, or do nothing if the key already exists in the map.
        //! if it is a new time store it as a seprate item in the history but if its the same just store them like 2 items three items
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    print(
      'Cart Items Per Order :' + cartItemsPerOrder.toString(),
    );
    //! all the functions below have the sam length of items
    //! converting the order time to a list
    List<int> cartItemsPerOrderToList() {
      //! more like also a for loop we are using e.value because we want the first element value
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    //! converting the order time to a list that means their index is going to match
    List<String> cartOrderTimeToList() {
      //! more like also a for loop we are using e.value because we want the first element value
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    //! returned the number of items made it as a list then saved it here
    List<int> itemsPerOrder =
        cartItemsPerOrderToList(); //! Initialize a list 'itemsPerOrder' with order times from the cart
    print(
      'Items Per Order :' + itemsPerOrder.toString(),
    ); //! Print the order times

    var listCounter =
        0; //! Initialize a counter variable 'saveCounter' to keep track of cart history items
    //! creating a time widet
    Widget timeWidget(int, index) {
      var outPutDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        //! Changing the date time format or getting a date time object

        //! Parsing the date string from the 'getCartHistoryList' at index 'listCounter'
        DateTime parseDate = DateFormat('yyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].time!);

        //! Using the parsed date to create another date time object
        var inputDate = DateTime.parse(parseDate.toString());

        //! Formatting the date to a different output format
        var outPutFormat = DateFormat('MM/dd/yyyy hh:mm a');
        var outPutDate = outPutFormat.format(inputDate);

        //! Returning a BigText widget with the formatted date as text
      }
      return BigText(
        text: outPutDate,
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Icon(
      //       Icons.shopping_cart,
      //     ),
      //   ],
      //   title: BigText(
      //     text: 'CartHistory',
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            height: Dimensions.Height100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: Dimensions.Height45,
              bottom: Dimensions.Height10 - 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'CartHistory',
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconcolor: AppColors.mainColor,
                  backgroundcolor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          //! wrapped with expanded because we want it to take the available height
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getCartHistoryList().length > 0
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.Height20,
                          left: Dimensions.Width20,
                          right: Dimensions.Width20,
                        ),
                        //! ListView comes with a default padding use MediaQuery.removePadding to remove it
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              //! using for loop
                              for (int i = 0; i < cartItemsPerOrder.length; i++)
                                // Text(
                                //   'hello world' + i.toString(),
                                // ),
                                Container(
                                  height: Dimensions.Height120,
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.Height20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // //! immediately invoked function
                                      // //! Immediately Invoked Function
                                      // (() {

                                      // }()),
                                      timeWidget(int, listCounter),

                                      SizedBox(
                                        height: Dimensions.Height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              //! using each of the items length from the getCartHistory Lists
                                              itemsPerOrder[i],
                                              (index) {
                                                //! increasing the List Counter as new history comes in
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                //! if index is less than or equal to two show the image or if not show a container so lets say the image is four the image that makes it four will be gone because we want the first three images
                                                return index <= 2
                                                    //! container showing the images
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                          right: Dimensions
                                                                  .Width10 /
                                                              2,
                                                        ),
                                                        height:
                                                            Dimensions.Height80,
                                                        width:
                                                            Dimensions.Width80,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            Dimensions
                                                                    .Radius15 /
                                                                2,
                                                          ),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOAD_URL +
                                                                  getCartHistoryList[
                                                                          //! first time the index is 0 that is why i used -1 to keep the balance
                                                                          listCounter -
                                                                              1]
                                                                      .img!,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Dimensions.Height80,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SmallText(
                                                  text: 'Total',
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      'Items',
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      //!  if thier index matches
                                                      if (getCartHistoryList[i]
                                                              .time ==
                                                          orderTime[i]) {
                                                        // print(
                                                        //   'My Order Time is : ' +
                                                        //       orderTime[i].toString(),
                                                        // );

                                                        // print(
                                                        //   'The Cart Or Product Id is : ' +
                                                        //       getCartHistoryList[j]
                                                        //           .product!
                                                        //           .id
                                                        //           .toString(),
                                                        // );
                                                        // print(
                                                        //   'Product Info is : ' +
                                                        //       jsonEncode(
                                                        //         getCartHistoryList[j],
                                                        //       ),
                                                        // );
                                                        //! putting in our map and using the product id as the key because the key must be unique
                                                        //! jsonEncode makes json Object
                                                        moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel
                                                              .fromJson(
                                                            jsonDecode(
                                                              jsonEncode(
                                                                getCartHistoryList[
                                                                    j],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                        //! how to set an item to a map
                                                        Get.find<CartController>()
                                                                .setItems =
                                                            moreOrder;
                                                        Get.find<
                                                                CartController>()
                                                            .addToCartList();
                                                        //! i want it to take me back to the cart page and the restored items
                                                        Get.toNamed(
                                                          RouteHelper
                                                              .getCartPage(),
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.Width10,
                                                      vertical:
                                                          Dimensions.Height10 /
                                                              2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Dimensions.Width15 / 3,
                                                      ),
                                                      border: Border.all(
                                                        width: 1,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                    child: SmallText(
                                                      size: Dimensions.Font14,
                                                      text: 'One more',
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: NoDataPage(
                          text: 'No Cart History',
                          imgPath: 'assets/image/empty_box.png',
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
