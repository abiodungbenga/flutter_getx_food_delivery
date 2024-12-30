import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //! for the refreshing to refresh the controller and onrefresh takes future void
    Future<void> _loadResources() async {
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>()
          .getRecommendedProductList();
    }

    //! referesh indicator so i can refresh the screen for data changes
    return RefreshIndicator(
      color: AppColors.mainColor,
      child: Column(
        children: [
          //! showing the header
          Container(
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.Width20,
                right: Dimensions.Width20,
              ),
              margin: EdgeInsets.only(
                top: Dimensions.Height45,
                bottom: Dimensions.Height15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Nigeria",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'Gbenga',
                            color: Colors.black54,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                          )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.IconSize24,
                      ),
                      width: Dimensions.Height45,
                      height: Dimensions.Height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.Radius15,
                        ),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! showing the body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          )
        ],
      ),
      onRefresh: _loadResources,
    );
  }
}
