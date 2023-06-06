import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool isPasswordField;
  TextEditingController? controller;
  String? initialValue;
  String? errorText;
  String? obscuringCharacter;

  List<TextInputFormatter>? inputFormatters;
  bool hidePassword;
  bool? isValidSuffixIcon;
  int? maxLines;
  int? minLines;
  Color fillColor;
  Color? suffixIconColor;
  FocusNode? focusNode;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Color? textColor;
  Color? cursorColor;
  int? maxLength;
  bool showSuccessIcon;
  bool showErrorIcon;
  bool showBorders;
  bool enabled;
  bool? showContent;
  bool readOnly;
  double borderWidth = 1;
  double borderRadius;
  double? contentPaddingVertical;
  double? contentPaddingHorizontal;
  TextCapitalization? textCapitalization;
  TextInputType? keyboardType;
  TextStyle? hintStyle;
  TextStyle? style;
  Color? borderColor;
  Function()? togglePasswordVisibility;
  Function()? onTap;
  Function(String)? onSubmitted;
  ValueChanged<String>? onChanged;

  CustomTextField({
    super.key,
    required this.hint,
    this.isPasswordField = false,
    this.controller,
    this.isValidSuffixIcon,
    this.errorText,
    this.obscuringCharacter,
    required this.fillColor,
    this.suffixIconColor,
    this.initialValue,
    this.focusNode,
    this.maxLines = 1,
    this.minLines = 1,
    this.borderWidth = 1,
    this.hintStyle,
    this.style,
    this.textColor,
    this.maxLength,
    this.contentPaddingVertical,
    this.contentPaddingHorizontal,
    this.textCapitalization,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 5,
    this.keyboardType,
    this.showBorders = true,
    this.enabled = true,
    this.readOnly = false,
    this.hidePassword = false,
    this.showSuccessIcon = false,
    this.showErrorIcon = false,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.togglePasswordVisibility,
    this.borderColor,
    this.cursorColor,
    this.onSubmitted,
    this.showContent,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends BaseState<CustomTextField> {
  TextStyle? labelStyle;
  String length = '0';

  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {
        length = '${widget.controller?.text.length}';
      });
    });
    if (widget.controller?.text != widget.initialValue && widget.initialValue != null) {
      widget.controller?.text = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newStyle = widget.style;
    return Column(
      children: [
        TextFormField(
          style: newStyle ??
              fonts.poppinsRegular.copyWith(
                fontSize: 15,
              ),

          scrollPadding: EdgeInsets.only(bottom: 100.sp),
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          textInputAction: TextInputAction.done,
          enabled: widget.enabled,
          controller: widget.controller,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isPasswordField ? widget.hidePassword : false,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                fonts.poppinsRegular.copyWith(
                  fontSize: 15,
                  color: colors.blackOpacityColor.withOpacity(0.5),
                ),
            filled: true,
            fillColor: widget.fillColor,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.contentPaddingVertical ?? 15,
              horizontal: widget.contentPaddingHorizontal ?? 27,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPasswordField && widget.suffixIcon == null
                ? InkWell(
                    onTap: widget.togglePasswordVisibility,
                    child: widget.hidePassword
                        ? Icon(
                            Icons.visibility_off_outlined,
                            color: widget.suffixIconColor ?? colors.suffixsColor,
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color: widget.suffixIconColor ?? colors.suffixsColor,
                          ),
                  )
                : widget.suffixIcon,
            enabledBorder: widget.showBorders
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide(
                      width: widget.borderWidth,
                      color: widget.borderColor ?? colors.whisperBorderColor,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide.none),
            focusedErrorBorder: widget.showBorders
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide(
                      width: widget.borderWidth,
                      color: colors.whisperBorderColor,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide.none),
            focusedBorder: widget.showBorders
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide(
                      width: widget.borderWidth,
                      color: widget.borderColor ?? colors.whisperBorderColor,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    borderSide: BorderSide.none),
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          onTap: widget.onTap,
          // onSubmitted: onSubmitted,
        ),
        widget.showContent == true
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '$length/${widget.maxLength}',
                    style: fonts.poppinsRegular.copyWith(
                      fontSize: 11,
                      color: colors.blackOpacityColor.withOpacity(0.6),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.errorText != null
            ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      AppAssets.errorStateIcon,
                      width: 15,
                      height: 15,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          widget.errorText ?? '',
                          style: fonts.poppinsRegular.copyWith(
                            color: colors.errorTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            )
            : const SizedBox()
      ],
    );
  }
}
