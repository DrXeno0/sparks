import 'gender.dart';

class ProfileCardInfo {
  final String id;
  final String name;
  final String division;
  final Gender gender;
  final String? imageUrl;

  const ProfileCardInfo({
    required this.id,
    required this.name,
    required this.division,
    this.gender = Gender.unknown,
    this.imageUrl,
  });

  /* ── utilities ───────────────────────────────────────── */

  ProfileCardInfo copyWith({
    String? id,
    String? name,
    String? division,
    Gender? gender,
    String? imageUrl,
  }) =>
      ProfileCardInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        division: division ?? this.division,
        gender: gender ?? this.gender,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory ProfileCardInfo.fromJson(Map<String, dynamic> json) =>
      ProfileCardInfo(
        id: json['id'] as String,
        name: json['name'] as String,
        division: json['division'] as String,
        gender: Gender.values
            .firstWhere((g) => g.name == json['gender'], orElse: () => Gender.unknown),
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'division': division,
    'gender': gender.name,
    'imageUrl': imageUrl,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProfileCardInfo &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
