import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/login_body_model.dart';
import 'package:food_delivery_app/pages/auth/signup_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/test/test_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! creating controller variables

    var passwordController = TextEditingController();

    var emailController = TextEditingController();

    void _login(AuthController authController) {
      //! loading the controller
      // var authController = Get.find<AuthController>();

      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      //! check if the fields are empty
      if (email.isEmpty) {
        showCustomSnackBar('Email cannot be empty', title: 'Email');
      } //! getx has a property called utils to check if something is email or anything or not
      else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Email is not valid', title: 'Invalid Email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Password cannot be empty', title: 'Password');
      }
      //?! if password length is less than 6
      else if (password.length < 6) {
        showCustomSnackBar('Password cannot be less that six characters',
            title: 'Password');
      } //! if all this conditions are met post the request to the server
      else {
        // showCustomSnackBar('Success to login', title: 'Success');

        //! creating an instance of the login body
        LoginBody loginBody = LoginBody(email: email, password: password);

        //! call the login method in our controller and pass in the email and password
        //! then we grab the response as status
        authController.login(loginBody).then((status) {
          if (status.isSuccess) {
            //! if login is successful go to our home page that is initial route
            // Get.to(
            //   TestPage(),
            // );
            Get.toNamed(
              RouteHelper.getInitial(),
            );
          } //! print error from server
          else {
            showCustomSnackBar(status.message);
          }
        });

        // print(
        //   signUpBody.toString(),
        // );
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        //! wrap around getbuilder so we can get an instance of the controller and use it in our app
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return authController.isLoading
                ? CustomLoader()
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimensions.Radius20 * 4,
                              backgroundImage:
                                  AssetImage('assets/image/logo part 1.png'),
                            ),
                          ),
                        ),
                        Container(
                          //! when using a container make sure you put the width if you want to align something
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: Dimensions.Width20,
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontSize: Dimensions.Font20 * 3 +
                                      Dimensions.Font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sign in into your account',
                                style: TextStyle(
                                  fontSize: Dimensions.Font20,
                                  color: Colors.grey[500],
                                  // fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        AppTextField(
                          textController: emailController,
                          icon: Icons.email,
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: Dimensions.Height20,
                        ),
                        AppTextField(
                          isObscure: true,
                          textController: passwordController,
                          icon: Icons.password_rounded,
                          hintText: 'Password',
                        ),
                        SizedBox(
                          height: Dimensions.Height20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            RichText(
                              text: TextSpan(
                                // recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                                text: 'Sign into your account',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.Font20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.Width20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            //! calling the function created at the top and pass the controller object
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(
                                Dimensions.Radius30,
                              ),
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Sign in',
                                size: Dimensions.Font40 - 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                            // recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.Font20,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                        () => SignUpPage(),
                                        transition: Transition.fade,
                                      ),
                                text: ' Create',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.Font20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }
}
