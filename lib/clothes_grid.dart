import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'models/clothing_item.dart';
import 'utils/constants.dart';
import 'utils/helpers.dart';
import 'widgets/common/app_card.dart';
import 'widgets/common/app_states.dart';

class ClothesGrid extends StatelessWidget {
  const ClothesGrid({Key? key}) : super(key: key);

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data
    final items = List.generate(
      20,
      (index) => ClothingItem(
        id: 'item_$index',
        name: 'Item $index',
        category: 'Category',
        imageUrl: 'https://picsum.photos/200',
        color: Colors.blue,
        brand: 'Brand',
        size: 'M',
        dateAdded: DateTime.now(),
      ),
    );

    return AnimationLimiter(
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.spacing16,
        crossAxisSpacing: AppConstants.spacing16,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: AppConstants.animNormal,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GlassCard(
                  onTap: () {
                    // TODO: Navigate to item details
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with shimmer loading
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppConstants.imageBorderRadius),
                          child: item.imageUrl != null 
                            ? CachedNetworkImage(
                                imageUrl: item.imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => AppShimmerLoading(
                                  child: Container(
                                    color: Theme.of(context).colorScheme.surfaceVariant,
                                  ),
                                ),
                                errorWidget: (context, url, error) => _buildPlaceholderImage(context),
                              )
                            : _buildPlaceholderImage(context),
                        ),
                      ),
                      
                      const SizedBox(height: AppConstants.spacing12),
                      
                      // Item details
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppConstants.spacing4),
                            if (item.brand != null) ...[
                              Text(
                                item.brand!,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppConstants.spacing8),
                            ],
                            Row(
                              children: [
                                if (item.size != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppConstants.spacing8,
                                      vertical: AppConstants.spacing4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                                    ),
                                    child: Text(
                                      item.size!,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: AppConstants.spacing8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.spacing8,
                                    vertical: AppConstants.spacing4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiaryContainer,
                                    borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
