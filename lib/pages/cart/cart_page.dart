import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.Width20,
            right: Dimensions.Width20,
            top: Dimensions.Height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconcolor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  Iconsize: Dimensions.IconSize24,
                ),
                SizedBox(
                  width: Dimensions.Width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      RouteHelper.getInitial(),
                    );
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconcolor: Colors.white,
                    backgroundcolor: AppColors.mainColor,
                    Iconsize: Dimensions.IconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconcolor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  Iconsize: Dimensions.IconSize24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartController) {
              //! if the item in the Cart is less than zero show the no cart page unless show the itesm
              return _cartController.getItemsInCart.length > 0
                  ? Positioned(
                      top: Dimensions.Height20 * 5,
                      right: Dimensions.Width20,
                      left: Dimensions.Width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.Height15,
                        ),
                        //! the list view builder has a space automatically at the top so MediaQuery.removePadding removed that space for you
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (cartController) {
                                //! simplifying the cart list
                                var _cartList = cartController.getItemsInCart;
                                return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: Dimensions.Height100,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //! if we cant find the item here
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductsList
                                                  .indexOf(
                                                    _cartList[index].product,
                                                  );
                                              //! if it is failing
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                  RouteHelper
                                                      .getPopularFoodPage(
                                                    popularIndex,
                                                    //! everything small letter of the name you put in the named
                                                    'cartpage',
                                                  ),
                                                );
                                              } else {
                                                //! then it must be here if you have plenty categories you will have to do more conditional statements
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductsList
                                                    .indexOf(
                                                      _cartList[index].product,
                                                    );
                                                //! if it is also failing
                                                //! this will not allow history products to be viewed or taken to another page
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                    'History Product',
                                                    'Product Review is not available ',
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  Get.toNamed(
                                                    RouteHelper
                                                        .getRecommendedFoodPage(
                                                      recommendedIndex,
                                                      'cartpage',
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.Width20 * 5,
                                              height: Dimensions.Height20 * 5,
                                              margin: EdgeInsets.only(
                                                bottom: Dimensions.Height10,
                                              ),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstants.BASE_URL +
                                                        AppConstants
                                                            .UPLOAD_URL +
                                                        cartController
                                                            .getItemsInCart[
                                                                index]
                                                            .img!,
                                                  ),
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.Radius20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.Width10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: Dimensions.Height20 * 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItemsInCart[index]
                                                        .name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(
                                                    text: 'Spicy',
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text: cartController
                                                            .getItemsInCart[
                                                                index]
                                                            .price
                                                            .toString(),
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Dimensions
                                                              .Height10,
                                                          bottom: Dimensions
                                                              .Height10,
                                                          right: Dimensions
                                                              .Width10,
                                                          left: Dimensions
                                                              .Width10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            Dimensions.Radius20,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                                // print('Increment');
                                                                // popularProductQuantity.setQuantity(false);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .Width10 /
                                                                  2,
                                                            ),
                                                            //! convert the int to string because it will display as text in our ui
                                                            //! and also i used incartitems so whenever we close the product and open it we will still meet the value we set so we can either add to it or reduce it
                                                            BigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()),
                                                            SizedBox(
                                                              width: Dimensions
                                                                      .Width10 /
                                                                  2,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                print(
                                                                    'Being Tapped');
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                                // print('Increment');
                                                                // popularProductQuantity.setQuantity(true);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      ),
                    )
                  : NoDataPage(
                      text: 'Your Cart Is Empty',
                    );
            },
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartTotalItems) {
          return Container(
            height: Dimensions.BottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.Height30,
              bottom: Dimensions.Height30,
              left: Dimensions.Width20,
              right: Dimensions.Width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  Dimensions.Radius20 * 2,
                ),
                topLeft: Radius.circular(
                  Dimensions.Radius20 * 2,
                ),
              ),
            ),
            //! if the item in the Cart is less than zero show an empty container unless show the itesm
            child: cartTotalItems.getItemsInCart.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.Height20,
                          bottom: Dimensions.Height20,
                          right: Dimensions.Width20,
                          left: Dimensions.Width20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            Dimensions.Radius20,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.Width10 / 2,
                            ),
                            //! convert the int to string because it will display as text in our ui
                            //! and also i used incartitems so whenever we close the product and open it we will still meet the value we set so we can either add to it or reduce it
                            BigText(
                              text:
                                  '\$' + cartTotalItems.totalAmount.toString(),
                            ),
                            SizedBox(
                              width: Dimensions.Width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.Height20,
                          bottom: Dimensions.Height20,
                          right: Dimensions.Width20,
                          left: Dimensions.Width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.Radius20,
                          ),
                          color: AppColors.mainColor,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //! check if the user is logged in or not loading the controller
                            if (Get.find<AuthController>().userLoggedIn()) {
                              print('tapped');
                              cartTotalItems.addToHistory();
                            } else {
                              //! go to sign in page if user is not logged in
                              Get.toNamed(
                                RouteHelper.getSignInPage(),
                              );
                            }

                            // popularProductQuantity.addItemToCart(popularProduct);
                          },
                          child: BigText(
                            //! using a variable inside a string
                            //! if your variable is part of an object you will need this {} or if you want to get a variable from an object
                            text: 'Check Out',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
