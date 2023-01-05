import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view/dashboard/user/user_list_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      SafeArea(child: Text('home')),
      SafeArea(child: Text('chat')),
      SafeArea(child: Text('add')),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
        ),
        inactiveIcon: const Icon(
          Icons.home,
          color: AppColors.lightBlue,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        inactiveIcon: const Icon(
          Icons.message,
          color: AppColors.lightBlue,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        inactiveIcon: const Icon(
          Icons.add,
          color: AppColors.lightBlue,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.list),
        inactiveIcon: const Icon(
          Icons.list,
          color: AppColors.lightBlue,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        inactiveIcon: const Icon(
          Icons.person,
          color: AppColors.lightBlue,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItems(),
      controller: controller,
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
