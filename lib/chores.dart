import 'package:flutter/material.dart';

final List<SimpleModel> items = <SimpleModel>[
  SimpleModel('Laundry', false,
      subtitle: 'What kind of laundry is being done?',
      optionA: 'Light Laundry',
      optionAPrice: 200,
      optionASubtitle: 'Takes about an hour',
      optionB: 'Heavy Laundry',
      optionBPrice: 300,
      optionBSubtitle: 'Takes more than an hour'),
  SimpleModel('Cleaning', false,
      subtitle: 'What kind of cleaning is being done?',
      optionA: 'General Cleaning',
      optionAPrice: 300,
      optionASubtitle: 'Takes about an hour',
      optionB: 'Intensive Cleaning',
      optionBPrice: 500,
      optionBSubtitle: 'Takes more than an hour'),
  SimpleModel(
    'Car Cleaning',
    false,
    option: true,
    optionA: 'Car Cleaning',
    optionAPrice: 200,
  ),
  SimpleModel('Running Errands', false,
      subtitle: 'What kind of errand is being done?',
      optionA: 'Light Shopping',
      optionAPrice: 200,
      optionASubtitle: 'Would not require a vehicle',
      optionBPrice: 350,
      optionB: 'Heavy Shopping',
      optionBSubtitle: 'Would require a vehicle'),
  SimpleModel('Pets', false,
      subtitle: 'How is your pet going to handled?',
      optionA: 'Pet Cleaning',
      optionAPrice: 200,
      optionASubtitle: 'Cleaning of your pet',
      optionB: 'Pet Walking',
      optionBPrice: 100,
      optionBSubtitle: 'Walking your pet around your area'),
  SimpleModel('Pickup and Delivery', false,
      subtitle: 'What kind of pickup is being done?',
      optionA: 'Light Pickup',
      optionAPrice: 250,
      optionASubtitle: 'Would not require a vehicle',
      optionB: 'Heavy Pickup',
      optionBPrice: 500,
      optionBSubtitle: 'Would require a vehicle'),
];

List<SimpleModel> selected = <SimpleModel>[]..length = 1;

class SimpleModel {
  @required
  String title;
  @required
  bool isChecked;
  String subtitle;
  String optionA;
  String optionASubtitle;
  String optionB;
  String optionBSubtitle;
  int selectedRadio;
  int optionAPrice;
  int optionBPrice;
  bool option;
  SimpleModel(this.title, this.isChecked,
      {this.optionA,
      this.selectedRadio,
      this.optionASubtitle,
      this.subtitle,
      this.optionB,
      this.optionBSubtitle,
      this.optionAPrice,
      this.optionBPrice,
      this.option});
}
