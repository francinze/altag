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

  /// `Language: `
  String get languageLabel {
    return Intl.message(
      'Language: ',
      name: 'languageLabel',
      desc: '',
      args: [],
    );
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

  /// `Recipes`
  String get recipesTitle {
    return Intl.message('Recipes', name: 'recipesTitle', desc: '', args: []);
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

  /// `Instruction Image`
  String get instructionImageLabel {
    return Intl.message(
      'Instruction Image',
      name: 'instructionImageLabel',
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

  /// `Add Option`
  String get addIngredientOption {
    return Intl.message(
      'Add Option',
      name: 'addIngredientOption',
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

  /// `The main water shut off valves are located under the sink in the kitchen.`
  String get waterShutOffLocationSubtitle {
    return Intl.message(
      'The main water shut off valves are located under the sink in the kitchen.',
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

  /// `To shut off the water, turn the valve 90° counterclockwise. To turn the water back on, turn the valve clockwise 90°. The bathroom valve is the round one to the right. To turn it on and off, turn the valve counterclockwise or clockwise until the water is flowing or not.`
  String get waterShutOffInstructionsSubtitle {
    return Intl.message(
      'To shut off the water, turn the valve 90° counterclockwise. To turn the water back on, turn the valve clockwise 90°. The bathroom valve is the round one to the right. To turn it on and off, turn the valve counterclockwise or clockwise until the water is flowing or not.',
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

  /// `If the power goes out, check the circuit breaker or fuse box to see if a switch has been tripped or a fuse has blown. If the problem persists, try going to the building switches downstairs, and see if number 13 (labelled Inzerillo) is turned off. It it's not, try checking if the building is experiencing a blackout.`
  String get powerOutageWhatToDoSubtitle {
    return Intl.message(
      'If the power goes out, check the circuit breaker or fuse box to see if a switch has been tripped or a fuse has blown. If the problem persists, try going to the building switches downstairs, and see if number 13 (labelled Inzerillo) is turned off. It it\'s not, try checking if the building is experiencing a blackout.',
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

  /// `The recommended temperature settings are 18°C in the winter and 25°C in the summer.`
  String get hvacTemperatureSettingsSubtitle {
    return Intl.message(
      'The recommended temperature settings are 18°C in the winter and 25°C in the summer.',
      name: 'hvacTemperatureSettingsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen Appliances`
  String get kitchenAppliancesTitle {
    return Intl.message(
      'Kitchen Appliances',
      name: 'kitchenAppliancesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appliances in the kitchen`
  String get kitchenAppliancesSubtitle {
    return Intl.message(
      'Appliances in the kitchen',
      name: 'kitchenAppliancesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Coffee Maker`
  String get kitchenCoffeeMakerTitle {
    return Intl.message(
      'Coffee Maker',
      name: 'kitchenCoffeeMakerTitle',
      desc: '',
      args: [],
    );
  }

  /// `The coffee maker is located on the kitchen counter.`
  String get kitchenCoffeeMakerSubtitle {
    return Intl.message(
      'The coffee maker is located on the kitchen counter.',
      name: 'kitchenCoffeeMakerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `To brew a cup of coffee, first take your preferred filter from the jar on the coffee maker. Extract the tray and position the filter inside it, then re-insert the tray. Make sure the water tank is full. \nYou just need to plug the coffee maker, press the button one time and it will start to make coffee. The machine will brew the coffee, and just press the button again when you're done to turn it off.`
  String get kitchenCoffeeMakerInstructions {
    return Intl.message(
      'To brew a cup of coffee, first take your preferred filter from the jar on the coffee maker. Extract the tray and position the filter inside it, then re-insert the tray. Make sure the water tank is full. \nYou just need to plug the coffee maker, press the button one time and it will start to make coffee. The machine will brew the coffee, and just press the button again when you\'re done to turn it off.',
      name: 'kitchenCoffeeMakerInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Button`
  String get kitchenCoffeeMakerButtonLabel {
    return Intl.message(
      'Button',
      name: 'kitchenCoffeeMakerButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Jar`
  String get kitchenCoffeeMakerJarLabel {
    return Intl.message(
      'Jar',
      name: 'kitchenCoffeeMakerJarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Plug`
  String get plugLabel {
    return Intl.message('Plug', name: 'plugLabel', desc: '', args: []);
  }

  /// `Tray`
  String get kitchenCoffeeMakerTrayLabel {
    return Intl.message(
      'Tray',
      name: 'kitchenCoffeeMakerTrayLabel',
      desc: '',
      args: [],
    );
  }

  /// `Water Tank`
  String get kitchenCoffeeMakerWaterTankLabel {
    return Intl.message(
      'Water Tank',
      name: 'kitchenCoffeeMakerWaterTankLabel',
      desc: '',
      args: [],
    );
  }

  /// `Counter Plugs`
  String get kitchenCounterPlugsTitle {
    return Intl.message(
      'Counter Plugs',
      name: 'kitchenCounterPlugsTitle',
      desc: '',
      args: [],
    );
  }

  /// `The counter plugs are located by the kitchen counter, close to the microwave.`
  String get kitchenCounterPlugsSubtitle {
    return Intl.message(
      'The counter plugs are located by the kitchen counter, close to the microwave.',
      name: 'kitchenCounterPlugsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fridge`
  String get kitchenFridgeTitle {
    return Intl.message(
      'Fridge',
      name: 'kitchenFridgeTitle',
      desc: '',
      args: [],
    );
  }

  /// `The fridge is located to the right of the kitchen counter.`
  String get kitchenFridgeSubtitle {
    return Intl.message(
      'The fridge is located to the right of the kitchen counter.',
      name: 'kitchenFridgeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Kettle`
  String get kitchenKettleTitle {
    return Intl.message(
      'Kettle',
      name: 'kitchenKettleTitle',
      desc: '',
      args: [],
    );
  }

  /// `The kettle is located on the kitchen counter.`
  String get kitchenKettleSubtitle {
    return Intl.message(
      'The kettle is located on the kitchen counter.',
      name: 'kitchenKettleSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `To open the kettle, press the button. To seal it back, simply press the lid until it clicks. To boil water, first plug the kettle and turn the kettle on by pressing the handle down. If it clicks and it lights up orange, the kettle is on. Turn it off when you're done by lifting the handle up.`
  String get kitchenKettleInstructions {
    return Intl.message(
      'To open the kettle, press the button. To seal it back, simply press the lid until it clicks. To boil water, first plug the kettle and turn the kettle on by pressing the handle down. If it clicks and it lights up orange, the kettle is on. Turn it off when you\'re done by lifting the handle up.',
      name: 'kitchenKettleInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Button`
  String get kitchenKettleButtonLabel {
    return Intl.message(
      'Button',
      name: 'kitchenKettleButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Handle`
  String get kitchenKettleHandleLabel {
    return Intl.message(
      'Handle',
      name: 'kitchenKettleHandleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Microwave`
  String get kitchenMicrowaveTitle {
    return Intl.message(
      'Microwave',
      name: 'kitchenMicrowaveTitle',
      desc: '',
      args: [],
    );
  }

  /// `The microwave is located on the kitchen counter.`
  String get kitchenMicrowaveSubtitle {
    return Intl.message(
      'The microwave is located on the kitchen counter.',
      name: 'kitchenMicrowaveSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Oven`
  String get kitchenOvenTitle {
    return Intl.message('Oven', name: 'kitchenOvenTitle', desc: '', args: []);
  }

  /// `The oven is located in the kitchen.`
  String get kitchenOvenSubtitle {
    return Intl.message(
      'The oven is located in the kitchen.',
      name: 'kitchenOvenSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Stove`
  String get kitchenStoveTitle {
    return Intl.message('Stove', name: 'kitchenStoveTitle', desc: '', args: []);
  }

  /// `The stove is located on the kitchen counter.`
  String get kitchenStoveSubtitle {
    return Intl.message(
      'The stove is located on the kitchen counter.',
      name: 'kitchenStoveSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Toaster`
  String get kitchenToasterTitle {
    return Intl.message(
      'Toaster',
      name: 'kitchenToasterTitle',
      desc: '',
      args: [],
    );
  }

  /// `The toaster is located in the red cupboard to the right.`
  String get kitchenToasterSubtitle {
    return Intl.message(
      'The toaster is located in the red cupboard to the right.',
      name: 'kitchenToasterSubtitle',
      desc: '',
      args: [],
    );
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
