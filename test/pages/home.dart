// test/pages/home_test.dart
import 'package:altag/generated/l10n.dart';
import 'package:altag/pages/dashboard.dart';
import 'package:altag/pages/search.dart';
import 'package:altag/pages/settings.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/pages/home.dart';
import 'package:altag/providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  group('HomePage', () {
    late MockFirebaseAuth service;
    late HouseAuthProvider auth;

    setUp(() {
      service = MockFirebaseAuth();
      auth = HouseAuthProvider(service);
    });

    testWidgets('displays login button when user is not authenticated',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => auth)],
          child: const MaterialApp(
            home: HomePage(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('does not display login button when user is authenticated',
        (WidgetTester tester) async {
      // Arrange
      await service.signInAnonymously();

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => auth)],
          child: const MaterialApp(
            home: HomePage(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );

      // Assert
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('displays dashboard page by default',
        (WidgetTester tester) async {
      // Arrange
      // await auth.instance.signInAnonymously();

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => auth)],
          child: const MaterialApp(
            home: HomePage(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );

      // Assert
      expect(find.byType(DashboardPage), findsOneWidget);
    });

    testWidgets('navigates to search page when search icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      // await auth.instance.signInAnonymously();

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => auth),
          ],
          child: const MaterialApp(
            home: HomePage(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SearchPage), findsOneWidget);
    });

    testWidgets('navigates to settings page when settings icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      // await auth.instance.signInAnonymously();

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => auth),
          ],
          child: const MaterialApp(
            home: HomePage(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
