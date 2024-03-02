import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../matches/data/user_profiles_list.dart';
import '../../matches/ui/profile_matches_screen.dart';
import '../../my_profile/ui/my_profile_screen.dart';
import '../../search/ui/search_screen.dart';


class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key, required searchController}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  late final List<Widget> _screens;

  int _selectedScreenIndex = 0;

  final UserProfilesList userProfilesList = UserProfilesList();


  @override
  void initState() {
    super.initState();
    _screens = [
      ProfileMatchesScreen(userProfilesList: userProfilesList,),
      SearchScreen(userProfiles: [],),
      MyProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (int index) {
          _selectedScreenIndex = index;
          print(_selectedScreenIndex);
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
