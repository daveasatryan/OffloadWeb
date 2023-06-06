import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/styles/app_styles.dart';

/// [Widget] that used to show loading state through whole app
class AppLoadingWidget extends StatelessWidget {
  /// Default constructor. Able to pass [CircularProgressIndicator]
  /// color by key [color]
  const AppLoadingWidget({
    super.key,
    this.color,
  });

  /// Color of [CircularProgressIndicator]
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
            AppStyles.cornerRadius10,
          ),
        ),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      ),
    );
  }
}
