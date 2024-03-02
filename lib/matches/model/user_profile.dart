class UserProfile {
  final String name;
  final String profilePicture;
  final int? age;
  final String bio;
  final String club;
  final String varsity;

  UserProfile({
    required this.name,
    required this.profilePicture,
    this.age,
    required this.bio,
    required this.club,
    required this.varsity,
  });
}
