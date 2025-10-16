import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/cart_state.dart';
import '../state/menu_state.dart';
import './cart_screen.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CartTotals = ref.watch(cartTotalProvider);
    
    return Scaffold(
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Menu Pilihan'),
          centerTitle: false,
          floating: true,
          pinned: true,
          expandedHeight: 60,
          backgroundColor: Colors.white,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                ),
                if (CartTotals.quantity > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${CartTotals.quantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
        SliverToBoxAdapter(
          child: CategoryList(),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(12.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final selectedCategory = ref.watch(selectedCategoryProvider);
                final allItems = ref.watch(menuStateProvider);
                final filteredItems = selectedCategory == 'Semua'
                    ? allItems
                    : allItems.where((item) => item.category == selectedCategory).toList();
                
                if (index >= filteredItems.length) return null;
                final item = filteredItems[index];
                
                return MenuItemCard(
                  id: item.id,
                  name: item.name,
                  price: item.price,
                  imagePath: item.imagePath,
                );
              },
              childCount: ref.watch(selectedCategoryProvider) == 'Semua'
                  ? ref.watch(menuStateProvider).length
                  : ref.watch(menuStateProvider)
                      .where((item) => item.category == ref.watch(selectedCategoryProvider))
                      .length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class CategoryList extends ConsumerWidget {
  static const List<String> categories = [
    'Semua',
    'Kopi',
    'Non-Kopi',
    'Makanan Ringan',
    'Promo Hari Ini'
  ];

  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            label: category,
            isSelected: category == selectedCategory,
            onTap: () => ref.read(selectedCategoryProvider.notifier).select(category),
          );
        },
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.teal.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
          backgroundColor: isSelected ? Colors.teal : Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: isSelected
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    ),
    );
  }
}

class MenuItemCard extends ConsumerWidget {
  final String id;
  final String name;
  final int price;
  final String imagePath;

  const MenuItemCard({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                'assets/coffee.jpg', // Use default image for now
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.teal.shade50,
                  alignment: Alignment.center,
                  child: const Icon(Icons.coffee_maker, size: 45, color: Colors.teal),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${price.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.teal),
                      onPressed: () {
                        ref.read(cartProvider.notifier).addItem(id, name, price);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name ditambahkan ke keranjang'),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'LIHAT',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CartScreen()),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}