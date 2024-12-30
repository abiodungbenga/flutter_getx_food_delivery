import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/account/account_page.dart';
import 'package:food_delivery_app/pages/auth/signup_page.dart';
import 'package:food_delivery_app/pages/cart/cart_history.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //! declaring a variable because we want to change the index dynamically
  // int _selectedIndex = 0;
  late PersistentTabController _controller;

  // List pages = [
  //   MainFoodPage(),
  //   Container(
  //     child: Center(
  //       child: Text(
  //         'Next Page',
  //       ),
  //     ),
  //   ),
  //   Container(
  //     child: Center(
  //       child: Text(
  //         'Next Page',
  //       ),
  //     ),
  //   ),
  //   Container(
  //     child: Center(
  //       child: Text(
  //         'Next Page',
  //       ),
  //     ),
  //   ),
  // ];
  // //! function for the tapping of the bottom navbar and it takes in an int because _selectedIndex is an integer so it takes it as an index
  // void onTapNav(int index) {
  //   //! our UI needs to change so using set state will show it in our UI
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  //! the pages
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: Center(
          child: Text(
            'History Page',
          ),
        ),
      ),
      const CartHistory(),
      AccountPage(),
    ];
  }

  //! the list of icons
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
          size: Dimensions.IconSize24,
        ),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.archivebox_fill,
          size: Dimensions.IconSize24,
        ),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.cart_fill,
          size: Dimensions.IconSize24,
        ),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.person,
          size: Dimensions.IconSize24,
        ),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     //! using index to switch between the pages
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       //! as we are changing the index from the ontap function we need to assign it for changing but assigning the icon
  //       currentIndex: _selectedIndex,
  //       onTap: onTapNav,
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.home_outlined,
  //           ),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.archive,
  //           ),
  //           label: 'history',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.shopping_cart,
  //           ),
  //           label: 'Cart',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.person,
  //           ),
  //           label: 'me',
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
