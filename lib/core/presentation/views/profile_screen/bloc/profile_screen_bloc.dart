import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/usecases/content/get_therapists_item_usecase.dart';
import 'package:therapist_journey/core/data/usecases/user/get_user_initial_usecase.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/profile_screen_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/profile_screen_state.dart';

@injectable
class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ProfileScreenBloc(this._getUsersListItemUsecase, this.getUserInitialUsecase)
      : super(const ProfileScreenState.getUser(user: UserModel())) {
    on<GetUserInitial>(
      (event, emit) async {
        if (event.uuid == null) {
          (await getUserInitialUsecase()).when(
            success: (data) {
              emit(
                ProfileScreenState.getUser(
                  user: data?.result,
                ),
              );
            },
            error: (msg, errorCode) => emit(
              const ProfileScreenState.getUser(user: null),
            ),
            logout: (msg, errorCode) => emit(
              const ProfileScreenState.getUser(user: null),
            ),
          );
        } else {
          (await _getUsersListItemUsecase(event.uuid ?? '')).whenOrNull(
            success: (data) {
              emit(
                ProfileScreenState.getUser(
                  user: data?.result,
                ),
              );
            },
            error: (msg, errorCode) => emit(
              ProfileScreenState.error(msg: msg, errorCode: errorCode),
            ),
          );
        }
      },
    );
  }
  final GetTherapistItemUsecase _getUsersListItemUsecase;
  final GetUserInitialUsecase getUserInitialUsecase;
}
