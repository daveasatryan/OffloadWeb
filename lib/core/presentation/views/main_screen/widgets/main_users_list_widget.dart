import 'package:flutter/material.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/main_screen_user_item.dart';

class MainUsersListlWidget extends StatelessWidget {
  const MainUsersListlWidget({super.key, required this.usersList});
  final List<UserModel>? usersList;
  @override
  Widget build(BuildContext context) {
    return usersList != null
        ? ListView.builder(
            itemCount: usersList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MainScreenUserItem(
                  user: usersList?[index],
                ),
              );
            },
          )
        : const Center(
          //todo
            child: Text('List is empty'),
          );
  }
}
