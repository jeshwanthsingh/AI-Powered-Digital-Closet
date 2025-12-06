import 'dart:async';
import 'package:uuid/uuid.dart';
import '../models/clothing_item.dart';
import '../models/outfit.dart';
import '../models/calendar_event.dart';
import 'package:flutter/material.dart';

/// A mock data service that simulates backend functionality
/// This will be replaced with Firebase later
class MockDataService {
  // Singleton pattern
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // In-memory storage
  final List<ClothingItem> _clothingItems = [];
  final List<Outfit> _outfits = [];
  final List<CalendarEvent> _events = [];

  // Stream controllers for reactive UI updates
  final _clothingItemsController = StreamController<List<ClothingItem>>.broadcast();
  final _outfitsController = StreamController<List<Outfit>>.broadcast();
  final _eventsController = StreamController<List<CalendarEvent>>.broadcast();

  // Streams to listen to changes
  Stream<List<ClothingItem>> get clothingItemsStream => _clothingItemsController.stream;
  Stream<List<Outfit>> get outfitsStream => _outfitsController.stream;
  Stream<List<CalendarEvent>> get eventsStream => _eventsController.stream;

  // Get all clothing items
  List<ClothingItem> get clothingItems => _clothingItems;

  // Get all outfits
  List<Outfit> get outfits => _outfits;

  // Get all events
  List<CalendarEvent> get events => _events;

  // Initialize with some mock data
  Future<void> initialize() async {
    // Add some sample clothing items
    _clothingItems.addAll([
      ClothingItem(
        id: const Uuid().v4(),
        name: 'White T-Shirt',
        category: 'Tops',
        color: Colors.white,
        brand: 'H&M',
        size: 'M',
        seasons: ['Spring', 'Summer'],
        dateAdded: DateTime.now().subtract(const Duration(days: 30)),
        isFavorite: true,
      ),
      ClothingItem(
        id: const Uuid().v4(),
        name: 'Blue Jeans',
        category: 'Bottoms',
        color: Colors.blue.shade800,
        brand: 'Levi\'s',
        size: '32',
        seasons: ['All Season'],
        dateAdded: DateTime.now().subtract(const Duration(days: 60)),
      ),
      ClothingItem(
        id: const Uuid().v4(),
        name: 'Black Blazer',
        category: 'Outerwear',
        color: Colors.black,
        brand: 'Zara',
        size: 'M',
        seasons: ['Fall', 'Winter'],
        dateAdded: DateTime.now().subtract(const Duration(days: 90)),
        isFavorite: true,
      ),
    ]);

    // Add some sample outfits
    if (_clothingItems.length >= 3) {
      _outfits.add(
        Outfit(
          id: const Uuid().v4(),
          name: 'Casual Friday',
          items: [_clothingItems[0], _clothingItems[1]],
          notes: 'Good for casual Fridays at work',
          dateCreated: DateTime.now().subtract(const Duration(days: 15)),
          isFavorite: true,
        ),
      );
    }

    // Add some sample calendar events
    if (_outfits.isNotEmpty) {
      _events.add(
        CalendarEvent(
          id: const Uuid().v4(),
          title: 'Wear Casual Friday outfit',
          date: DateTime.now().add(const Duration(days: 2)),
          type: EventType.outfit,
          outfitId: _outfits[0].id,
          notes: 'Team lunch day',
        ),
      );
    }

    // Emit initial values
    _clothingItemsController.add(_clothingItems);
    _outfitsController.add(_outfits);
    _eventsController.add(_events);
  }

  // CRUD operations for clothing items
  Future<ClothingItem> addClothingItem(ClothingItem item) async {
    _clothingItems.add(item);
    _clothingItemsController.add(_clothingItems);
    return item;
  }

  Future<void> updateClothingItem(ClothingItem item) async {
    final index = _clothingItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _clothingItems[index] = item;
      _clothingItemsController.add(_clothingItems);
    }
  }

  Future<void> deleteClothingItem(String id) async {
    _clothingItems.removeWhere((item) => item.id == id);
    
    // Also remove this item from any outfits
    for (final outfit in _outfits) {
      outfit.items.removeWhere((item) => item.id == id);
    }
    
    _clothingItemsController.add(_clothingItems);
    _outfitsController.add(_outfits);
  }

  // CRUD operations for outfits
  Future<Outfit> addOutfit(Outfit outfit) async {
    _outfits.add(outfit);
    _outfitsController.add(_outfits);
    return outfit;
  }

  Future<void> updateOutfit(Outfit outfit) async {
    final index = _outfits.indexWhere((o) => o.id == outfit.id);
    if (index >= 0) {
      _outfits[index] = outfit;
      _outfitsController.add(_outfits);
    }
  }

  Future<void> deleteOutfit(String id) async {
    _outfits.removeWhere((outfit) => outfit.id == id);
    
    // Also remove any calendar events using this outfit
    _events.removeWhere((event) => 
      event.type == EventType.outfit && event.outfitId == id);
    
    _outfitsController.add(_outfits);
    _eventsController.add(_events);
  }

  // CRUD operations for calendar events
  Future<CalendarEvent> addEvent(CalendarEvent event) async {
    _events.add(event);
    _eventsController.add(_events);
    return event;
  }

  Future<void> updateEvent(CalendarEvent event) async {
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index >= 0) {
      _events[index] = event;
      _eventsController.add(_events);
    }
  }

  Future<void> deleteEvent(String id) async {
    _events.removeWhere((event) => event.id == id);
    _eventsController.add(_events);
  }

  // Get events for a specific date
  List<CalendarEvent> getEventsForDate(DateTime date) {
    return _events.where((event) => 
      event.date.year == date.year && 
      event.date.month == date.month && 
      event.date.day == date.day
    ).toList();
  }

  // Dispose method to close streams
  void dispose() {
    _clothingItemsController.close();
    _outfitsController.close();
    _eventsController.close();
  }
}
