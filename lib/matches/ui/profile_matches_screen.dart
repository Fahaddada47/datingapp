import 'package:datingapp/matches/ui/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/user_profiles_list.dart';
import '../model/user_profile.dart';

class ProfileMatchesScreen extends StatefulWidget {
  final UserProfilesList userProfilesList;

  const ProfileMatchesScreen({Key? key, required this.userProfilesList})
      : super(key: key);

  @override
  State<ProfileMatchesScreen> createState() => _ProfileMatchesScreenState();
}

class _ProfileMatchesScreenState extends State<ProfileMatchesScreen> {
  final Map<int, RxBool> buttonStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches"),
      ),
      body: ListView.builder(
        itemCount: widget.userProfilesList.userProfiles.length,
        itemBuilder: (context, index) {
          final UserProfile userProfile = widget.userProfilesList.userProfiles[index];

          if (!buttonStates.containsKey(index)) {
            buttonStates[index] = true.obs;
          }

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundImage: AssetImage(userProfile.profilePicture),
              ),
              title: Text(userProfile.name),
              subtitle: Text(
                'Age: ${userProfile.age ?? "N/A"} | ${userProfile.bio}',
              ),
              onTap: () {
                Get.to(() => UserDetailsScreen(userProfile: userProfile));
                Get.snackbar(
                  'Profile Tapped',
                  'Viewing ${userProfile.name}\'s profile',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              trailing: Obx(
                    () => ElevatedButton(
                  onPressed: () {

                    buttonStates[index]!.toggle();

                    print('Custom Action for ${userProfile.name}');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: buttonStates[index]!.value ? Colors.blue : Colors.grey,
                  ),
                  child: Text('Connect'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
