import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/clothing_item.dart';
import '../../models/outfit.dart';
import '../../services/mock_data_service.dart';

class CreateOutfitScreen extends StatefulWidget {
  final Outfit? outfitToEdit;
  
  const CreateOutfitScreen({Key? key, this.outfitToEdit}) : super(key: key);

  @override
  _CreateOutfitScreenState createState() => _CreateOutfitScreenState();
}

class _CreateOutfitScreenState extends State<CreateOutfitScreen> {
  final MockDataService _dataService = MockDataService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  
  List<ClothingItem> _allClothingItems = [];
  List<ClothingItem> _selectedItems = [];
  bool _isLoading = false;
  
  // Category filters
  String _selectedCategory = 'All';
  List<String> _categories = ['All'];
  
  @override
  void initState() {
    super.initState();
    _loadClothingItems();
    
    // If editing an existing outfit
    if (widget.outfitToEdit != null) {
      _nameController.text = widget.outfitToEdit!.name;
      _notesController.text = widget.outfitToEdit!.notes ?? '';
      _selectedItems = List.from(widget.outfitToEdit!.items);
    }
  }
  
  void _loadClothingItems() {
    setState(() {
      _isLoading = true;
    });
    
    _allClothingItems = _dataService.clothingItems;
    
    // Extract categories from clothing items
    final categorySet = <String>{'All'};
    for (final item in _allClothingItems) {
      categorySet.add(item.category);
    }
    _categories = categorySet.toList();
    
    setState(() {
      _isLoading = false;
    });
  }
  
  // Filter items by category
  List<ClothingItem> get _filteredItems {
    if (_selectedCategory == 'All') {
      return _allClothingItems;
    } else {
      return _allClothingItems.where((item) => 
        item.category == _selectedCategory).toList();
    }
  }
  
  void _toggleItemSelection(ClothingItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }
  
  Future<void> _saveOutfit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one clothing item')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final outfit = Outfit(
        id: widget.outfitToEdit?.id ?? const Uuid().v4(),
        name: _nameController.text,
        items: _selectedItems,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        dateCreated: widget.outfitToEdit?.dateCreated ?? DateTime.now(),
      );
      
      if (widget.outfitToEdit != null) {
        await _dataService.updateOutfit(outfit);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Outfit updated successfully')),
        );
      } else {
        await _dataService.addOutfit(outfit);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Outfit created successfully')),
        );
      }
      
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving outfit: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.outfitToEdit != null ? 'Edit Outfit' : 'Create Outfit'),
        actions: [
          TextButton(
            onPressed: _saveOutfit,
            child: const Text('SAVE'),
          ),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Basic outfit details
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name field
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Outfit Name',
                            hintText: 'E.g., Casual Friday',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name for your outfit';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Notes field
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'Notes (Optional)',
                            hintText: 'E.g., Good for casual work days',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  
                  // Selected items preview
                  if (_selectedItems.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Items (${_selectedItems.length})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedItems.length,
                              itemBuilder: (context, index) {
                                final item = _selectedItems[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          width: 100,
                                          color: item.color.withOpacity(0.8),
                                          child: Center(
                                            child: Text(
                                              item.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _isColorDark(item.color) 
                                                    ? Colors.white 
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () => _toggleItemSelection(item),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const Divider(thickness: 1),
                  
                  // Category filter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Items to Outfit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        DropdownButton<String>(
                          hint: const Text('Filter by Category'),
                          value: _selectedCategory,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            }
                          },
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  
                  // Available items grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = _selectedItems.contains(item);
                        
                        return GestureDetector(
                          onTap: () => _toggleItemSelection(item),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: item.color.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  border: isSelected 
                                      ? Border.all(
                                          color: Theme.of(context).colorScheme.primary,
                                          width: 3,
                                        ) 
                                      : null,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _getCategoryIcon(item.category),
                                      size: 48,
                                      color: _isColorDark(item.color) 
                                          ? Colors.white 
                                          : Colors.black,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _isColorDark(item.color) 
                                            ? Colors.white 
                                            : Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.category,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isColorDark(item.color) 
                                            ? Colors.white70 
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  
  bool _isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'tops':
        return Icons.approval_rounded;
      case 'bottoms':
        return Icons.vertical_align_bottom_rounded;
      case 'dresses':
        return Icons.waves_rounded;
      case 'outerwear':
        return Icons.water_drop_rounded;
      case 'shoes':
        return Icons.water_drop_outlined;
      case 'accessories':
        return Icons.watch;
      default:
        return Icons.checkroom;
    }
  }
}
