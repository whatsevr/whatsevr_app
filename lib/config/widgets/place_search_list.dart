import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/external/models/similar_place_by_query.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

import '../services/location.dart';

class PlaceSearchByNamePage extends StatefulWidget {
  final bool scaffoldView;
  final Function(String placeName, double? lat, double? long) onPlaceSelected;
  const PlaceSearchByNamePage(
      {super.key, this.scaffoldView = false, required this.onPlaceSelected});

  @override
  State<PlaceSearchByNamePage> createState() => _PlaceSearchByNamePageState();
}

class _PlaceSearchByNamePageState extends State<PlaceSearchByNamePage> {
  List<Suggestion> searchedItems = [];
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
                  searchedItems = placesByQueryResponse?.suggestions ?? [];
                  searchedItems.toSet().toList();
                  searchedItems.reversed.toList();
                });
              },
            );
          },
        ),
        Gap(8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: searchedItems.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return Gap(4);
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              onTap: () async {
                double? lat;
                double? long;
                String? placeName = searchedItems[index]
                        .placePrediction
                        ?.structuredFormat
                        ?.secondaryText
                        ?.text ??
                    searchedItems[index]
                        .placePrediction
                        ?.structuredFormat
                        ?.mainText
                        ?.text;
                if (placeName?.isNotEmpty ?? false) {
                  SmartDialog.showLoading();
                  await LocationService.getLatLongFromGooglePlaceName(
                    placeName: placeName,
                    onCompleted: (lat, long) {
                      lat = lat;
                      long = long;
                    },
                  );
                  SmartDialog.dismiss();
                  widget.onPlaceSelected(
                      searchedItems[index]
                          .placePrediction!
                          .structuredFormat!
                          .mainText!
                          .text!,
                      lat,
                      long);
                  Navigator.of(context).pop();
                }
              },
              leading: Icon(Icons.location_on),
              title: Text(
                  '${searchedItems[index].placePrediction?.structuredFormat?.mainText?.text}'),
              subtitle: Text(
                  '${searchedItems[index].placePrediction?.structuredFormat?.secondaryText?.text}'),
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