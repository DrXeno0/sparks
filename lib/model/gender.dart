enum Gender { male, female, unknown }

extension GenderX on Gender {
  String assetPath() {
    switch (this) {
      case Gender.male:
        return 'assets/icons/male.svg';
      case Gender.female:
        return 'assets/icons/female.svg';
      default:
        return 'assets/icons/not_applicable.svg';
    }
  }
}
