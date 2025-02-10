import 'package:altag/firebase_options.dart';
import 'package:altag/providers/auth.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'pages/appliances/appliances.dart';
import 'pages/appliances/kitchen.dart';
import 'pages/home.dart';
import 'pages/housekeeping/hub.dart';
import 'pages/recipes/ingredient.dart';
import 'pages/recipes/recipe.dart';
import 'pages/recipes/recipes.dart';
import 'pages/unauth.dart';
import 'pages/utilities/hvac.dart';
import 'pages/utilities/power.dart';
import 'pages/utilities/utilities.dart';
import 'pages/utilities/water.dart';
import 'pages/whiteboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('authBox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirestoreService>(
            create: (context) => FirestoreService(null)),
        ChangeNotifierProvider<HouseAuthProvider>(
            create: (context) => HouseAuthProvider(null)),
      ],
      child: const HouseInstructionsApp(),
    ),
  );
}

class HouseInstructionsApp extends StatefulWidget {
  const HouseInstructionsApp({super.key});

  @override
  State<HouseInstructionsApp> createState() => _HouseInstructionsAppState();
}

class _HouseInstructionsAppState extends State<HouseInstructionsApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AltaGuardiaHub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(Intl.getCurrentLocale()),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/unauth': (context) => const UnauthenticatedPage(),
        '/utilities': (context) => const UtilitiesPage(),
        '/water': (context) => const WaterInstructionsPage(),
        '/power': (context) => const PowerInstructionsPage(),
        '/hvac': (context) => const HVACInstructionsPage(),
        '/whiteboard': (context) => const WhiteboardPage(),
        '/recipes': (context) => const RecipesPage(),
        '/recipe': (context) => const RecipePage(),
        '/ingredient': (context) => const IngredientPage(),
        '/appliances': (context) => const AppliancesPage(),
        '/kitchen': (context) => const KitchenAppliancesPage(),
        '/housekeeping': (context) => const HousekeepingHubPage(),
      });
}
