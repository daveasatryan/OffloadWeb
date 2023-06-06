import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CustomDropDown<T> extends BaseStatelessWidget {
  final List<DropdownMenuItem<T>> items;

  final Function(T? value) onChanged;
  final DateTime? value;
  final bool enabled;
  final Color borderColor;
  final Color dropdownBorderColor;
  final List<Widget>? selectedItemBuilder;
  TextStyle? style;
  Color? color;
  double borderRadius;
  double borderWidth;
  bool? showErrorIcon;
  bool showDropDownIcon;
  EdgeInsetsGeometry? innerPadding;
  CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItemBuilder,
    this.value,
    this.color,
    this.style,
    this.innerPadding,
    this.borderWidth = 1,
    this.showErrorIcon,
    this.showDropDownIcon = true,
    this.borderRadius = 5,
    this.enabled = true,
    this.borderColor = const Color(0xFF323C48),
    this.dropdownBorderColor = const Color(0xFF323C48),
  });
  void fullText(option) {}

  @override
  Widget baseBuild(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : .5,
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: innerPadding ??
                EdgeInsets.symmetric(
                  vertical: 0.sp,
                ),
            child: DropdownButtonFormField2<T>(
              style: style,
              buttonStyleData: ButtonStyleData(
                overlayColor: MaterialStateProperty.resolveWith((states) => colors.transparent),
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                    width: borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 5,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.blackOpacityColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.blackOpacityColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 9,
                ),
                selectedMenuItemBuilder: (context, child) {
                  return Container(
                    color: colors.yellowColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 9),
                      child: Text(
                          DateUtilities.printMinutesName(
                            value ?? DateTime.now(),
                          ),
                          style: style),
                    ),
                  );
                },
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: colors.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
                ),
                offset: const Offset(0, -20),
                width: 90,
                maxHeight: 300,
                elevation: 0,
              ),
              value: items.firstWhereOrNull((element) => element.value == value) != null
                  ? value as T
                  : null,
              items: items,
              iconStyleData: const IconStyleData(icon: SizedBox(), iconSize: 0),
              isExpanded: true,
              onChanged: onChanged,
              selectedItemBuilder: selectedItemBuilder?.let((self) => (context) => self),
            ),
          ),
        ),
      ),
    );
  }
}
