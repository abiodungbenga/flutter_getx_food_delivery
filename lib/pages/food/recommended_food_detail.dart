import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';

import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedProduct = Get.find<RecommendedProductController>()
        .recommendedProductsList[pageId];
    Get.find<PopularProductController>().initProduct(
      //! having an instance of cart controller
      recommendedProduct, Get.find<CartController>(),
    );
    return Scaffold(
      body: CustomScrollView(
        //! it is the slivers that enables the image to dissapear slowly
        slivers: [
          SliverAppBar(
            //! to disable the back button that is there automatically
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //! if it is from cart page redirect to cart page
                    if (page == 'cartage') {
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
                    icon: Icons.clear,
                    size: Dimensions.Font40,
                  ),
                ),
                // AppIcon(
                //   icon: Icons.shopping_cart_outlined,
                // ),
                GetBuilder<PopularProductController>(
                  builder: (controllerToShowItemInCartOnIcon) {
                    return GestureDetector(
                      child: GestureDetector(
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
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
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
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.Radius20),
                    topRight: Radius.circular(Dimensions.Radius20),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                child: Center(
                  child: Container(
                    child: BigText(
                      size: Dimensions.Font26,
                      text: recommendedProduct.name,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.yellow,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +
                    recommendedProduct.img,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                  ),
                  child: ExpandableTextWidget(
                    text: recommendedProduct.description,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductQuantity) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.Width20 * 2.5,
                  right: Dimensions.Width20 * 2.5,
                  top: Dimensions.Height10,
                  bottom: Dimensions.Height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProductQuantity.setQuantity(false);
                      },
                      child: AppIcon(
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.remove,
                        iconcolor: Colors.white,
                        Iconsize: Dimensions.IconSize24,
                      ),
                    ),
                    BigText(
                      text: '\$ ${recommendedProduct.price}  X' +
                          ' ${popularProductQuantity.inCartItems} ',
                      color: AppColors.mainBlackColor,
                      size: Dimensions.Font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProductQuantity.setQuantity(true);
                      },
                      child: AppIcon(
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.add,
                        iconcolor: Colors.white,
                        Iconsize: Dimensions.IconSize24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProductQuantity
                            .addItemToCart(recommendedProduct);
                      },
                      child: Container(
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
                        child: BigText(
                          text: '\$ ${recommendedProduct.price} | Add to cart',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
