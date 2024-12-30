import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';

import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/auth/signup_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';

import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  //! before you try to load your main apk try to load the dependencies here
  await dep.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //! putting this here so it can get the cart data before the app is loaded finished
    Get.find<CartController>().getCartData();
    //! wrap the Get Material APP with Get builder this is a nested getbuilder
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              getPages: RouteHelper.routes,
              title: 'Food Delivery App',
              initialRoute: RouteHelper.getSplashPage(),
              // home: const SignInPage(),
            );
          },
        );
      },
    );
  }
}
