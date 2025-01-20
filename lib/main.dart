import 'package:altag/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/home_page.dart';
import 'pages/search.dart';
import 'pages/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HouseInstructionsApp());
}

class HouseInstructionsApp extends StatefulWidget {
  const HouseInstructionsApp({super.key});

  @override
  State<HouseInstructionsApp> createState() => _HouseInstructionsAppState();
}

class _HouseInstructionsAppState extends State<HouseInstructionsApp> {
  Locale selectedLocale = const Locale('en');
  int selectedIndex = 0;

  /// The widget that configures the top-level routing.
  ///
  /// This widget is the configuration for the [MaterialApp] widget and
  /// is the root of the widget tree. It configures the available
  /// localizations and the home page of the app.
  ///
  /// The [MaterialApp] is configured with a blue color scheme and a
  /// bold headline font style. The [AppLocalizations.delegate] is used
  /// to configure the app's localizations.
  ///
  @override
  Widget build(BuildContext context) {
    void onPageSelected(int index) => setState(() => selectedIndex = index);
    void changeLocale(Locale locale) => setState(() => selectedLocale = locale);

    final List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      SettingsPage(onChangeLocale: changeLocale),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'House Instructions',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('it')],
      locale: selectedLocale,
      home: Scaffold(
        appBar: AppBar(title: const Text('AltaGuardiaHub')),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onPageSelected,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: SizedBox()),
                NavigationRailDestination(
                    icon: Icon(Icons.search), label: SizedBox()),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: SizedBox()),
              ],
            ),
            Expanded(child: pages[selectedIndex]),
          ],
        ),
      ),
    );
  }
}
