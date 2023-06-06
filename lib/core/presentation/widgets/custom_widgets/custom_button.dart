import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CustomButton extends BaseStatelessWidget {
  final Widget child;
  final bool isColorFilled;
  final Function() onTap;

  bool enabled;
  bool removeBorderColor;
  final double borderRadius;

  EdgeInsetsGeometry? padding;

  Color? color;
  Color? borderColor;

  CustomButton({
    super.key,
    required this.child,
    required this.isColorFilled,
    required this.onTap,
    this.color,
    this.padding,
    this.enabled = true,
    this.removeBorderColor = false,
    this.borderRadius = 5,
    this.borderColor,
  });

  @override
  Widget baseBuild(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: InkWell(
        splashFactory: null,
        onTap: enabled ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? (isColorFilled ? (colors.customButtonBorderColor) : colors.transparent),
            border: Border.all(
              color: removeBorderColor
                  ? Colors.transparent
                  : borderColor ?? colors.customButtonBorderColor,
            ),
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
