import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'services/mock_data_service.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize mock data service
  final mockDataService = MockDataService();
  await mockDataService.initialize();
  
  // Initialize theme provider
  final themeProvider = ThemeProvider();
  await themeProvider.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Digital Closet',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          themeMode: themeProvider.themeMode,
          home: const LoginPage(),
        );
      },
    );
  }
}
