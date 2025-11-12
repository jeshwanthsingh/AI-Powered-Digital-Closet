import 'package:flutter/material.dart';
import 'outfit.dart';

enum EventType {
  outfit,
  reminder,
  note
}

class CalendarEvent {
  final String id;
  String title;
  DateTime date;
  TimeOfDay? time;
  EventType type;
  String? outfitId;
  String? notes;
  Color? color;
  bool isAllDay;
  
  CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    this.time,
    required this.type,
    this.outfitId,
    this.notes,
    this.color,
    this.isAllDay = false,
  });
  
  // Determine if this event is for today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  // Convert to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'time': time != null ? '${time!.hour}:${time!.minute}' : null,
      'type': type.toString(),
      'outfitId': outfitId,
      'notes': notes,
      'color': color?.value,
      'isAllDay': isAllDay,
    };
  }
  
  // Create from a map
  factory CalendarEvent.fromMap(Map<String, dynamic> map) {
    // Parse the time string if it exists
    TimeOfDay? timeOfDay;
    if (map['time'] != null) {
      final timeParts = map['time'].split(':');
      timeOfDay = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );
    }
    
    // Parse the event type
    EventType eventType = EventType.outfit;
    if (map['type'] != null) {
      final typeString = map['type'].toString();
      eventType = EventType.values.firstWhere(
        (e) => e.toString() == typeString,
        orElse: () => EventType.outfit,
      );
    }
    
    return CalendarEvent(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      time: timeOfDay,
      type: eventType,
      outfitId: map['outfitId'],
      notes: map['notes'],
      color: map['color'] != null ? Color(map['color']) : null,
      isAllDay: map['isAllDay'] ?? false,
    );
  }
}
