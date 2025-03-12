import 'package:flutter/material.dart';
import 'add_clothing_item.dart';
import '../../models/clothing_item.dart';
import 'screens/capture_image_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/additional_details_screen.dart';
import 'screens/review_item_screen.dart';

class AddClothingItemLauncher {
  /// Launch the add clothing item flow
  static Future<bool?> launch(BuildContext context, {Function(ClothingItem)? onItemAdded}) async {
    return await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => AddClothingItemFlow(onItemAdded: onItemAdded),
      ),
    );
  }
}