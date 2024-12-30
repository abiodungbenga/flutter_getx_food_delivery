import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/popular_products_model.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  //! view port fraction is just to zoom in and out
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      //! state management set state
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  //! dispose the controller because you dont want any memory leak
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! to get the correct height or width of your device screen

    // print(
    //   'Current Height :' + MediaQuery.of(context).size.height.toString(),
    // );
    // print(
    //   'Current Width :' + MediaQuery.of(context).size.width.toString(),
    // );
    return Column(
      children: [
        //! slider section
        GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            //! if false show the container
            return popularProduct.isLoaded
                ? Container(
                    // color: Colors.red,
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProduct.popularProductsList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                          position,
                          popularProduct.popularProductsList[position],
                        ); //! sending a particular object on the list
                      },
                    ),
                    //! if false show the preloader
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        //! dots indicator
        GetBuilder<PopularProductController>(
          initState: (_) {},
          builder: (popularProduct) {
            return DotsIndicator(
              //! i the popular product  list is empty lets use one or else lets use the list from the serve
              dotsCount: popularProduct.popularProductsList.isEmpty
                  ? 1
                  : popularProduct.popularProductsList.length,
              position: _currentPageValue.toInt(),
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        ),
        //! popular text
        SizedBox(
          height: Dimensions.Height30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.Width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: 'Recommended',
              ),
              SizedBox(
                width: Dimensions.Width10,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 3,
                ),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.Width10,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 2,
                ),
                child: SmallText(
                  text: 'Food Pairing',
                ),
              ),
            ],
          ),
        ),
        //! List Of Food an Images
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProducts) {
            return recommendedProducts.isLoaded
                ? ListView.builder(
                    //! Since the whole page is scrollable i want the list to be scrollable too that is why i am using NeverScrollableScrollPhysics
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        recommendedProducts.recommendedProductsList.length,
                    //! using the index to get the images because it is in a list view builder
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          RouteHelper.getRecommendedFoodPage(index, 'home'),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.Width20,
                            right: Dimensions.Width20,
                            bottom: Dimensions.Height10,
                          ),
                          child: Row(
                            children: [
                              //! image in the Row
                              Container(
                                width: Dimensions.ListViewImgSize120, //120
                                height: Dimensions.ListViewImgSize120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.Radius20,
                                  ),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstants.BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          //! also using index from here
                                          recommendedProducts
                                              .recommendedProductsList[index]
                                              .img!,
                                    ),
                                  ),
                                ),
                              ),
                              //! text in the row
                              //! wraped with expanded so the container can take all the space available
                              Expanded(
                                child: Container(
                                  height:
                                      Dimensions.ListViewTextContainer100, //100
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        Dimensions.Radius20,
                                      ),
                                      bottomRight: Radius.circular(
                                        Dimensions.Radius20,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.Width10,
                                      right: Dimensions.Width10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: recommendedProducts
                                              .recommendedProductsList[index]
                                              .name,
                                        ),
                                        SizedBox(
                                          height: Dimensions.Height10,
                                        ),
                                        SmallText(
                                          text: 'With Chinese Characteristics',
                                        ),
                                        SizedBox(
                                          height: Dimensions.Height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: 'Normal',
                                              iconcolor: AppColors.iconColor1,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: '1.7m',
                                              iconcolor: AppColors.mainColor,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: '32min',
                                              iconcolor: AppColors.iconColor2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
      ],
    );
  }

  //! catching it over here
  Widget _buildPageItem(int index, ProductModel popularProductsList) {
    //! making the carousel stuff so the rest will disappear when you ar at the point you want
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var CurrentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - CurrentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var CurrentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - CurrentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1);
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var CurrentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - CurrentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1);
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var CurrentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, CurrentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(
                //! we are passing the index of the list here inside the function from the route helper
                RouteHelper.getPopularFoodPage(index, 'home'),
              );
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.Width10,
                right: Dimensions.Width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.Radius30,
                ),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProductsList.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.Height10 * 14,
              margin: EdgeInsets.only(
                left: Dimensions.Width30,
                right: Dimensions.Width30,
                bottom: Dimensions.Height30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.Radius30,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.Height10,
                  left: 15,
                  right: 15,
                ),
                child: AppColumn(
                  text: popularProductsList.name.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
