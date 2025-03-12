import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/calendar_event.dart';
import '../../models/outfit.dart';
import '../../services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final MockDataService _dataService = MockDataService();
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();
  List<CalendarEvent> _eventsForSelectedDate = [];
  
  @override
  void initState() {
    super.initState();
    _fetchEventsForSelectedDate();
  }
  
  void _fetchEventsForSelectedDate() {
    setState(() {
      _eventsForSelectedDate = _dataService.getEventsForDate(_selectedDate);
    });
  }
  
  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _fetchEventsForSelectedDate();
    });
  }
  
  void _changeMonth(bool next) {
    setState(() {
      if (next) {
        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
      } else {
        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
      }
    });
  }
  
  Future<void> _addEvent() async {
    final outfits = _dataService.outfits;
    
    if (outfits.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create an outfit first to schedule it')),
      );
      return;
    }
    
    Outfit? selectedOutfit;
    String eventTitle = 'Wear Outfit';
    
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Schedule an Outfit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Title field
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: eventTitle),
                    onChanged: (value) {
                      eventTitle = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Outfit dropdown
                  DropdownButtonFormField<Outfit>(
                    decoration: const InputDecoration(
                      labelText: 'Select Outfit',
                      border: OutlineInputBorder(),
                    ),
                    items: outfits.map((outfit) {
                      return DropdownMenuItem<Outfit>(
                        value: outfit,
                        child: Text(outfit.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOutfit = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Save button
                  ElevatedButton(
                    onPressed: () {
                      if (selectedOutfit != null) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an outfit')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Save Event'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        );
      },
    ).then((confirmed) {
      if (confirmed == true && selectedOutfit != null) {
        final newEvent = CalendarEvent(
          id: const Uuid().v4(),
          title: eventTitle,
          date: _selectedDate,
          type: EventType.outfit,
          outfitId: selectedOutfit!.id,
          notes: 'Scheduled outfit: ${selectedOutfit!.name}',
        );
        
        _dataService.addEvent(newEvent).then((_) {
          _fetchEventsForSelectedDate();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Event added successfully')),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendar(),
          const Divider(height: 1),
          _buildEventsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeMonth(false),
          ),
          Text(
            DateFormat('MMMM yyyy').format(_focusedMonth),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(true),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCalendar() {
    final daysInMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7; // 0-6, where 0 is Sunday
    
    // Build week day headers
    final weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 40,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 8),
          
          // Calendar grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (firstWeekdayOfMonth + daysInMonth),
              itemBuilder: (context, index) {
                // Empty spaces for days before the 1st of the month
                if (index < firstWeekdayOfMonth) {
                  return const SizedBox();
                }
                
                final day = index - firstWeekdayOfMonth + 1;
                final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
                final isToday = date.year == DateTime.now().year && 
                                date.month == DateTime.now().month && 
                                date.day == DateTime.now().day;
                final isSelected = date.year == _selectedDate.year && 
                                   date.month == _selectedDate.month && 
                                   date.day == _selectedDate.day;
                
                // Check if there are events for this day
                final hasEvents = _dataService.getEventsForDate(date).isNotEmpty;
                
                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Theme.of(context).colorScheme.primary 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isToday
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.toString(),
                          style: TextStyle(
                            color: isSelected 
                                ? Theme.of(context).colorScheme.onPrimary 
                                : Colors.black,
                            fontWeight: isToday || isSelected 
                                ? FontWeight.bold 
                                : FontWeight.normal,
                          ),
                        ),
                        if (hasEvents)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.onPrimary 
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEventsList() {
    final dateFormatter = DateFormat('EEEE, MMMM d, yyyy');
    
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateFormatter.format(_selectedDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _eventsForSelectedDate.isEmpty
                      ? 'No events scheduled'
                      : '${_eventsForSelectedDate.length} event(s) scheduled',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _eventsForSelectedDate.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events for this day',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _addEvent,
                          child: const Text('Add Event'),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _eventsForSelectedDate.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final event = _eventsForSelectedDate[index];
                      
                      // Find the associated outfit if it's an outfit event
                      Outfit? outfit;
                      if (event.type == EventType.outfit && event.outfitId != null) {
                        outfit = _dataService.outfits.firstWhere(
                          (o) => o.id == event.outfitId,
                          orElse: () => throw Exception('Outfit not found'),
                        );
                      }
                      
                      return Dismissible(
                        key: Key(event.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _dataService.deleteEvent(event.id);
                          _fetchEventsForSelectedDate();
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Event deleted')),
                          );
                        },
                        child: ListTile(
                          title: Text(event.title),
                          subtitle: Text(outfit != null 
                              ? 'Outfit: ${outfit.name}' 
                              : event.notes ?? ''),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: outfit?.color ?? Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              event.type == EventType.outfit 
                                  ? Icons.checkroom 
                                  : Icons.event,
                              color: Colors.white,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Show event details or allow editing
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
