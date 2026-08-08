import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String profileImageUrl;

  const UserModel({
    required this.name,
    required this.email,
    this.profileImageUrl = '',
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profileImageUrl,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [name, email, profileImageUrl];
}
