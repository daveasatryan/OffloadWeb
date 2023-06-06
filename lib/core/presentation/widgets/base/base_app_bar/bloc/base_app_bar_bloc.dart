import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/usecases/auth/logout_usecase.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/bloc/base_app_bar_event.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/bloc/base_app_bar_state.dart';

@injectable
class BaseAppBarBloc extends Bloc<BaseAppBarEvent, BaseAppBarState> {
  BaseAppBarBloc(this._logoutUsecase) : super(const BaseAppBarState.initial()) {
    on<Logout>((event, emit) async {
      (await _logoutUsecase()).whenOrNull(
        success: (data) {
          emit(const BaseAppBarState.logout());
        },
        error: (msg, errorCode) => emit(
          BaseAppBarState.error(msg: msg, errorCode: errorCode),
        ),
      );
    });
  }
  final LogoutUsecase _logoutUsecase;
}
