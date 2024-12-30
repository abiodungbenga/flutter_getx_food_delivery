import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

import 'package:food_delivery_app/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconcolor;
  const IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconcolor, size: Dimensions.IconSize24),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
