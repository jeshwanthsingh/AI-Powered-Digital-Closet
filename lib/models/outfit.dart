import 'package:flutter/material.dart';
import 'clothing_item.dart';

class Outfit {
  final String id;
  String name;
  List<ClothingItem> items;
  String? notes;
  Color? color;
  bool isFavorite;
  DateTime dateCreated;
  List<DateTime>? wornDates;
  
  Outfit({
    required this.id,
    required this.name,
    required this.items,
    this.notes,
    this.color,
    this.isFavorite = false,
    required this.dateCreated,
    this.wornDates,
  });
  
  // Convert to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'itemIds': items.map((item) => item.id).toList(),
      'notes': notes,
      'color': color?.value,
      'isFavorite': isFavorite,
      'dateCreated': dateCreated.toIso8601String(),
      'wornDates': wornDates?.map((date) => date.toIso8601String()).toList(),
    };
  }
  
  // Create from a map
  factory Outfit.fromMap(Map<String, dynamic> map, List<ClothingItem> allItems) {
    List<String> itemIds = List<String>.from(map['itemIds']);
    List<ClothingItem> outfitItems = allItems.where((item) => 
      itemIds.contains(item.id)).toList();
      
    return Outfit(
      id: map['id'],
      name: map['name'],
      items: outfitItems,
      notes: map['notes'],
      color: map['color'] != null ? Color(map['color']) : null,
      isFavorite: map['isFavorite'] ?? false,
      dateCreated: DateTime.parse(map['dateCreated']),
      wornDates: map['wornDates'] != null 
          ? List<String>.from(map['wornDates'])
              .map((date) => DateTime.parse(date)).toList()
          : null,
    );
  }
}
