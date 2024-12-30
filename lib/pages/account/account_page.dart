import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! loading the controller as a bool value
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    //! checking if the user has logged in already
    if (_userLoggedIn) {
      // print('User logged in');
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          color: Colors.white,
          size: Dimensions.Font20 + 4,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          //! check if user has logged in if it is true display the container of profile page
          return _userLoggedIn
              ? (userController.isLoading
                  //! if the user controller is loading show custom Loader if not show the container page
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        top: Dimensions.Height20,
                      ),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            iconcolor: Colors.white,
                            backgroundcolor: AppColors.mainColor,
                            size: Dimensions.Height15 * 10,
                            Iconsize: Dimensions.IconSize75,
                          ),
                          SizedBox(
                            height: Dimensions.Height30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //! name
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      iconcolor: Colors.white,
                                      backgroundcolor: AppColors.mainColor,
                                      size: Dimensions.Height10 * 5,
                                      Iconsize: Dimensions.Height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      //! so everything or information from the controller becomes nullable
                                      text: userController.userModel!.name,
                                    ),
                                  ),
                                  // //! phone
                                  // SizedBox(
                                  //   height: Dimensions.Height20,
                                  // ),
                                  // AccountWidget(
                                  //   appIcon: AppIcon(
                                  //     icon: Icons.phone,
                                  //     iconcolor: Colors.white,
                                  //     backgroundcolor: Colors.yellow,
                                  //     size: Dimensions.Height10 * 5,
                                  //     Iconsize: Dimensions.Height10 * 5 / 2,
                                  //   ),
                                  //   bigText: BigText(text: '09138186491'),
                                  // ),
                                  SizedBox(
                                    height: Dimensions.Height20,
                                  ),
                                  //! email
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      iconcolor: Colors.white,
                                      backgroundcolor: AppColors.yellowColor,
                                      size: Dimensions.Height10 * 5,
                                      Iconsize: Dimensions.Height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.email,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: Dimensions.Height20,
                                  // ),
                                  // //! address
                                  // AccountWidget(
                                  //   appIcon: AppIcon(
                                  //     icon: Icons.location_city,
                                  //     iconcolor: Colors.white,
                                  //     backgroundcolor: Colors.brown,
                                  //     size: Dimensions.Height10 * 5,
                                  //     Iconsize: Dimensions.Height10 * 5 / 2,
                                  //   ),
                                  //   bigText: BigText(
                                  //       text: '188 loburo mowe Ogun State'),
                                  // ),
                                  SizedBox(
                                    height: Dimensions.Height20,
                                  ),
                                  //! message
                                  GestureDetector(
                                    //! clearing every data in the cart or stored with shared preferences
                                    onTap: () {
                                      //! conditional statement that only if the user is logged in thats when they can log out
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        //! clearing the data so user can logout
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        //! clearing the cart data
                                        Get.find<CartController>().clear();
                                        //! clearing the cart History data
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        //! after clearing the data

                                        Get.offNamed(
                                          RouteHelper.getSignInPage(),
                                        );
                                      } else {
                                        print('logged OUT');
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        iconcolor: Colors.white,
                                        backgroundcolor: Colors.redAccent,
                                        size: Dimensions.Height10 * 5,
                                        Iconsize: Dimensions.Height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                        text: 'Log out',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.Height20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : CustomLoader())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.Height20 * 8,
                        margin: EdgeInsets.only(
                          left: Dimensions.Width20,
                          right: Dimensions.Width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.Radius30,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/image/signintocontinue.png',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.getSignInPage(),
                          );
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.Height20 * 5,
                          margin: EdgeInsets.only(
                            left: Dimensions.Width20,
                            right: Dimensions.Width20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.Radius30,
                            ),
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign In',
                              color: Colors.white,
                              size: Dimensions.Font26,
                            ),
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
