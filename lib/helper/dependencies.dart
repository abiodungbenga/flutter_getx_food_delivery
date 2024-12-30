import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/data/repository/recommended_product_repo.dart';
import 'package:food_delivery_app/data/repository/user_repo.dart';

import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';

Future<void> init() async {
  //! creating a variable to intialize get preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  //! loading the getx dependencies
  Get.lazyPut(() => sharedPreferences);
  //! API client
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: AppConstants.BASE_URL,
      //! calling shared preferences in our API client for the token
      sharedPreferences: Get.find(),
    ),
  );

  //! repository
  Get.lazyPut(
    () => AuthRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(
    () => PopularProductRepo(
      apiClient: Get.find(),
    ),
  );
  Get.lazyPut(
    () => RecommendedProductRepo(
      apiClient: Get.find(),
    ),
  );
  Get.lazyPut(() => UserRepo(
        apiClient: Get.find(),
      ));
  Get.lazyPut(
    () => CartRepo(
      //! beacuse of the cart repo that we passed shared preferences as a constructor
      sharedPreferences: Get.find(),
    ),
  );

  //! controller
  Get.lazyPut(
    () => AuthController(
      authRepo: Get.find(),
    ),
  );
  Get.lazyPut(
    () => UserController(
      userRepo: Get.find(),
    ),
  );
  Get.lazyPut(
    () => PopularProductController(
      popularProductRepo: Get.find(),
    ),
  );
  Get.lazyPut(
    () => RecommendedProductController(
      recommendedProductRepo: Get.find(),
    ),
  );
  Get.lazyPut(
    () => CartController(
      cartRepo: Get.find(),
    ),
  );
}
