import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';

import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';

import '../../routes/route_helper.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetails({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! getting the instance from the product model
    //! from this variable we extract all the data needed in this page
    var popularProduct =
        //! in your ui you dont want to call cart controller you call product controller then product controller will call cart controller
        Get.find<PopularProductController>().popularProductsList[pageId];
    Get.find<PopularProductController>().initProduct(
      //! having an instance of cart controller
      popularProduct, Get.find<CartController>(),
    );
    //! testing the page id and the product name
    // print(
    //   'page Id is ' + pageId.toString(),
    // );
    // print(
    //   'page name is ' + product.name.toString(),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //! background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.PopularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img,
                  ),
                ),
              ),
            ),
          ),
          //!icon widget
          Positioned(
            top: Dimensions.Height45,
            left: Dimensions.Width20,
            right: Dimensions.Width20,
            child: Row(
              //! main axis is vertical cross axis is horizontal
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //! if it is from cart page redirect to cart page
                    if (page == 'cartpage') {
                      Get.toNamed(
                        RouteHelper.getCartPage(),
                      );
                    } else {
                      Get.toNamed(
                        RouteHelper.getInitial(),
                      );
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    size: Dimensions.Font40,
                  ),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controllerToShowItemInCartOnIcon) {
                    return GestureDetector(
                      onTap: () {
                        //! the user wont be able to go to the cart page unless they have one or greater that one item in the cart
                        if (controllerToShowItemInCartOnIcon.totalItems >= 1)
                          Get.toNamed(
                            RouteHelper.getCartPage(),
                          );
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            size: Dimensions.Font40,
                          ),
                          //! check if the total items is more than one or equal to one
                          controllerToShowItemInCartOnIcon.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: Dimensions.Font20,
                                    iconcolor: Colors.transparent,
                                    backgroundcolor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          //! for the text
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: Dimensions.Height10 + 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //! introduction of food widget
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.PopularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.Height20,
                right: Dimensions.Width20,
                left: Dimensions.Width20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    Dimensions.Radius20,
                  ),
                  topLeft: Radius.circular(
                    Dimensions.Radius20,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: popularProduct.name,
                  ),
                  SizedBox(
                    height: Dimensions.Height20,
                  ),
                  BigText(
                    text: 'Introduce',
                  ),
                  SizedBox(
                    height: Dimensions.Height20,
                  ),
                  //! if you want to make a single part of your widget scrollable you can use expanded and single child scroll view
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: popularProduct.description,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! Expandable Text widget
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductQuantity) {
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
            child: Row(
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
                      GestureDetector(
                        onTap: () {
                          // print('Increment');
                          popularProductQuantity.setQuantity(false);
                        },
                        child: Icon(
                          size: Dimensions.IconSize24,
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.Width10 / 2,
                      ),
                      //! convert the int to string because it will display as text in our ui
                      //! and also i used incartitems so whenever we close the product and open it we will still meet the value we set so we can either add to it or reduce it
                      BigText(
                        text: popularProductQuantity.inCartItems.toString(),
                      ),
                      SizedBox(
                        width: Dimensions.Width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          // print('Increment');
                          popularProductQuantity.setQuantity(true);
                        },
                        child: Icon(
                          size: Dimensions.IconSize24,
                          Icons.add,
                          color: AppColors.signColor,
                        ),
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
                      popularProductQuantity.addItemToCart(popularProduct);
                    },
                    child: BigText(
                      //! using a variable inside a string
                      //! if your variable is part of an object you will need this {} or if you want to get a variable from an object
                      text: '\$ ${popularProduct.price} | Add to cart',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
