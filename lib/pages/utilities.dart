import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Utilities', name: 'utilities_title')),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(
                Intl.message('Water Shut Off', name: 'water_shut_off_title')),
            subtitle: Text(Intl.message(
                'Learn how to shut off the water supply',
                name: 'water_shut_off_subtitle')),
            children: <Widget>[
              ListTile(
                title: Text(Intl.message('Location', name: 'location_title')),
                subtitle: Text(Intl.message(
                    'The main water shut off valve is located in the basement, near the water meter.',
                    name: 'water_shut_off_location')),
              ),
              ListTile(
                title: Text(
                    Intl.message('Instructions', name: 'instructions_title')),
                subtitle: Text(Intl.message(
                    'To shut off the water, turn the valve clockwise until it stops. To turn the water back on, turn the valve counterclockwise until it stops.',
                    name: 'water_shut_off_instructions')),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(Intl.message('Power Outage', name: 'power_outage_title')),
            subtitle: Text(Intl.message('What to do during a power outage',
                name: 'power_outage_subtitle')),
            children: <Widget>[
              ListTile(
                title:
                    Text(Intl.message('What to do', name: 'what_to_do_title')),
                subtitle: Text(Intl.message(
                    'If the power goes out, check the circuit breaker or fuse box to see if a switch has been tripped or a fuse has blown. If the problem persists, contact the power company.',
                    name: 'power_outage_what_to_do')),
              ),
              ListTile(
                title: Text(Intl.message('Safety precautions',
                    name: 'safety_precautions_title')),
                subtitle: Text(Intl.message(
                    'Avoid using candles or open flames, as they can be a fire hazard. Use flashlights or battery-powered lanterns instead.',
                    name: 'power_outage_safety_precautions')),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(Intl.message('HVAC', name: 'hvac_title')),
            subtitle: Text(Intl.message(
                'Heating, ventilation, and air conditioning',
                name: 'hvac_subtitle')),
            children: <Widget>[
              ListTile(
                title: Text(Intl.message('Thermostat location',
                    name: 'thermostat_location_title')),
                subtitle: Text(Intl.message(
                    'The thermostat is located in the living room, on the wall near the window.',
                    name: 'hvac_thermostat_location')),
              ),
              ListTile(
                title: Text(Intl.message('Temperature settings',
                    name: 'temperature_settings_title')),
                subtitle: Text(Intl.message(
                    'The recommended temperature settings are 68°F in the winter and 78°F in the summer.',
                    name: 'hvac_temperature_settings')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
