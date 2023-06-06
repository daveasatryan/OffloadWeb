import 'package:get_it/get_it.dart';

/// Factory provider that creates or gets
/// given Object type from service locator
class SlFactory {
  /// Constructor to avoid public_member_api_docs insists.
  SlFactory({
    required GetIt getIt,
  }) : _getIt = getIt;

  final GetIt _getIt;

  /// Returns given Object type from getIt
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) =>
      _getIt.get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );
}
