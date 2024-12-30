//! for responsiveness on different android devices
import 'package:get/get.dart';

//TODO change the width you divided by to 411.42857142857144 and height 843.4285714285714
class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  //? dynamic Container height
  static double pageViewContainer = screenHeight / 3.833766233766234;
  static double pageView = screenHeight / 2.635714285714286;
  static double pageViewTextContainer120 = screenHeight / 7.03;
  //? dynamic height
  static double Height10 = screenHeight / 84.34285714285714;
  static double Height15 = screenHeight / 56.22857142857143;
  static double Height20 = screenHeight / 42.17142857142857;
  static double Height30 = screenHeight / 28.11428571428571;
  static double Height80 = screenHeight / 10.54285714285714;
  static double Height45 = screenHeight / 18.74285714285714;
  static double Height100 = screenHeight / 8.434285714285714;
  static double Height120 = screenHeight / 7.028571428571428;
  //? dynamic width and also padding and margin
  static double Width10 = screenHeight / 84.34285714285714;
  static double Width15 = screenHeight / 56.22857142857143;
  static double Width20 = screenHeight / 42.17142857142857;
  static double Width30 = screenHeight / 28.11428571428571;
  static double Width80 = screenHeight / 10.54285714285714;

  //? Icon Size
  static double IconSize24 = screenHeight / 35.14285714285714;
  static double IconSize16 = screenHeight / 52.71428571428571;
  static double IconSize75 = screenHeight / 11.24571428571429;

  //? Splash Screen Dimension
  static double splashImg = screenHeight / 3.3737142857142857;

  //? dynamic fonts size
  static double Font14 = screenHeight / 60.24489795918367;
  static double Font40 = screenHeight / 21.08571428571429;
  static double Font16 = screenHeight / 52.71428571428571;
  static double Font20 = screenHeight / 42.17142857142857;
  static double Font18 = screenHeight / 46.85714285714286;
  static double Font26 = screenHeight / 32.43956043956044;
  //? list view container size
  static double ListViewImgSize120 = screenHeight / 7.028571428571425;
  static double ListViewTextContainer100 = screenWidth / 4.1142;

  //? Popular Food
  static double PopularFoodImgSize = screenHeight / 2.409795918367347;

  //? dynamic border radius size
  static double Radius15 = screenHeight / 56.22857142857143;
  static double Radius20 = screenHeight / 42.17142857142857;
  static double Radius30 = screenHeight / 28.11428571428571;

  //? Bottom Height
  static double BottomHeightBar = screenHeight / 7.028571428571428;
}
