import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/menu_view_model.dart';
import '../../theme/view_models/theme_view_model.dart';
import '../../cart/views/widgets/cart_button.dart';
import 'widgets/category_list.dart';
import 'widgets/menu_item_card.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final menuItems = ref.watch(menuViewModelProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
          SliverAppBar(
            title: const Text('Menu Pilihan'),
            centerTitle: false,
            floating: true,
            pinned: true,
            expandedHeight: 60,
            backgroundColor: theme.appBarTheme.backgroundColor,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.dark_mode,
                  color: theme.brightness == Brightness.dark
                      ? theme.colorScheme.primary
                      : null,
                ),
                onPressed: () {
                  // Toggle theme
                  ref.read(themeViewModelProvider.notifier).toggleTheme();
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  // Navigate to profile
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: CategoryList(),
          ),
          menuItems.when(
            data: (items) {
              if (items.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No items found'),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6, // Reduced ratio to fix overflow
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= items.length) return null;
                      return MenuItemCard(item: items[index]);
                    },
                    childCount: items.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: ${error.toString()}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom + 80,
            ),
          ), // Space for FAB and bottom nav
        ],
      )),
      floatingActionButton: const CartButton(),
    );
  }
}