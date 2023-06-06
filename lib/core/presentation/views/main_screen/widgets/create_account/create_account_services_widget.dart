import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CreateAccountServicesWidget extends BaseStatelessWidget {
  CreateAccountServicesWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  String icon;
  String text;
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: colors.whisperColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    icon,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              TextSpan(
                text: text,
                style: fonts.poppinsMedium.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
