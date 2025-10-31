import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile_model.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileRepository {
  // TODO: Replace with actual API call
  Future<ProfileModel> getProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    return ProfileModel(
      name: 'John Doe',
      email: 'john.doe@example.com',
      photoUrl: null,
      memberSince: '2023',
      totalOrders: 15,
      totalSpent: 450000,
    );
  }

  // TODO: Replace with actual API call
  Future<void> updateProfile(ProfileModel profile) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would make an API call to update the profile
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would clear auth tokens, local storage, etc.
  }
}