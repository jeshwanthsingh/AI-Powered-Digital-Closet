import 'package:flutter/material.dart';

/// App-wide constants for consistent design
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();
  
  /// Spacing constants
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing56 = 56;
  static const double spacing64 = 64;
  
  /// Border radius constants
  static const double radiusSmall = 4;
  static const double radiusMedium = 8;
  static const double radiusLarge = 12;
  static const double radiusXLarge = 16;
  static const double radiusXXLarge = 24;
  static const double radiusCircular = 999;
  
  /// Animation durations
  static const Duration animFastest = Duration(milliseconds: 150);
  static const Duration animFast = Duration(milliseconds: 250);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 700);
  
  /// Animation curves
  static const Curve animCurveDefault = Curves.easeInOutCubic;
  static const Curve animCurveEaseOut = Curves.easeOutCubic;
  static const Curve animCurveEaseIn = Curves.easeInCubic;
  
  /// Elevation constants
  static const double elevationNone = 0;
  static const double elevationXSmall = 1;
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 8;
  static const double elevationXLarge = 16;
  
  /// Opacity constants
  static const double opacityDisabled = 0.38;
  static const double opacityLight = 0.5;
  static const double opacityMedium = 0.7;
  static const double opacityHigh = 0.87;
  static const double opacityFull = 1.0;
  
  /// Font sizes
  static const double fontSizeCaption = 12;
  static const double fontSizeBody = 14;
  static const double fontSizeSubheading = 16;
  static const double fontSizeTitle = 18;
  static const double fontSizeHeadline = 24;
  static const double fontSizeDisplay = 32;
  
  /// Icon sizes
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double iconSizeXLarge = 48;
  static const double iconSizeXXLarge = 64;
  
  /// Button heights
  static const double buttonHeightSmall = 32;
  static const double buttonHeightMedium = 40;
  static const double buttonHeightLarge = 48;
  static const double buttonHeightXLarge = 56;
  
  /// Input field heights
  static const double inputHeightSmall = 40;
  static const double inputHeightMedium = 48;
  static const double inputHeightLarge = 56;
  
  /// Card constants
  static const double cardElevation = 0;
  static const double cardBorderRadius = 16;
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 0,
  );
  
  /// Bottom sheet constants
  static const double bottomSheetBorderRadius = 20;
  static const EdgeInsets bottomSheetPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );
  
  /// Dialog constants
  static const double dialogBorderRadius = 24;
  static const EdgeInsets dialogPadding = EdgeInsets.all(24);
  
  /// Bottom navigation bar constants
  static const double bottomNavHeight = 80;
  static const double bottomNavIconSize = 24;
  static const double bottomNavSelectedFontSize = 12;
  static const double bottomNavUnselectedFontSize = 12;
  
  /// App bar constants
  static const double appBarHeight = 56;
  static const double appBarElevation = 0;
  
  /// Floating action button constants
  static const double fabSize = 56;
  static const double fabMiniSize = 40;
  static const double fabElevation = 6;
  static const double fabBorderRadius = 16;
  
  /// Grid constants
  static const double gridSpacing = 16;
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  
  /// List constants
  static const EdgeInsets listPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static const double listItemSpacing = 8;
  
  /// Image constants
  static const double imageAspectRatio = 1.0;
  static const double imageBorderRadius = 12;
  static const double imagePreviewSize = 100;
  static const double imageThumbnailSize = 60;
  
  /// Loading indicator constants
  static const double loadingIndicatorSize = 40;
  static const double loadingIndicatorStrokeWidth = 4;
  static const EdgeInsets loadingIndicatorPadding = EdgeInsets.all(16);
  
  /// Empty state constants
  static const double emptyStateIconSize = 64;
  static const EdgeInsets emptyStatePadding = EdgeInsets.all(32);
  
  /// Error state constants
  static const double errorStateIconSize = 64;
  static const EdgeInsets errorStatePadding = EdgeInsets.all(32);
  
  /// Shimmer loading constants
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const double shimmerOpacity = 0.3;
  
  /// Haptic feedback constants
  static const Duration hapticFeedbackDuration = Duration(milliseconds: 50);
  
  /// Transition constants
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration modalTransitionDuration = Duration(milliseconds: 250);
  
  /// Debounce and throttle constants
  static const Duration debounceDuration = Duration(milliseconds: 300);
  static const Duration throttleDuration = Duration(milliseconds: 300);
  
  /// Validation constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;
  static const int maxPhoneLength = 15;
  static const int maxAddressLength = 200;
  static const int maxNotesLength = 500;
  
  /// API constants
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  
  /// Cache constants
  static const Duration cacheMaxAge = Duration(days: 7);
  static const int maxCacheItems = 100;
  
  /// Image quality constants
  static const int jpegQuality = 85;
  static const double maxImageWidth = 1920;
  static const double maxImageHeight = 1080;
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  
  /// File size constants
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  
  /// Pagination constants
  static const int itemsPerPage = 20;
  static const int maxPages = 50;
  
  /// Search constants
  static const Duration searchDebounceTime = Duration(milliseconds: 300);
  static const int minSearchLength = 2;
  static const int maxSearchLength = 50;
  
  /// Date format patterns
  static const String dateFormatFull = 'EEEE, MMMM d, yyyy';
  static const String dateFormatShort = 'MMM d, yyyy';
  static const String dateFormatCompact = 'MM/dd/yyyy';
  static const String timeFormat24h = 'HH:mm';
  static const String timeFormat12h = 'hh:mm a';
  
  /// Regular expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^\+?[\d\s-]{10,}$',
  );
  static final RegExp urlRegex = RegExp(
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$',
  );
}
