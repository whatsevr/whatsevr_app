import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/api/external/models/similar_place_by_query.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';

class PlaceSearchByNamePage extends StatefulWidget {
  final bool scaffoldView;
  final Function(String placeName, double? latitude, double? longitude)
      onPlaceSelected;
  const PlaceSearchByNamePage({
    super.key,
    this.scaffoldView = false,
    required this.onPlaceSelected,
  });

  @override
  State<PlaceSearchByNamePage> createState() => _PlaceSearchByNamePageState();
}

class _PlaceSearchByNamePageState extends State<PlaceSearchByNamePage> {
  List<Suggestion> searchedItems = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Widget child = Column(
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
        const Gap(8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchedItems.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(4);
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              onTap: () async {
                double? latitude;
                double? longitude;
                final String? placeName = searchedItems[index]
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
                      latitude = lat;
                      longitude = long;
                    },
                  );
                  if (latitude == null || longitude == null) {
                    SmartDialog.dismiss();
                    return;
                  }
                  SmartDialog.dismiss();
                  widget.onPlaceSelected(
                    searchedItems[index]
                        .placePrediction!
                        .structuredFormat!
                        .mainText!
                        .text!,
                    latitude,
                    longitude,
                  );
                  Navigator.of(context).pop();
                }
              },
              leading: const Icon(Icons.location_on),
              title: Text(
                '${searchedItems[index].placePrediction?.structuredFormat?.mainText?.text}',
              ),
              subtitle: Text(
                '${searchedItems[index].placePrediction?.structuredFormat?.secondaryText?.text}',
              ),
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
