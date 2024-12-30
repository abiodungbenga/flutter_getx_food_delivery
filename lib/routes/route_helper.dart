import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

//! for routing and Navigation
class RouteHelper {
  //! name of the route
  static const String initial = '/';
  static const String splashPage = '/splash-page';
  static const String popularFoodPage = '/popular-food-page';
  static const String recommendedFoodPage = '/recommended-food-page';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';

  //! passing it as fuction so you can pass parameters
  static String getInitial() => '$initial';
  static String getSplashPage() => '$splashPage';
  //! passing pageID as a parameter
  static String getPopularFoodPage(int pageId, String page) =>
      //! this is how to pass parameters to the route
      '$popularFoodPage?pageId=$pageId&page=$page';
  static String getRecommendedFoodPage(int pageId, String page) =>
      '$recommendedFoodPage?pageId=$pageId&page=$page';
  //! where the param came from that you where thinking about
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    //! for navigation
    GetPage(
      name: splashPage,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: () => HomePage(),
    ),
    GetPage(
      name: popularFoodPage,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetails(
          //! parse the pageId to integer
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFoodPage,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signIn,
      page: () {
        return SignInPage();
      },
      transition: Transition.fade,
    ),
  ];
}
