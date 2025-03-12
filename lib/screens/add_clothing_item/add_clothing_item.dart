import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';



// Models
import '../../models/clothing_item.dart';

// Screens in the flow
import 'screens/capture_image_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/additional_details_screen.dart';
import 'screens/review_item_screen.dart';

class AddClothingItemFlow extends StatefulWidget {
  final Function(ClothingItem)? onItemAdded;
  
  const AddClothingItemFlow({Key? key, this.onItemAdded}) : super(key: key);

  @override
  _AddClothingItemFlowState createState() => _AddClothingItemFlowState();
}

class _AddClothingItemFlowState extends State<AddClothingItemFlow> {
  // The current step in the flow
  int _currentStep = 0;
  
  // Data for the clothing item being created
  File? _selectedImage;
  final ClothingItem _newItem = ClothingItem(
    id: const Uuid().v4(),
    name: '',
    category: '',
    dateAdded: DateTime.now(),
  );
  
  // Loading state
  bool _isLoading = false;
  String _loadingMessage = '';
  
  // Page controller for the flow
  final PageController _pageController = PageController();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  // Navigate to the next step
  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }
  
  // Navigate to the previous step
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    } else {
      // If on first step, close the flow
      Navigator.of(context).pop();
    }
  }
  
  // Handle image selection
  void _setImage(File image) {
    setState(() {
      _selectedImage = image;
    });
    _nextStep();
  }
  
  // Update clothing item basic details
  void _updateBasicDetails({
    required String name,
    required String category,
    required Color color,
  }) {
    setState(() {
      _newItem.name = name;
      _newItem.category = category;
      _newItem.color = color;
    });
    _nextStep();
  }
  
  // Update clothing item additional details
  void _updateAdditionalDetails({
    String? brand,
    String? size,
    List<String>? seasons,
    List<String>? occasions,
    String? notes,
    double? purchasePrice,
  }) {
    setState(() {
      _newItem.brand = brand;
      _newItem.size = size;
      _newItem.seasons = seasons;
      _newItem.occasions = occasions;
      _newItem.notes = notes;
      _newItem.purchasePrice = purchasePrice;
    });
    _nextStep();
  }
  
  // Save the clothing item
  // Save the clothing item
Future<void> _saveItem() async {
  if (_selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select an image for your item')),
    );
    return;
  }
  
  setState(() {
    _isLoading = true;
    _loadingMessage = 'Saving your item...';
  });
  
  try {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Set a placeholder image URL since we're not using Firebase Storage yet
    _newItem.imageUrl = 'placeholder_url';
    
    // Simulate storing to database
    setState(() {
      _loadingMessage = 'Adding to your closet...';
    });
    await Future.delayed(const Duration(seconds: 1));
    
    // Notify parent about new item
    if (widget.onItemAdded != null) {
      widget.onItemAdded!(_newItem);
    }
    
    // Show success and close
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item added to your closet!')),
    );
    
    Navigator.of(context).pop(true); // Return success
    
  } catch (e) {
    // Handle errors
    setState(() {
      _isLoading = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding item: ${e.toString()}')),
    );
  }
}
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: _previousStep,
        ),
        title: Text(
          'Add to Closet',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _nextStep,
              child: Text(
                _currentStep < 3 ? 'Skip' : '',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (_currentStep + 1) / 4,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
              ),
              
              // Step titles
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StepIndicator(
                      title: 'Photo',
                      isActive: _currentStep >= 0,
                      isCompleted: _currentStep > 0,
                    ),
                    StepDivider(isActive: _currentStep > 0),
                    StepIndicator(
                      title: 'Basics',
                      isActive: _currentStep >= 1,
                      isCompleted: _currentStep > 1,
                    ),
                    StepDivider(isActive: _currentStep > 1),
                    StepIndicator(
                      title: 'Details',
                      isActive: _currentStep >= 2,
                      isCompleted: _currentStep > 2,
                    ),
                    StepDivider(isActive: _currentStep > 2),
                    StepIndicator(
                      title: 'Review',
                      isActive: _currentStep >= 3,
                      isCompleted: false,
                    ),
                  ],
                ),
              ),
              
              // Page content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Step 1: Image Capture
                    CaptureImageScreen(onImageSelected: _setImage),
                    
                    // Step 2: Basic Details
                    BasicDetailsScreen(
                      onDetailsSubmitted: _updateBasicDetails,
                      initialName: _newItem.name,
                      initialCategory: _newItem.category,
                      initialColor: _newItem.color,
                    ),
                    
                    // Step 3: Additional Details
                    AdditionalDetailsScreen(
                      onDetailsSubmitted: _updateAdditionalDetails,
                      initialBrand: _newItem.brand,
                      initialSize: _newItem.size,
                      initialSeasons: _newItem.seasons,
                      initialOccasions: _newItem.occasions,
                      initialNotes: _newItem.notes,
                      initialPrice: _newItem.purchasePrice,
                    ),
                    
                    // Step 4: Review
                    ReviewItemScreen(
                      item: _newItem,
                      image: _selectedImage,
                      onEdit: (int step) {
                        setState(() {
                          _currentStep = step;
                        });
                        _pageController.animateToPage(
                          step,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      onSave: _saveItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          _loadingMessage,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _currentStep < 3
          ? BottomAppBar(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: ElevatedButton(
                  onPressed: _currentStep == 0 && _selectedImage == null
                      ? null
                      : _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentStep < 2 ? 'Continue' : 'Review',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          : BottomAppBar(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add to Closet',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

// Helper widgets for step indicators
class StepIndicator extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isCompleted;
  
  const StepIndicator({
    Key? key,
    required this.title,
    required this.isActive,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? theme.colorScheme.primary
                : isActive
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
            border: isActive && !isCompleted
                ? Border.all(color: theme.colorScheme.primary, width: 2)
                : null,
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.check,
                    color: theme.colorScheme.onPrimary,
                    size: 16,
                  )
                : Text(
                    (title[0]),
                    style: TextStyle(
                      color: isActive
                          ? theme.colorScheme.primary
                          : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? theme.colorScheme.primary : Colors.grey,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class StepDivider extends StatelessWidget {
  final bool isActive;
  
  const StepDivider({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 2,
      color: isActive
          ? Theme.of(context).colorScheme.primary
          : Colors.grey.withOpacity(0.2),
    );
  }
}
