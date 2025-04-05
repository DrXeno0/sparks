class ProfileCardInfo {
  final String internId;
  final String name;
  final String division;
  final String gender; // "male", "female", or "other"
  final String imageUrl; // e.g. "assets/images/dummy.jpeg"
  bool isSaved; // mutable flag for saving the profile

  ProfileCardInfo({
    required this.internId,
    required this.name,
    required this.division,
    required this.gender,
    required this.imageUrl,
    this.isSaved = false,
  });
}