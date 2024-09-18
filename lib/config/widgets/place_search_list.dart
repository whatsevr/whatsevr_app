import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/external/models/similar_place_by_query.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

import '../services/location.dart';

class PlaceSearchByNamePage extends StatefulWidget {
  final bool scaffoldView;
  const PlaceSearchByNamePage({super.key, this.scaffoldView = false});

  @override
  State<PlaceSearchByNamePage> createState() => _PlaceSearchByNamePageState();
}

class _PlaceSearchByNamePageState extends State<PlaceSearchByNamePage> {
  List<Suggestion> persistedSuggestions = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        WhatsevrFormField.textFieldWithClearIcon(
          controller: controller,
          hintText: 'Search for a place',
          onChanged: (String value) {
            LocationService.getSearchPredictedPlacesNames(
              searchQuery: value,
              onCompleted: (placesByQueryResponse) {
                setState(() {
                  persistedSuggestions =
                      placesByQueryResponse?.suggestions ?? [];
                  persistedSuggestions.toSet().toList();
                  persistedSuggestions.reversed.toList();
                });
              },
            );
          },
        ),
        Gap(8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: persistedSuggestions.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return Gap(4);
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              onTap: () {},
              leading: Icon(Icons.location_on),
              title: Text(
                  '${persistedSuggestions[index].placePrediction?.structuredFormat?.mainText?.text}'),
              subtitle: Text(
                  '${persistedSuggestions[index].placePrediction?.structuredFormat?.secondaryText?.text}'),
            );
          },
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
