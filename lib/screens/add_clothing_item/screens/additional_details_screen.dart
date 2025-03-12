import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class AdditionalDetailsScreen extends StatefulWidget {
  final Function({
    String? brand,
    String? size,
    List<String>? seasons,
    List<String>? occasions,
    String? notes,
    double? purchasePrice,
  }) onDetailsSubmitted;
  
  final String? initialBrand;
  final String? initialSize;
  final List<String>? initialSeasons;
  final List<String>? initialOccasions;
  final String? initialNotes;
  final double? initialPrice;
  
  const AdditionalDetailsScreen({
    Key? key,
    required this.onDetailsSubmitted,
    this.initialBrand,
    this.initialSize,
    this.initialSeasons,
    this.initialOccasions,
    this.initialNotes,
    this.initialPrice,
  }) : super(key: key);

  @override
  _AdditionalDetailsScreenState createState() => _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  late TextEditingController _brandController;
  late TextEditingController _sizeController;
  late TextEditingController _notesController;
  late TextEditingController _priceController;
  
  // Selected seasons and occasions
  List<String> _selectedSeasons = [];
  List<String> _selectedOccasions = [];
  
  // Predefined seasons
  final List<String> _seasons = [
    'Spring',
    'Summer',
    'Fall',
    'Winter',
    'All Seasons',
  ];
  
  // Predefined occasions
  final List<String> _occasions = [
    'Casual',
    'Work',
    'Formal',
    'Party',
    'Workout',
    'Beach',
    'Special Occasion',
    'Everyday',
    'Travel',
  ];

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.initialBrand ?? '');
    _sizeController = TextEditingController(text: widget.initialSize ?? '');
    _notesController = TextEditingController(text: widget.initialNotes ?? '');
    _priceController = TextEditingController(
      text: widget.initialPrice != null
          ? widget.initialPrice.toString()
          : '',
    );
    
    _selectedSeasons = widget.initialSeasons ?? [];
    _selectedOccasions = widget.initialOccasions ?? [];
  }

  @override
  void dispose() {
    _brandController.dispose();
    _sizeController.dispose();
    _notesController.dispose();
    _priceController.dispose();
    super.dispose();
  }
  
  void _toggleSeason(String season) {
    setState(() {
      if (_selectedSeasons.contains(season)) {
        _selectedSeasons.remove(season);
      } else {
        _selectedSeasons.add(season);
      }
    });
    HapticFeedback.lightImpact();
  }
  
  void _toggleOccasion(String occasion) {
    setState(() {
      if (_selectedOccasions.contains(occasion)) {
        _selectedOccasions.remove(occasion);
      } else {
        _selectedOccasions.add(occasion);
      }
    });
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Additional details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add more information to help organize your wardrobe.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          // Brand field
          TextField(
            controller: _brandController,
            decoration: const InputDecoration(
              labelText: 'Brand',
              hintText: 'e.g., Nike, Zara, H&M',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          
          // Size field
          TextField(
            controller: _sizeController,
            decoration: const InputDecoration(
              labelText: 'Size',
              hintText: 'e.g., S, M, L, 32, 8, 42',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Price field
          TextField(
            controller: _priceController,
            decoration: InputDecoration(
              labelText: 'Purchase Price',
              hintText: 'e.g., 29.99',
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.attach_money,
                color: Colors.grey[600],
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          const SizedBox(height: 24),
          
          // Seasons selection
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seasons',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _seasons.map((season) {
                  final isSelected = _selectedSeasons.contains(season);
                  
                  return GestureDetector(
                    onTap: () => _toggleSeason(season),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.secondary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.secondary.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        season,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.secondary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Occasions selection
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Occasions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _occasions.map((occasion) {
                  final isSelected = _selectedOccasions.contains(occasion);
                  
                  return GestureDetector(
                    onTap: () => _toggleOccasion(occasion),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.secondary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.secondary.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        occasion,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.secondary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Notes field
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Add any additional information',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 32),
          
          // Continue button is handled in the parent widget
          // We expose the form data through the onDetailsSubmitted callback
          ElevatedButton(
            onPressed: () {
              double? price;
              if (_priceController.text.isNotEmpty) {
                price = double.tryParse(_priceController.text);
              }
              
              widget.onDetailsSubmitted(
                brand: _brandController.text.isEmpty ? null : _brandController.text,
                size: _sizeController.text.isEmpty ? null : _sizeController.text,
                seasons: _selectedSeasons.isEmpty ? null : _selectedSeasons,
                occasions: _selectedOccasions.isEmpty ? null : _selectedOccasions,
                notes: _notesController.text.isEmpty ? null : _notesController.text,
                purchasePrice: price,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue to Review',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}