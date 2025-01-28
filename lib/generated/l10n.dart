// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `House Instructions`
  String get houseInstructionsTitle {
    return Intl.message(
      'House Instructions',
      name: 'houseInstructionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome! Select a category to get started:`
  String get homepageWelcome {
    return Intl.message(
      'Welcome! Select a category to get started:',
      name: 'homepageWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitle {
    return Intl.message('Home', name: 'homeTitle', desc: '', args: []);
  }

  /// `Search`
  String get searchTitle {
    return Intl.message('Search', name: 'searchTitle', desc: '', args: []);
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Logout`
  String get logoutLabel {
    return Intl.message('Logout', name: 'logoutLabel', desc: '', args: []);
  }

  /// `No user found for this username.`
  String get authUserNotFound {
    return Intl.message(
      'No user found for this username.',
      name: 'authUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to logout: `
  String get authLogoutFailed {
    return Intl.message(
      'Failed to logout: ',
      name: 'authLogoutFailed',
      desc: '',
      args: [],
    );
  }

  /// `Utilities`
  String get utilitiesTitle {
    return Intl.message(
      'Utilities',
      name: 'utilitiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appliances`
  String get appliancesTitle {
    return Intl.message(
      'Appliances',
      name: 'appliancesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recipes`
  String get recipesTitle {
    return Intl.message('Recipes', name: 'recipesTitle', desc: '', args: []);
  }

  /// `Housekeeping`
  String get housekeepingTitle {
    return Intl.message(
      'Housekeeping',
      name: 'housekeepingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Whiteboard`
  String get whiteboardTitle {
    return Intl.message(
      'Whiteboard',
      name: 'whiteboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language: `
  String get languageLabel {
    return Intl.message(
      'Language: ',
      name: 'languageLabel',
      desc: '',
      args: [],
    );
  }

  /// `No recipes yet`
  String get noRecipesMsg {
    return Intl.message(
      'No recipes yet',
      name: 'noRecipesMsg',
      desc: '',
      args: [],
    );
  }

  /// `Add Instruction`
  String get addInstruction {
    return Intl.message(
      'Add Instruction',
      name: 'addInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Add Recipe`
  String get addRecipe {
    return Intl.message('Add Recipe', name: 'addRecipe', desc: '', args: []);
  }

  /// `Instruction Title`
  String get instructionTitleLabel {
    return Intl.message(
      'Instruction Title',
      name: 'instructionTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Instruction Description`
  String get instructionDescriptionLabel {
    return Intl.message(
      'Instruction Description',
      name: 'instructionDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Ingredient`
  String get addIngredient {
    return Intl.message(
      'Add Ingredient',
      name: 'addIngredient',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient Title`
  String get ingrTitleLabel {
    return Intl.message(
      'Ingredient Title',
      name: 'ingrTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient Description`
  String get ingrDescriptionLabel {
    return Intl.message(
      'Ingredient Description',
      name: 'ingrDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient URL`
  String get ingrURLLabel {
    return Intl.message(
      'Ingredient URL',
      name: 'ingrURLLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient Image`
  String get ingrImageLabel {
    return Intl.message(
      'Ingredient Image',
      name: 'ingrImageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveInstruction {
    return Intl.message('Save', name: 'saveInstruction', desc: '', args: []);
  }

  /// `Write your note here`
  String get writeYourNote {
    return Intl.message(
      'Write your note here',
      name: 'writeYourNote',
      desc: '',
      args: [],
    );
  }

  /// `Save Note`
  String get saveNote {
    return Intl.message('Save Note', name: 'saveNote', desc: '', args: []);
  }

  /// `Note saved!`
  String get noteSavedMsg {
    return Intl.message(
      'Note saved!',
      name: 'noteSavedMsg',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet`
  String get noNotesMsg {
    return Intl.message('No notes yet', name: 'noNotesMsg', desc: '', args: []);
  }

  /// `Water Shut Off`
  String get waterShutOffTitle {
    return Intl.message(
      'Water Shut Off',
      name: 'waterShutOffTitle',
      desc: '',
      args: [],
    );
  }

  /// `Learn how to shut off the water supply`
  String get waterShutOffSubtitle {
    return Intl.message(
      'Learn how to shut off the water supply',
      name: 'waterShutOffSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get waterShutOffLocationTitle {
    return Intl.message(
      'Location',
      name: 'waterShutOffLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `The main water shut off valve is located in the basement, near the water meter.`
  String get waterShutOffLocationSubtitle {
    return Intl.message(
      'The main water shut off valve is located in the basement, near the water meter.',
      name: 'waterShutOffLocationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get waterShutOffInstructionsTitle {
    return Intl.message(
      'Instructions',
      name: 'waterShutOffInstructionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `To shut off the water, turn the valve clockwise until it stops. To turn the water back on, turn the valve counterclockwise until it stops.`
  String get waterShutOffInstructionsSubtitle {
    return Intl.message(
      'To shut off the water, turn the valve clockwise until it stops. To turn the water back on, turn the valve counterclockwise until it stops.',
      name: 'waterShutOffInstructionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Power Outage`
  String get powerOutageTitle {
    return Intl.message(
      'Power Outage',
      name: 'powerOutageTitle',
      desc: '',
      args: [],
    );
  }

  /// `What to do during a power outage`
  String get powerOutageSubtitle {
    return Intl.message(
      'What to do during a power outage',
      name: 'powerOutageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `What to do`
  String get powerOutageWhatToDoTitle {
    return Intl.message(
      'What to do',
      name: 'powerOutageWhatToDoTitle',
      desc: '',
      args: [],
    );
  }

  /// `If the power goes out, check the circuit breaker or fuse box to see if a switch has been tripped or a fuse has blown. If the problem persists, contact the power company.`
  String get powerOutageWhatToDoSubtitle {
    return Intl.message(
      'If the power goes out, check the circuit breaker or fuse box to see if a switch has been tripped or a fuse has blown. If the problem persists, contact the power company.',
      name: 'powerOutageWhatToDoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Safety Precautions`
  String get powerOutageSafetyPrecautionsTitle {
    return Intl.message(
      'Safety Precautions',
      name: 'powerOutageSafetyPrecautionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Avoid using candles or open flames, as they can be a fire hazard. Use flashlights or battery-powered lanterns instead.`
  String get powerOutageSafetyPrecautionsSubtitle {
    return Intl.message(
      'Avoid using candles or open flames, as they can be a fire hazard. Use flashlights or battery-powered lanterns instead.',
      name: 'powerOutageSafetyPrecautionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `HVAC`
  String get hvacTitle {
    return Intl.message('HVAC', name: 'hvacTitle', desc: '', args: []);
  }

  /// `Heating, ventilation, and air conditioning`
  String get hvacSubtitle {
    return Intl.message(
      'Heating, ventilation, and air conditioning',
      name: 'hvacSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get hvacThermostatLocationTitle {
    return Intl.message(
      'Location',
      name: 'hvacThermostatLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `The thermostat is located in the living room, on the wall near the window.`
  String get hvacThermostatLocationSubtitle {
    return Intl.message(
      'The thermostat is located in the living room, on the wall near the window.',
      name: 'hvacThermostatLocationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Temperature Settings`
  String get hvacTemperatureSettingsTitle {
    return Intl.message(
      'Temperature Settings',
      name: 'hvacTemperatureSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `The recommended temperature settings are 68°F in the winter and 78°F in the summer.`
  String get hvacTemperatureSettingsSubtitle {
    return Intl.message(
      'The recommended temperature settings are 68°F in the winter and 78°F in the summer.',
      name: 'hvacTemperatureSettingsSubtitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
