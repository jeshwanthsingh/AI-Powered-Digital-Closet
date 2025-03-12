import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

/// Helper methods and extensions for common functionality
class AppHelpers {
  // Private constructor to prevent instantiation
  AppHelpers._();
  
  /// Format a date using the specified pattern
  static String formatDate(DateTime date, {String pattern = AppConstants.dateFormatFull}) {
    return DateFormat(pattern).format(date);
  }
  
  /// Format a time using 12 or 24-hour format
  static String formatTime(TimeOfDay time, {bool use24Hour = false}) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final pattern = use24Hour ? AppConstants.timeFormat24h : AppConstants.timeFormat12h;
    return DateFormat(pattern).format(dt);
  }
  
  /// Format a file size in bytes to a human-readable string
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }
  
  /// Get initials from a name
  static String getInitials(String name) {
    if (name.isEmpty) return '';
    
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
  
  /// Check if a color is dark
  static bool isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
  
  /// Generate a color from a string (useful for avatars)
  static Color colorFromString(String str) {
    var hash = 0;
    for (var i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }
    
    final hue = (hash % 360).abs();
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.4, 0.5).toColor();
  }
  
  /// Validate an email address
  static bool isValidEmail(String email) {
    return AppConstants.emailRegex.hasMatch(email);
  }
  
  /// Validate a phone number
  static bool isValidPhone(String phone) {
    return AppConstants.phoneRegex.hasMatch(phone);
  }
  
  /// Validate a URL
  static bool isValidUrl(String url) {
    return AppConstants.urlRegex.hasMatch(url);
  }
  
  /// Validate a password
  static bool isValidPassword(String password) {
    return AppConstants.passwordRegex.hasMatch(password);
  }
  
  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  
  /// Convert a hex color string to Color
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  
  /// Convert a Color to hex string
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

/// Extension methods for String
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  String get initials => AppHelpers.getInitials(this);
  
  bool get isValidEmail => AppHelpers.isValidEmail(this);
  
  bool get isValidPhone => AppHelpers.isValidPhone(this);
  
  bool get isValidUrl => AppHelpers.isValidUrl(this);
  
  bool get isValidPassword => AppHelpers.isValidPassword(this);
  
  Color get toColor => AppHelpers.hexToColor(this);
}

/// Extension methods for Color
extension ColorExtensions on Color {
  bool get isDark => AppHelpers.isColorDark(this);
  
  String get toHex => AppHelpers.colorToHex(this);
  
  Color withOpacityIfDark(double opacity) {
    return isDark ? withOpacity(opacity) : this;
  }
  
  Color withOpacityIfLight(double opacity) {
    return !isDark ? withOpacity(opacity) : this;
  }
}

/// Extension methods for DateTime
extension DateTimeExtensions on DateTime {
  String format({String pattern = AppConstants.dateFormatFull}) {
    return AppHelpers.formatDate(this, pattern: pattern);
  }
  
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
  
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }
  
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }
  
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }
  
  bool get isPast {
    final now = DateTime.now();
    return isBefore(now);
  }
  
  bool get isFuture {
    final now = DateTime.now();
    return isAfter(now);
  }
}

/// Extension methods for TimeOfDay
extension TimeOfDayExtensions on TimeOfDay {
  String format({bool use24Hour = false}) {
    return AppHelpers.formatTime(this, use24Hour: use24Hour);
  }
  
  bool isBefore(TimeOfDay other) {
    return hour < other.hour || (hour == other.hour && minute < other.minute);
  }
  
  bool isAfter(TimeOfDay other) {
    return hour > other.hour || (hour == other.hour && minute > other.minute);
  }
  
  int compareTo(TimeOfDay other) {
    if (isBefore(other)) return -1;
    if (isAfter(other)) return 1;
    return 0;
  }
}

/// Extension methods for BuildContext
extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
  
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
      ),
    );
  }
  
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
  
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText ?? 'Confirm'),
          ),
        ],
      ),
    );
  }
}
