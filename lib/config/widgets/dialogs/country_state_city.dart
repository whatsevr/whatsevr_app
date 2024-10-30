import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';

class CountryStateCityPage extends StatefulWidget {
  final bool scaffoldView;
  final Function(String? countryName, String? stateName, String? cityName)
      onPlaceSelected;
  const CountryStateCityPage(
      {super.key, this.scaffoldView = false, required this.onPlaceSelected});

  @override
  State<CountryStateCityPage> createState() => _CountryStateCityPageState();
}

class _CountryStateCityPageState extends State<CountryStateCityPage> {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade200,
      ),
    );
    Widget child = Column(
      children: [
        CountryStateCityPicker(
          country: country,
          state: state,
          city: city,
          dialogColor: Colors.grey.shade200,
          textFieldDecoration: InputDecoration(
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            disabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        Gap(20),
        WhatsevrButton.filled(
          onPressed: () {
            widget.onPlaceSelected(
              country.text.isEmpty ? null : country.text,
              state.text.isEmpty ? null : state.text,
              city.text.isEmpty ? null : city.text,
            );
            Navigator.pop(context);
          },
          label: 'Done',
        ),
      ],
    );
    if (widget.scaffoldView) {
      return Scaffold(
        body: child,
      );
    }
    return child;
  }
}
