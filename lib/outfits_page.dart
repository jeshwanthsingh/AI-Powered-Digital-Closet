import 'package:flutter/material.dart';
import 'models/outfit.dart';
import 'models/clothing_item.dart';
import 'services/mock_data_service.dart';
import 'screens/outfits/create_outfit_screen.dart';

class OutfitsPage extends StatefulWidget {
  const OutfitsPage({Key? key}) : super(key: key);

  @override
  _OutfitsPageState createState() => _OutfitsPageState();
}

class _OutfitsPageState extends State<OutfitsPage> {
  final MockDataService _dataService = MockDataService();
  List<Outfit> _outfits = [];
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadOutfits();
    
    // Listen for changes
    _dataService.outfitsStream.listen((outfits) {
      setState(() {
        _outfits = outfits;
      });
    });
  }
  
  void _loadOutfits() {
    setState(() {
      _isLoading = true;
      _outfits = _dataService.outfits;
      _isLoading = false;
    });
  }
  
  Future<void> _createOutfit() async {
    if (_dataService.clothingItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add some clothing items first before creating an outfit'),
        ),
      );
      return;
    }
    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateOutfitScreen(),
      ),
    );
    
    if (result == true) {
      _loadOutfits();
    }
  }
  
  Future<void> _editOutfit(Outfit outfit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOutfitScreen(outfitToEdit: outfit),
      ),
    );
    
    if (result == true) {
      _loadOutfits();
    }
  }
  
  Future<void> _toggleFavorite(Outfit outfit) async {
    final updatedOutfit = Outfit(
      id: outfit.id,
      name: outfit.name,
      items: outfit.items,
      notes: outfit.notes,
      color: outfit.color,
      isFavorite: !outfit.isFavorite,
      dateCreated: outfit.dateCreated,
      wornDates: outfit.wornDates,
    );
    
    await _dataService.updateOutfit(updatedOutfit);
    _loadOutfits();
  }
  
  Future<void> _deleteOutfit(Outfit outfit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Outfit'),
        content: Text('Are you sure you want to delete "${outfit.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await _dataService.deleteOutfit(outfit.id);
      _loadOutfits();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Outfit deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_outfits.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.style_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No outfits yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first outfit to get started',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createOutfit,
              icon: const Icon(Icons.add),
              label: const Text('CREATE OUTFIT'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, 
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    return Stack(
      children: [
        ListView.builder(
          itemCount: _outfits.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final outfit = _outfits[index];
            return Dismissible(
              key: Key(outfit.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) async {
                await _deleteOutfit(outfit);
                return true;
              },
              child: OutfitCard(
                outfit: outfit,
                onEdit: () => _editOutfit(outfit),
                onToggleFavorite: () => _toggleFavorite(outfit),
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _createOutfit,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class OutfitCard extends StatelessWidget {
  final Outfit outfit;
  final VoidCallback onEdit;
  final VoidCallback onToggleFavorite;
  
  const OutfitCard({
    Key? key, 
    required this.outfit,
    required this.onEdit,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Outfit image/color representation
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                // Gradient background based on first item's color or default
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        outfit.items.isNotEmpty
                            ? outfit.items[0].color
                            : theme.colorScheme.secondary,
                        outfit.items.length > 1
                            ? outfit.items[1].color
                            : theme.colorScheme.secondary.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Outfit icon overlay
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.style,
                      size: 60,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
                // Favorite indicator
                if (outfit.isFavorite)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Outfit details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        outfit.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: Icon(
                            outfit.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: outfit.isFavorite ? Colors.red : null,
                          ),
                          onPressed: onToggleFavorite,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                Text(
                  'Contains ${outfit.items.length} item${outfit.items.length != 1 ? 's' : ''}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                
                if (outfit.notes != null && outfit.notes!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    outfit.notes!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                
                const SizedBox(height: 16),
                
                // Item preview (horizontal scroll)
                if (outfit.items.isNotEmpty)
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: outfit.items.length,
                      itemBuilder: (context, i) {
                        final item = outfit.items[i];
                        return _buildItemPreview(context, item);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildItemPreview(BuildContext context, ClothingItem item) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          _getCategoryIcon(item.category),
          color: _isColorDark(item.color) ? Colors.white : Colors.black,
          size: 24,
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
