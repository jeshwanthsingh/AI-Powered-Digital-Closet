import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import '../../../utils/dashed_border.dart';

class CaptureImageScreen extends StatefulWidget {
  final Function(File) onImageSelected;
  
  const CaptureImageScreen({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _CaptureImageScreenState createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  bool _isProcessing = false;
  
  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() {
        _isProcessing = true;
      });
      
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
      );
      
      if (image != null) {
        final File imageFile = File(image.path);
        
        // Crop the image if needed
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
              aspectRatioLockEnabled: false,
            ),
          ],
        );
        
        if (croppedFile != null) {
          setState(() {
            _pickedImage = File(croppedFile.path);
            _isProcessing = false;
          });
          HapticFeedback.lightImpact();
        } else {
          setState(() {
            _isProcessing = false;
          });
        }
      } else {
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: ${e.toString()}')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add a photo of your item',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Take a clear photo with good lighting, preferably on a neutral background.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          // Image preview or placeholder
          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Take a Photo'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DashedBorder(
                  color: theme.colorScheme.secondary.withOpacity(0.3),
                  strokeWidth: 2,
                  borderRadius: 20,
                  dashPattern: const [6, 3],
                  child: _buildImageContent(theme),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Continue button is handled in the parent widget
          // We expose the picked image through the onImageSelected callback
          if (_pickedImage != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Use This Photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                widget.onImageSelected(_pickedImage!);
              },
            ),
          
          if (_pickedImage != null)
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Take Another'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Take a Photo'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildImageContent(ThemeData theme) {
    if (_isProcessing) {
      return const Center(child: CircularProgressIndicator());
    } else if (_pickedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.file(
          _pickedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            size: 64,
            color: theme.colorScheme.secondary.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Tap to add a photo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      );
    }
  }
}
