class ProfileModel {
  final String name;
  final String email;
  final String? photoUrl;
  final String memberSince;
  final int totalOrders;
  final int totalSpent;

  ProfileModel({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.memberSince,
    required this.totalOrders,
    required this.totalSpent,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      memberSince: json['memberSince'] as String,
      totalOrders: json['totalOrders'] as int,
      totalSpent: json['totalSpent'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'memberSince': memberSince,
      'totalOrders': totalOrders,
      'totalSpent': totalSpent,
    };
  }
}