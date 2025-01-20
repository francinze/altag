import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(texts.utilities_title)),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(texts.water_shut_off_title),
            subtitle: Text(texts.water_shut_off_subtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.water_shut_off_location_title),
                subtitle: Text(texts.water_shut_off_location_subtitle),
              ),
              ListTile(
                title: Text(texts.water_shut_off_instructions_title),
                subtitle: Text(texts.water_shut_off_instructions_subtitle),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(texts.power_outage_title),
            subtitle: Text(texts.power_outage_subtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.power_outage_what_to_do_title),
                subtitle: Text(texts.power_outage_what_to_do_subtitle),
              ),
              ListTile(
                title: Text(texts.power_outage_safety_precautions_title),
                subtitle: Text(texts.power_outage_safety_precautions_subtitle),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(texts.hvac_title),
            subtitle: Text(texts.hvac_subtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.hvac_thermostat_location_title),
                subtitle: Text(texts.hvac_thermostat_location_subtitle),
              ),
              ListTile(
                title: Text(texts.hvac_temperature_settings_title),
                subtitle: Text(texts.hvac_temperature_settings_subtitle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
