import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class SplashScreenPage extends BaseStatelessWidget {
  SplashScreenPage({super.key});

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      color: colors.black,
    );
  }
}
