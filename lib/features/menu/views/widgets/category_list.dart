import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/menu_view_model.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryViewModelProvider);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: CategoryViewModel.categories.length,
        itemBuilder: (context, index) {
          final category = CategoryViewModel.categories[index];
          return CategoryChip(
            label: category,
            isSelected: category == selectedCategory,
            onTap: () => ref.read(categoryViewModelProvider.notifier)
                .selectCategory(category),
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
    final theme = Theme.of(context);
    
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
                color: isSelected 
                  ? theme.chipTheme.secondaryLabelStyle?.color
                  : theme.chipTheme.labelStyle?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
            backgroundColor: isSelected 
              ? theme.chipTheme.selectedColor
              : theme.chipTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: isSelected
                ? BorderSide.none
                : BorderSide(
                    color: theme.brightness == Brightness.dark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}