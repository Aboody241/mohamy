import 'package:flutter/material.dart';
import 'package:mohamy/features/settings/UI/pages/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../features/add_case/UI/pages/add_case_screen.dart';
import '../../features/casses_list/UI/pages/cases_list_screen.dart';
import '../../features/home/UI/home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> get _screens => const [
        HomeScreen(),
        AddCaseScreen(),
        CasesListScreen(mode: CasesListMode.view),
        ProfilePage(),
      ];

  List<PersistentBottomNavBarItem> get _navItems => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          title: 'الرئيسية',
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add_circle_outline),
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          title: 'إضافة قضية',
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt),
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          title: 'قائمة القضايا',
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          title: 'الملف الشخصي',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navItems,
      navBarStyle: NavBarStyle.style6,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16),
        colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
      ),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardAppears: true,
      confineToSafeArea: true,
    );
  }
}
