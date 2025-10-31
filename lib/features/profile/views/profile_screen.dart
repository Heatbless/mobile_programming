import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/theme/view_models/theme_view_model.dart';
import '../view_models/profile_view_model.dart';
import 'widgets/profile_stats_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load profile when screen is first shown
    Future.microtask(() {
      ref.read(profileViewModelProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.dark_mode,
              color: theme.brightness == Brightness.dark
                  ? theme.colorScheme.primary
                  : null,
            ),
            onPressed: () {
              ref.read(themeViewModelProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: profile.when(
        data: (profile) => RefreshIndicator(
          onRefresh: () =>
              ref.read(profileViewModelProvider.notifier).refreshProfile(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profile Image and Name
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      child: profile.photoUrl != null
                          ? ClipOval(
                              child: Image.network(
                                profile.photoUrl!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: theme.colorScheme.primary,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.email,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Member sejak ${profile.memberSince}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Stats
              Row(
                children: [
                  Expanded(
                    child: ProfileStatsCard(
                      icon: Icons.shopping_bag_outlined,
                      value: profile.totalOrders.toString(),
                      label: 'Total Pesanan',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileStatsCard(
                      icon: Icons.payments_outlined,
                      value:
                          'Rp ${(profile.totalSpent / 1000).toStringAsFixed(0)}K',
                      label: 'Total Pengeluaran',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Menu Items
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit_outlined),
                      title: const Text('Edit Profil'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to edit profile
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Ubah Password'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to change password
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.notifications_outlined),
                      title: const Text('Notifikasi'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to notifications settings
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Logout Button
              ElevatedButton.icon(
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Ya'),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true) {
                    // ignore: use_build_context_synchronously
                    await ref.read(profileViewModelProvider.notifier).logout();
                    // Navigate to login
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.errorContainer,
                  foregroundColor: theme.colorScheme.onErrorContainer,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: ${error.toString()}',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }
}