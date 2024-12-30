import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({super.key, required this.appIcon, required this.bigText});
  AppIcon appIcon;
  BigText bigText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.Width20,
        top: Dimensions.Width10,
        bottom: Dimensions.Width10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.Width20,
          ),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
