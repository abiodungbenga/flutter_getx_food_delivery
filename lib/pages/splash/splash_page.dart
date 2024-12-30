import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//! you will have to use with TickerProviderStateMixin provider state mixin if you want to use vsync
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //! creating the variable for animation
  late Animation<double> animation;
  //! creating the second variable for animation
  late AnimationController controller;

  //! function to load the controllers
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  //! initializing  the controller inside init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //! vysnc is optional
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      //! make sure you call the ..forward so the animation can begin
    )..forward();
    //! creating the type of animation you want
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    //! after three seconds of the screen loading take me to another page
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(
        RouteHelper.getInitial(),
      ),
    );
    //! loading all the controllers when the splash screen is loaded
    _loadResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/image/logo part 1.png',
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/image/logo part 2.png',
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
