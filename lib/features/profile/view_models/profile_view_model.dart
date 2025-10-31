import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  AsyncValue<ProfileModel> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final profile = await repository.getProfile();
      state = AsyncValue.data(profile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<void> logout() async {
    try {
      final repository = ref.read(profileRepositoryProvider);
      await repository.logout();
      // Clear local state and navigate to login
      // This would typically be handled by an auth state provider
    } catch (error) {
      // Handle logout error
    }
  }
}