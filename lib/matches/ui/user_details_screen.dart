import 'package:flutter/material.dart';

import '../model/user_profile.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserProfile userProfile;

  const UserDetailsScreen({Key? key, required this.userProfile}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool matchClicked = false;
  bool crossClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userProfile.name + "'s Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.userProfile.profilePicture),
              radius: 150,
            ),
            SizedBox(height: 20),
            Text(
              widget.userProfile.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${widget.userProfile.age ?? "N/A"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bio: ${widget.userProfile.bio}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Club: ${widget.userProfile.club}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Varsity: ${widget.userProfile.varsity}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      matchClicked = false;
                    });
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        matchClicked = true;
                        crossClicked = false;
                      });
                      // Add your logic for the match button click
                    },
                    style: ElevatedButton.styleFrom(
                      primary: matchClicked ? Colors.green : Colors.grey,
                    ),
                    child: Text('Match'),
                  ),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      crossClicked = false;
                    });
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        crossClicked = true;
                        matchClicked = false;
                      });
                      // Add your logic for the cross button click
                    },
                    style: ElevatedButton.styleFrom(
                      primary: crossClicked ? Colors.red : Colors.grey,
                    ),
                    child: Text('Cross'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
