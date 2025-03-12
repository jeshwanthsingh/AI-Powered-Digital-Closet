import 'package:flutter/material.dart';

class ClothingItem {
  final String id;
  String name;
  String category;
  Color color;
  String? brand;
  String? size;
  List<String>? seasons;
  List<String>? occasions;
  String? notes;
  double? purchasePrice;
  String? imageUrl;
  final DateTime dateAdded;
  bool isFavorite;
  int wearCount;
  DateTime? lastWorn;
  
  ClothingItem({
    required this.id,
    required this.name,
    required this.category,
    this.color = Colors.grey,
    this.brand,
    this.size,
    this.seasons,
    this.occasions,
    this.notes,
    this.purchasePrice,
    this.imageUrl,
    required this.dateAdded,
    this.isFavorite = false,
    this.wearCount = 0,
    this.lastWorn,
  });
  
  // Convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'color': color.value,
      'brand': brand,
      'size': size,
      'seasons': seasons,
      'occasions': occasions,
      'notes': notes,
      'purchasePrice': purchasePrice,
      'imageUrl': imageUrl,
      'dateAdded': dateAdded.toIso8601String(),
      'isFavorite': isFavorite,
      'wearCount': wearCount,
      'lastWorn': lastWorn?.toIso8601String(),
    };
  }
  
  // Create from a Firestore map
  factory ClothingItem.fromMap(Map<String, dynamic> map) {
    return ClothingItem(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      color: Color(map['color']),
      brand: map['brand'],
      size: map['size'],
      seasons: map['seasons'] != null 
          ? List<String>.from(map['seasons'])
          : null,
      occasions: map['occasions'] != null
          ? List<String>.from(map['occasions'])
          : null,
      notes: map['notes'],
      purchasePrice: map['purchasePrice'],
      imageUrl: map['imageUrl'],
      dateAdded: DateTime.parse(map['dateAdded']),
      isFavorite: map['isFavorite'] ?? false,
      wearCount: map['wearCount'] ?? 0,
      lastWorn: map['lastWorn'] != null
          ? DateTime.parse(map['lastWorn'])
          : null,
    );
  }
}