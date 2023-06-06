import 'package:bloc/bloc.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/usecases/user/get_user_initial_usecase.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/views/splash/bloc/splash_event.dart';
import 'package:therapist_journey/core/presentation/views/splash/bloc/splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this.getUserInitialUsecase) : super(const SplashState.isLogin()) {
    on<GetUserData>(
      (event, emit) async {
        if (PreferencesManager.token.isNullOrEmpty()) {
          emit(
            const SplashState.isLogin(userModel: null),
          );
          return;
        }
        (await getUserInitialUsecase()).when(
          success: (data) {
            emit(
              SplashState.isLogin(
                userModel: data?.result,
              ),
            );
          },
          error: (msg, errorCode) => emit(
            const SplashState.isLogin(userModel: null),
          ),
          logout: (msg, errorCode) => emit(
            const SplashState.isLogin(userModel: null),
          ),
        );
      },
    );
  }
  GetUserInitialUsecase getUserInitialUsecase;
}
