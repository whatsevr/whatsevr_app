import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

class SuperFormField extends StatefulWidget {
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
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  // Dropdown specific
  final String? dropdownValue;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final ValueChanged<String?>? onChanged;

  const SuperFormField._internal({
    Key? key,
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
    this.inputFormatters,
    this.readOnly = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.dropdownValue,
    this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  // General text input factory with maxLength support
  factory SuperFormField.generalTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function()? onTap,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    int? minLines,
    int? maxLines,
    int? maxLength,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      keyboardType: keyboardType,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      onTap: onTap,
      validator: validator,
      inputFormatters: [
        ...?inputFormatters,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      readOnly: readOnly,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }

  // Factory: Date Picker
  factory SuperFormField.datePicker({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(DateTime)? onDateSelected,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.calendar_today),
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

  // Factory: DateTime Picker
  factory SuperFormField.dateTimePicker({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(DateTime)? onDateTimeSelected,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.calendar_today),
      readOnly: true,
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

  // Factory: Time Picker
  factory SuperFormField.timePicker({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    Function(TimeOfDay)? onTimeSelected,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      suffixIcon: const Icon(Icons.access_time),
      readOnly: true,
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
  factory SuperFormField.invokeCustomFunction({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    Widget? suffixWidget, // List of icons or widgets to display
    bool readOnly = true,
    required Function() customFunction,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      readOnly: readOnly,
      onTap: customFunction,
      suffixIcon: suffixWidget ?? const Icon(Icons.filter_list_rounded),
    );
  }
  // Factory: Dropdown with Arrow Down
  factory SuperFormField.showModalSheetOnTap({
    required BuildContext context,
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    Widget? suffixWidget, // List of icons or widgets to display
    bool readOnly = true, // TextField is read-only by default
    Widget? modalSheetUi, // Function to be invoked on tap
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      readOnly: readOnly,
      onTap: () {
        showAppModalSheet(
          context: context,
          child: modalSheetUi,
        );
      },
      suffixIcon: suffixWidget ?? const Icon(Icons.filter_list_rounded),
    );
  }

  // Factory: TextField with Clear Icon
  factory SuperFormField.textFieldWithClearIcon({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    Function()? onTap,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      suffixIcon: ValueListenableBuilder(
        valueListenable: controller!,
        builder: (context, TextEditingValue value, __) {
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
  factory SuperFormField.secretTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return SuperFormField._internal(
      obscureText: true,
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      validator: validator,
      inputFormatters: [
        ...?inputFormatters,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
    );
  }

  // Email input with maxLength support
  factory SuperFormField.email({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    int? maxLength,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
    );
  }

  // Phone number input with maxLength support
  factory SuperFormField.phoneTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    int? maxLength = 10,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      prefixIcon: const Icon(Icons.phone),
      maxLength: maxLength,
    );
  }

  // Multiline input with maxLength support
  factory SuperFormField.multilineTextField({
    String? headingTitle,
    TextEditingController? controller,
    String? hintText,
    int minLines = 3,
    int? maxLines,
    int? maxLength,
  }) {
    return SuperFormField._internal(
      headingTitle: headingTitle,
      controller: controller,
      hintText: hintText,
      minLines: minLines,
      maxLines: maxLines ?? minLines + 5,
      keyboardType: TextInputType.multiline,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
    );
  }

  @override
  _SuperFormFieldState createState() => _SuperFormFieldState();
}

class _SuperFormFieldState extends State<SuperFormField> {
  late ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  Widget build(BuildContext context) {
    var defaultContextPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 12.0,
    );
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(10),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          builder: (context, obscureText, _) {
            return TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              obscureText: obscureText,
              enabled: widget.enabled,
              inputFormatters: widget.inputFormatters,
              readOnly: widget.readOnly,
              minLines: widget.minLines,
              maxLines: widget.maxLines ?? 1,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: defaultContextPadding,
                hintText: widget.hintText,
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
