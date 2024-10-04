import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:whatsevr_app/config/api/methods/common_data.dart';
import 'package:whatsevr_app/config/api/response_model/common_data.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

class CommonDataSearchSelectPage extends StatefulWidget {
  final bool scaffoldView;
  final bool showEducationDegrees;
  final Function(EducationDegree)? onEducationDegreeSelected;
  final bool showGenders;
  final Function(Gender)? onGenderSelected;
  final bool showWorkingModes;
  final Function(WorkingMode)? onWorkingModeSelected;
  final bool showCtaActions;
  final Function(CtaAction)? onCtaActionSelected;

  // Multi-select items for Interests
  final bool showInterests;
  final Function(List<Interest>)? onPersonalInterestsSelected;

  final bool showSearchBar;

  const CommonDataSearchSelectPage({
    super.key,
    this.scaffoldView = false,
    this.showEducationDegrees = false,
    this.showGenders = false,
    this.showWorkingModes = false,
    this.showInterests = false,
    this.showSearchBar = true,
    this.onEducationDegreeSelected,
    this.onGenderSelected,
    this.onWorkingModeSelected,
    this.onPersonalInterestsSelected,
    this.showCtaActions = false,
    this.onCtaActionSelected,
  });

  @override
  _CommonDataSearchSelectPageState createState() =>
      _CommonDataSearchSelectPageState();
}

class _CommonDataSearchSelectPageState
    extends State<CommonDataSearchSelectPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  CommonDataResponse? _commonData;
  List<dynamic> _filteredItems = <dynamic>[];
  final List<Interest> _selectedInterests = <Interest>[];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCommonData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Fetch data using CommonDataApi with error handling and loading state
  Future<void> _fetchCommonData() async {
    try {
      CommonDataResponse? response = await CommonDataApi.getAllCommonData();

      if (response != null) {
        setState(() {
          _commonData = response;
          _initializeFilteredList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load data.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching common data: $e';
        _isLoading = false;
      });
    }
  }

  // Initialize filtered list based on the flags passed
  void _initializeFilteredList() {
    if (widget.showEducationDegrees && _commonData?.educationDegrees != null) {
      _filteredItems = _commonData!.educationDegrees!;
    } else if (widget.showGenders && _commonData?.genders != null) {
      _filteredItems = _commonData!.genders!;
    } else if (widget.showWorkingModes && _commonData?.workingModes != null) {
      _filteredItems = _commonData!.workingModes!;
    } else if (widget.showInterests && _commonData?.interests != null) {
      _filteredItems = _commonData!.interests!;
    } else if (widget.showCtaActions && _commonData?.ctaActions != null) {
      _filteredItems = _commonData!.ctaActions!;
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _filterList);
  }

  void _filterList() {
    final String query = _searchController.text.toLowerCase();

    setState(() {
      if (_commonData != null) {
        if (widget.showEducationDegrees) {
          _filteredItems = _commonData!.educationDegrees!
              .where(
                (EducationDegree item) =>
                    item.title != null &&
                    item.title!.toLowerCase().contains(query),
              )
              .toList();
        } else if (widget.showGenders) {
          _filteredItems = _commonData!.genders!
              .where(
                (Gender item) =>
                    item.gender != null &&
                    item.gender!.toLowerCase().contains(query),
              )
              .toList();
        } else if (widget.showWorkingModes) {
          _filteredItems = _commonData!.workingModes!
              .where(
                (WorkingMode item) =>
                    item.mode != null &&
                    item.mode!.toLowerCase().contains(query),
              )
              .toList();
        } else if (widget.showInterests) {
          _filteredItems = _commonData!.interests!
              .where(
                (Interest item) =>
                    item.name != null &&
                    item.name!.toLowerCase().contains(query),
              )
              .toList();
        } else if (widget.showCtaActions) {
          _filteredItems = _commonData!.ctaActions!
              .where(
                (CtaAction item) =>
                    item.action != null &&
                    item.action!.toLowerCase().contains(query),
              )
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _isLoading
        ? const Center(child: CupertinoActivityIndicator())
        : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage)) // Show error message
            : _buildBody();
    if (widget.scaffoldView) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Search and Select'),
        ),
        body: child,
      );
    }
    return child;
  }

  // Build the body based on filtered items
  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.showSearchBar)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: WhatsevrFormField.textFieldWithClearIcon(
              controller: _searchController,
              hintText: 'Search...',
            ),
          ),
        _filteredItems.isNotEmpty
            ? _buildListView(_filteredItems)
            : const Center(
                child: Text(
                  'No items found',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ),
        if (widget.showInterests && _selectedInterests.isNotEmpty)
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              if (widget.onPersonalInterestsSelected != null) {
                widget.onPersonalInterestsSelected!(_selectedInterests);
              }
              Navigator.pop(context);
            },
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }

  // ListView builder that handles different data types
  Widget _buildListView(List<dynamic> items) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, int index) {
        final item = items[index];

        // Single-select items
        if (item is EducationDegree) {
          return ListTile(
            title: Text(item.title!),
            onTap: () {
              if (widget.onEducationDegreeSelected != null) {
                widget.onEducationDegreeSelected!(item);
              }
              Navigator.pop(context);
            },
          );
        } else if (item is Gender) {
          return ListTile(
            title: Text(item.gender!),
            onTap: () {
              if (widget.onGenderSelected != null) {
                widget.onGenderSelected!(item);
              }
              Navigator.pop(context);
            },
          );
        } else if (item is WorkingMode) {
          return ListTile(
            title: Text(item.mode!),
            onTap: () {
              if (widget.onWorkingModeSelected != null) {
                widget.onWorkingModeSelected!(item);
              }
              Navigator.pop(context);
            },
          );
        }

        // Multi-select Interests
        else if (item is Interest) {
          return CheckboxListTile(
            title: Text(item.name!),
            value: _selectedInterests.contains(item),
            onChanged: (bool? isSelected) {
              setState(() {
                if (isSelected == true) {
                  _selectedInterests.add(item);
                } else {
                  _selectedInterests.remove(item);
                }
              });
            },
          );
        } else if (item is CtaAction) {
          return ListTile(
            title: Text(item.action!),
            onTap: () {
              if (widget.onCtaActionSelected != null) {
                widget.onCtaActionSelected!(item);
              }
              Navigator.pop(context);
            },
          );
        }

        return const SizedBox.shrink(); // For unexpected types
      },
    );
  }
}
