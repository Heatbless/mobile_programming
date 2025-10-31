import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/menu_item_model.dart';
import '../../../cart/view_models/cart_view_model.dart';
import '../../../cart/models/cart_item.dart';

class MenuItemCard extends ConsumerWidget {
  final MenuItemModel item;

  const MenuItemCard({
    required this.item,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.brightness == Brightness.dark
            ? Colors.grey.shade800
            : Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Show item details dialog
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1.0,
              child: item.imageUrl != null
                ? item.imageUrl!.startsWith('http')
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                      )
                : Container(
                    color: theme.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.restaurant,
                      size: 32,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${item.price.toStringAsFixed(0)}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final cartItem = CartItem(
                            id: item.id,
                            name: item.name,
                            price: item.price.toInt(),
                            quantity: 1,
                          );
                          ref.read(cartViewModelProvider.notifier).addToCart(cartItem);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${item.name} to cart'),
                              duration: const Duration(milliseconds: 800),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_circle, size: 24),
                        color: theme.colorScheme.primary,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                        ),
                    ],
                      ),
                    ],
                  ),
              ),
          ],
        ),
      ),
    );
  }
}