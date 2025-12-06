import 'package:flutter/material.dart';
import 'dart:io';
import '../../../models/clothing_item.dart';
import 'package:intl/intl.dart';


class ReviewItemScreen extends StatelessWidget {
  final ClothingItem item;
  final File? image;
  final Function(int) onEdit;
  final VoidCallback onSave;
  
  const ReviewItemScreen({
    Key? key,
    required this.item,
    required this.image,
    required this.onEdit,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Review your item',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Make sure everything looks good before adding to your closet.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          // Item preview
          AspectRatio(
            aspectRatio: 4/5,
            child: Container(
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Image
                    if (image != null)
                      Positioned.fill(
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    
                    // Edit image button
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () => onEdit(0), // Go to image capture screen
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    
                    // Item details overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: item.color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                if (item.size != null)
                                  Text(
                                    item.size!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Basic details section
          _buildDetailsSection(
            context,
            title: 'Basic Details',
            onEdit: () => onEdit(1), // Go to basic details screen
            content: Column(
              children: [
                _buildDetailRow('Name', item.name),
                _buildDetailRow('Category', item.category),
                _buildDetailRow('Color', '', trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                )),
              ],
            ),
          ),
          
          // Additional details section
          _buildDetailsSection(
            context,
            title: 'Additional Details',
            onEdit: () => onEdit(2), // Go to additional details screen
            content: Column(
              children: [
                if (item.brand != null)
                  _buildDetailRow('Brand', item.brand!),
                if (item.size != null)
                  _buildDetailRow('Size', item.size!),
                if (item.purchasePrice != null)
                  _buildDetailRow('Price', currencyFormat.format(item.purchasePrice)),
                if (item.seasons != null && item.seasons!.isNotEmpty)
                  _buildDetailRow('Seasons', item.seasons!.join(', ')),
                if (item.occasions != null && item.occasions!.isNotEmpty)
                  _buildDetailRow('Occasions', item.occasions!.join(', ')),
                if (item.notes != null && item.notes!.isNotEmpty)
                  _buildDetailRow('Notes', item.notes!),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Add to closet button is handled in the parent widget
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Add to Closet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onSave,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
  
  Widget _buildDetailsSection(
    BuildContext context, {
    required String title,
    required VoidCallback onEdit,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ),
                  onPressed: onEdit,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Section content
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          trailing != null
              ? trailing
              : Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
