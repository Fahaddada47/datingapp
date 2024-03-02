// search_controller.dart
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<String> searchHistory = <String>[].obs;

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
    }
  }

  void removeFromSearchHistory(String query) {
    searchHistory.remove(query);
  }
}
