import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/external/models/place_by_query.dart';

import '../services/location.dart';

class PlaceSearchPage extends StatefulWidget {
  final bool scaffoldView;
  const PlaceSearchPage({super.key, this.scaffoldView = false});

  @override
  State<PlaceSearchPage> createState() => _PlaceSearchPageState();
}

class _PlaceSearchPageState extends State<PlaceSearchPage> {
  List<Suggestion> persistedSuggestions = [];

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        TextField(
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
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: persistedSuggestions?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return Gap(8);
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                  '${persistedSuggestions[index].placePrediction?.text?.text}'),
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
