import 'package:altag/generated/l10n.dart';
import 'package:altag/models/instruction.dart';
import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/sheets/add_instruction_sheet.dart';

void main() {
  group('AddInstructionSheet', () {
    testWidgets('should display title field', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddInstructionSheet(
              instruction: Instruction(
                title: 'Test Instruction',
                description: 'Test description',
                category: 'recipe',
              ),
            ),
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

      expect(find.textContaining('Title'), findsOneWidget);
    });

    testWidgets('should display description field', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddInstructionSheet(
              instruction: Instruction(
                title: 'Test Instruction',
                description: 'Test description',
                category: 'recipe',
              ),
            ),
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

      expect(find.textContaining('Description'), findsOneWidget);
    });

    testWidgets('should display category specific text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddInstructionSheet(
              instruction: Instruction(
                title: 'Test Instruction',
                description: 'Test description',
                category: 'recipe',
              ),
            ),
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

      expect(find.text('Add Recipe'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddInstructionSheet(
              instruction: Instruction(
                title: 'Test Instruction',
                description: 'Test description',
                category: 'other',
              ),
            ),
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

      expect(find.text('Add Instruction'), findsOneWidget);
    });

    testWidgets('should display ingredients', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddInstructionSheet(
              instruction: Instruction(
                title: 'Test Instruction',
                description: 'Test description',
                category: 'recipe',
              ),
              ingredients: {
                'Ingredient 1': [
                  Ingredient(
                    name: 'Ingredient 1',
                    description: 'Description 1',
                    productUrl: 'https://example.com',
                    imageUrl: 'https://example.com/image.png',
                  )
                ],
                'Ingredient 2': [
                  Ingredient(
                    name: 'Ingredient 2',
                    description: 'Description 2',
                    productUrl: 'https://example.com',
                    imageUrl: 'https://example.com/image.png',
                  )
                ],
              },
            ),
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

      expect(find.text('Ingredient 1'), findsWidgets);
      expect(find.text('Ingredient 2'), findsWidgets);
    });
  });
}
