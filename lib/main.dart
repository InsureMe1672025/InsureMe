import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/main_provider.dart';
import 'screens/main_navigation.dart';
import 'screens/splash_screen.dart';
import 'screens/start_screen.dart';
import 'services/shared_preferences_service.dart';
import 'utils/app_theme.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create a container for providers
  final container = ProviderContainer();
  
  // Initialize SharedPreferencesService
  await initializeSharedPreferences(container);
  
  // Run the app with the initialized container
  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(mainProvider);

    return MaterialApp(
      title: 'InsureMe',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: appState.isLoading
          ? const SplashScreen()
          : appState.isUserLoggedIn
              ? const MainNavigationPage()
              : const StartScreen(),
      routes: {
        AppConstants.routeStart: (context) => const StartScreen(),
        AppConstants.routeHome: (context) => const MainNavigationPage(),
      },
    );
  }
}
