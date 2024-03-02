import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../matches/data/user_profiles_list.dart';
import '../../matches/model/user_profile.dart';
import '../../matches/ui/user_details_screen.dart';

class SearchController extends GetxController {
  final RxList<String> searchHistory = <String>[].obs;
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required List userProfiles}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserProfile> _filteredProfiles = [];
  late final SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = Get.put(SearchController());
    _filteredProfiles = [];
  }

  void _updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProfiles = [];
      } else {
        _filteredProfiles = UserProfilesList().userProfiles
            .where((profile) =>
        profile.name.toLowerCase().contains(query.toLowerCase()) ||
            profile.club.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _saveSearchHistory(String query) {
    if (!searchController.searchHistory.contains(query)) {
      searchController.searchHistory.add(query);
    }
  }

  void _removeSearchHistoryItem(String item) {
    searchController.searchHistory.remove(item);
  }

  void _clearAllSearchHistory() {
    searchController.searchHistory.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name or username',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _updateSearchResults('');
                  },
                ),
              ),
              onChanged: (query) {
                _updateSearchResults(query);
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _filteredProfiles
                    .map((userProfile) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    _removeSearchHistoryItem(userProfile.name);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      AssetImage(userProfile.profilePicture),
                    ),
                    title: Text(userProfile.name),
                    subtitle: Text('@${userProfile.club}'),
                    onTap: () {
                      Get.to(() =>
                          UserDetailsScreen(userProfile: userProfile));
                      _saveSearchHistory(userProfile.name);
                    },
                  ),
                  background: Container(
                    color: Colors.red,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            // Display search history
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Search History', style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: _clearAllSearchHistory,
                  child: Text('Clear All'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Obx(() => Column(
              children: searchController.searchHistory
                  .map((item) => Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  _removeSearchHistoryItem(item);
                },
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(item),
                      ),
                    ],
                  ),
                  onTap: () {
                    _searchController.text = item;
                    _updateSearchResults(item);
                  },
                ),
                background: Container(
                  color: Colors.red,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }
}
