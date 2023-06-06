import 'package:flutter/widgets.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

/// Default proxy [Widget] that creates additional logic above [child]

class AppScaffold extends BaseStatelessWidget {
  /// Constructor to avoid public_member_api_docs insists.
  AppScaffold({
    super.key,
    required this.child,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  /// Required [child] that appears on a view
  final Widget child;

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  @override
  Widget baseBuild(BuildContext context) {
    return SafeArea(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: child,
      ),
    );
  }
}
