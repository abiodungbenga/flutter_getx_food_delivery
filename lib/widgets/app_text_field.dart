import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final String hintText;
  bool isObscure;
  AppTextField({
    super.key,
    required this.textController,
    required this.icon,
    required this.hintText,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.Height20,
        right: Dimensions.Height20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.Radius15,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(
              1,
              1,
            ),
            color: Colors.grey.withOpacity(
              0.2,
            ),
          )
        ],
      ),
      child: TextField(
        //! if it is true set it to true and false set it to false
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
          //!hint text, prefix icon, focused and enabled border, border radius
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.Radius15,
            ),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.Radius15,
            ),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.Radius15,
            ),
          ),
        ),
      ),
    );
  }
}
