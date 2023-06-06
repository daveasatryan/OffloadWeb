import 'package:flutter/widgets.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  set user(UserModel? userModel) {
    _user = userModel;
    PreferencesManager.userData = _user;
    notifyListeners();
  }

  UserModel? get user {
    _user ??= PreferencesManager.user;
    return _user;
  }

  void clearUserData() {
    user = null;
    PreferencesManager.clearUserData();
  }
}
