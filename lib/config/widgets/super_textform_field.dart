import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SuperTextFormField extends StatelessWidget {
  final String? headingTitle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onTap;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;

  final bool enabled;

  final String? Function(String?)? validator;
  final List<TextInputFormatter>?
      inputFormatters; // New input formatter parameter

  // Dropdown-specific
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? dropdownValue;
  final ValueChanged<String?>? onChanged;

  // Date and Time pickers
  final bool isDatePicker;
  final bool isTimePicker;
  final bool isDateTimePicker;

  // Custom Function
  final Function()? customFunction;
  final bool? readOnly;
  final int? minLines;

  const SuperTextFormField._internal({
    super.key,
    this.headingTitle,
    this.controller,
    this.focusNode,
    this.onTap,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.labelText,
    this.enabled = true,
    this.validator,
    this.inputFormatters, // Input formatters parameter added here
    this.dropdownItems,
    this.dropdownValue,
    this.onChanged,
    this.isDatePicker = false,
    this.isTimePicker = false,
    this.isDateTimePicker = false,
    this.customFunction,
    this.readOnly,
    this.minLines,
  });

  // Normal text input
  factory SuperTextFormField.normal({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function()? onTap,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? readOnly,
    int? minLines,
    int? maxLines,
    // Input formatter added to factory
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: keyboardType,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      minLines: minLines,

      // Pass input formatters to internal
    );
  }

  // Search text input
  factory SuperTextFormField.search({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText = 'Search',
    Function()? onTap,
    String? Function(String?)? validator,
    List<TextInputFormatter>?
        inputFormatters, // Input formatter added to factory
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }

  // Dropdown input
  factory SuperTextFormField.dropdown({
    String? headingTitle,
    String? value,
    List<DropdownMenuItem<String>>? dropdownItems,
    String? labelText,
    ValueChanged<String?>? onChanged,
    Function()? onTap,
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      dropdownItems: dropdownItems,
      dropdownValue: value,
      labelText: labelText,
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onChanged: onChanged,
      onTap: onTap,
      readOnly: true,
    );
  }

  // Date picker input
  factory SuperTextFormField.date({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(DateTime)? onDateSelected,
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.calendar_today),
      isDatePicker: true,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
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

  // Time picker input
  factory SuperTextFormField.time({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(TimeOfDay)? onTimeSelected,
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      readOnly: true,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.access_time),
      isTimePicker: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
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

  // DateTime picker input
  factory SuperTextFormField.dateTime({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(DateTime)? onDateTimeSelected,
  }) {
    return SuperTextFormField._internal(
      readOnly: true,
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.calendar_today),
      isDateTimePicker: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            DateTime dateTime = DateTime(
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
//Secret input
  factory SuperTextFormField.secretInput({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function()? onTap,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool? readOnly,
    int? minLines,
    int? maxLines,
    // Input formatter added to factory
  }) {
    return SuperTextFormField._internal(
      obscureText: true,
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      minLines: minLines,

      // Pass input formatters to internal
    );
  }
  // Invoke custom function input
  factory SuperTextFormField.invokeFunction({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function()? customFunction,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? labelText,
    Function()? onTap,
  }) {
    return SuperTextFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelText: labelText,
      customFunction: customFunction,
      onTap: onTap,
      readOnly: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var overallColor = Colors.grey.shade500;
    var border = OutlineInputBorder(
        borderSide: BorderSide(color: overallColor),
        borderRadius: BorderRadius.circular(10));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headingTitle != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              headingTitle!,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (dropdownItems != null)
          DropdownButtonFormField<String>(
            value: dropdownValue,
            items: dropdownItems,
            onChanged: enabled ? onChanged : null,
            decoration: InputDecoration(
              labelText: labelText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
            ),
          )
        else
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            onTap:
                isDatePicker || isTimePicker || isDateTimePicker ? onTap : null,
            keyboardType: keyboardType,
            obscureText: obscureText,
            enabled: enabled,

            inputFormatters: inputFormatters, // Set the input formatters here
            readOnly: readOnly ?? false,
            minLines: minLines,
            maxLines: minLines == null ? 1 : minLines! + 5,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: overallColor),
                      child: suffixIcon!)
                  : null,
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: overallColor),
                      child: prefixIcon!)
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
            ),
          ),
      ],
    );
  }
}
