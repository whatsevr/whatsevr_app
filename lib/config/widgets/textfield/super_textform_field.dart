import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WhatsevrFormField extends StatefulWidget {
  final String? headingTitle;
  final TextEditingController? controller;

  final Function()? onTap;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  const WhatsevrFormField._internal({
    this.headingTitle,
    this.controller,
    this.onTap,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.labelText,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.readOnly = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.focusNode,
  });

  // General text input factory with maxLength support
  factory WhatsevrFormField.generalTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function()? onTap,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    int? maxLength,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      keyboardType: keyboardType,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      onTap: onTap,
      validator: validator,
      inputFormatters: <TextInputFormatter>[
        ...?inputFormatters,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      readOnly: readOnly,
      onChanged: onChanged,
      maxLength: maxLength,
    );
  }

  // Factory: Date Picker
  factory WhatsevrFormField.datePicker({
    required BuildContext context,
    String? headingTitle,
    Function(String)? onChanged,
    TextEditingController? controller,
    String? hintText,
    Function(DateTime)? onDateSelected,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      suffixIcon: const Icon(Icons.calendar_today),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && onDateSelected != null) {
          controller?.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          onDateSelected(pickedDate);
        }
      },
    );
  }

  // Factory: DateTime Picker
  factory WhatsevrFormField.dateTimePicker({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(String)? onChanged,
    Function(DateTime)? onDateTimeSelected,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      suffixIcon: const Icon(Icons.calendar_today),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            final DateTime dateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            controller?.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
            if (onDateTimeSelected != null) {
              onDateTimeSelected(dateTime);
            }
          }
        }
      },
    );
  }

  // Factory: Time Picker
  factory WhatsevrFormField.timePicker({
    required BuildContext context,
    String? headingTitle,
    Function(String)? onChanged,
    TextEditingController? controller,
    String? hintText,
    Function(TimeOfDay)? onTimeSelected,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      suffixIcon: const Icon(Icons.access_time),
      readOnly: true,
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null && onTimeSelected != null) {
          controller?.text = pickedTime.format(context);
          onTimeSelected(pickedTime);
        }
      },
    );
  }
  factory WhatsevrFormField.invokeCustomFunction({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    Function(String)? onChanged,
    Widget? suffixWidget, // List of icons or widgets to display
    bool readOnly = true,
    required Function() customFunction,
    int? maxLength,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: customFunction,
      maxLength: maxLength,
      suffixIcon: suffixWidget ?? const Icon(Icons.filter_list_rounded),
    );
  }

  // Factory: TextField with Clear Icon
  factory WhatsevrFormField.textFieldWithClearIcon({
    String? headingTitle,
    TextEditingController? controller,
    Function(String)? onChanged,
    String? hintText,
    String? labelText,
    Function()? onTap,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: ValueListenableBuilder(
        valueListenable: controller!,
        builder: (BuildContext context, TextEditingValue value, __) {
          return value.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear(); // Clears the text field
                  },
                  child: const Icon(Icons.clear),
                )
              : const SizedBox.shrink();
        },
      ),
      onTap: onTap,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Password input with visibility toggle and maxLength support
  factory WhatsevrFormField.secretTextField({
    String? headingTitle,
    TextEditingController? controller,
    Function(String)? onChanged,
    String? hintText,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return WhatsevrFormField._internal(
      obscureText: true,
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        ...?inputFormatters,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
    );
  }

  // Email input with maxLength support
  factory WhatsevrFormField.email({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(String)? onChanged,
    int? maxLength,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
    );
  }

  // Phone number input with maxLength support
  factory WhatsevrFormField.phoneTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(String)? onChanged,
    int? maxLength = 10,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      prefixIcon: const Icon(Icons.phone),
      maxLength: maxLength,
    );
  }

  // Multiline input with maxLength support
  factory WhatsevrFormField.multilineTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(String)? onChanged,
    int minLines = 3,
    int maxLines = 5,
    int? maxLength,
    Widget? prefixWidget,
    Widget? suffixWidget,
    FocusNode? focusNode,
  }) {
    return WhatsevrFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      minLines: minLines,
      maxLines: maxLines ?? minLines + 5,
      keyboardType: TextInputType.multiline,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
      prefixIcon: prefixWidget,
      suffixIcon: suffixWidget,
      focusNode: focusNode,
    );
  }

  @override
  _WhatsevrFormFieldState createState() => _WhatsevrFormFieldState();
}

class _WhatsevrFormFieldState extends State<WhatsevrFormField> {
  late ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Colors.grey.shade500;
    final EdgeInsets defaultContextPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 12.0,
    );
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: baseColor),
      borderRadius: BorderRadius.circular(10),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.headingTitle != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.headingTitle!,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ValueListenableBuilder<bool>(
          valueListenable: _obscureTextNotifier,
          builder: (BuildContext context, bool obscureText, _) {
            return TextFormField(
              controller: widget.controller,
              onTap: widget.readOnly == true ? widget.onTap : null,
              keyboardType: widget.keyboardType,
              obscureText: obscureText,
              inputFormatters: widget.inputFormatters,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              minLines: widget.minLines,
              maxLines: widget.maxLines ?? 1,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: defaultContextPadding,
                hintText: widget.hintText,
                alignLabelWithHint: true,
                hintStyle: TextStyle(
                  color: baseColor,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
                hintMaxLines: widget.minLines,
                suffixIconColor: baseColor,
                prefixIconColor: baseColor,
                suffixIcon: widget.obscureText
                    ? GestureDetector(
                        onTap: () {
                          _obscureTextNotifier.value =
                              !_obscureTextNotifier.value;
                        },
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      )
                    : widget.onTap != null
                        ? GestureDetector(
                            onTap: widget.onTap,
                            child: widget.suffixIcon,
                          )
                        : widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
              validator: widget.validator,
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }
}
