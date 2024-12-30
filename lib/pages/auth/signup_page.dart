import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! creating controller variables
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var passwordConfirmationController = TextEditingController();

    //! validations for the form fields
    void _registration(AuthController authController) {
      //! loading the controller
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String passwordConfirmation = passwordConfirmationController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      //! check if the fields are empty
      if (name.isEmpty) {
        showCustomSnackBar('Name cannot be empty', title: 'Name');
      } else if (passwordConfirmation.isEmpty) {
        showCustomSnackBar('Confirm Your Password',
            title: 'Password Verification');
      } else if (email.isEmpty) {
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
        //! creating a sign up object
        SignUpBody signUpBody = SignUpBody(
          name: name,
          email: email,
          passwordConfirmation: passwordConfirmation,
          password: password,
        );
        //! call the registration method in our controller
        //! then we grab the response as status
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            //! if login is successful go to our home page that is initial route
            Get.toNamed(
              RouteHelper.getInitial(),
            );
          } else {
            showCustomSnackBar(status.message);
          }
        });

        print(
          signUpBody.toString(),
        );
      }
    }

    var signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      //! wrap around getbuilder so we can get an instance of the controller and use it in our app
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          //! for the preloader if the auth controller is loading
          return _authController.isLoading
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
                      AppTextField(
                        textController: nameController,
                        icon: Icons.person,
                        hintText: 'Name',
                      ),
                      SizedBox(
                        height: Dimensions.Height20,
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
                      AppTextField(
                        isObscure: true,
                        textController: passwordConfirmationController,
                        icon: Icons.password_sharp,
                        hintText: 'Password Confirmation',
                      ),
                      SizedBox(
                        height: Dimensions.Height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(
                            _authController,
                          );
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
                              text: 'Sign Up',
                              size: Dimensions.Font40 - 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.Height10,
                      ),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: 'Have an account already?',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.Font20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.Height10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Use one of the following methods',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.Font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.Radius30,
                              backgroundImage: AssetImage(
                                'assets/image/' + signUpImages[index],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
