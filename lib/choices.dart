import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
  Widget buildOptionA(BuildContext context);
  Widget buildOptionB(BuildContext context);
}

class ChoiceBody implements ListItem {
  final String title;
  final String subtitle;
  final String optionA;
  final String optionASubtitle;
  final String optionB;
  final String optionBSubtitle;
  final int groupValue;
  int selectedRadio = 0;

  ChoiceBody(this.title, this.subtitle, this.optionA, this.optionASubtitle, this.optionB, this.optionBSubtitle,
      this.groupValue);

  Widget buildTitle(BuildContext context) => Text(title);
  Widget buildSubtitle(BuildContext context) => Text(subtitle);
  Widget buildOptionA(BuildContext context) {
    return RadioListTile(
      value: 1,
      groupValue: groupValue,
      title: Text(optionA),
      subtitle: Text(optionASubtitle),
      onChanged: (val) {
        selectedRadio = val;
      },
    );
  }

  Widget buildOptionB(BuildContext context) {
    return RadioListTile(
      value: 2,
      groupValue: groupValue,
      title: Text(optionB),
      subtitle: Text(optionBSubtitle),
      onChanged: (val) {
        selectedRadio = val;
      },
    );
  }
}

List<ListItem> items = <ListItem>[
  ChoiceBody('Laundry', 'What kind of laundry is being done?', 'Light Laundry', 'Takes about an hour', 'Heavy Laundry',
      'Takes more than an hour', 1),
  ChoiceBody('Running Errands', 'What kind of errand is being run?', 'Light Shopping', 'Would not require a vehicle',
      'Heavy Shopping', 'Would require a vehicle', 2),
  ChoiceBody('Pickup and Delivery', 'What kind of pickup is being done?', 'Light Pickup', 'Would not require a vehicle',
      'Heavy Pickup', 'Would require a vehicle', 3),
  ChoiceBody('Running Errands', 'What kind of errand is being run?', 'Light Shopping', 'Would not require a vehicle',
      'Heavy Shopping', 'Would require a vehicle', 4),
  ChoiceBody('Pets', 'How would you like your pet being handled?', 'Pet cleaning', 'Cleaning of your pet',
      'Pet Walking', 'Walking your pet around your area', 5),
  ChoiceBody('Cleaning', 'What kind of cleaning is being done?', 'General Cleaning', 'Would take about an hour',
      'Intensive Cleaning', 'Would take more than an hour', 6),
];

Map<String, ListItem> item = {
  'Laundry': ChoiceBody('Laundry', 'What kind of laundry is being done?', 'Light Laundry', 'Takes about an hour',
      'Heavy Laundry', 'Takes more than an hour', 1),
  'Cleaning': ChoiceBody('Cleaning', 'What kind of cleaning is being done?', 'General Cleaning',
      'Would take about an hour', 'Intensive Cleaning', 'Would take more than an hour', 2),
  'Running Errands': ChoiceBody('Running Errands', 'What kind of errand is being run?', 'Light Shopping',
      'Would not require a vehicle', 'Heavy Shopping', 'Would require a vehicle', 3),
  'Pets': ChoiceBody('Pets', 'How would you like your pet being handled?', 'Pet cleaning', 'Cleaning of your pet',
      'Pet Walking', 'Walking your pet around your area', 4),
  'Pickup and Delivery': ChoiceBody('Pickup and Delivery', 'What kind of pickup is being done?', 'Light Pickup',
      'Would not require a vehicle', 'Heavy Pickup', 'Would require a vehicle', 5),
};
