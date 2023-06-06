import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/usecases/content/get_therapists_usecase.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/bloc/main_screen_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/bloc/main_screen_state.dart';

@injectable
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc(this._getUsersListUsecase) : super(const MainScreenState.loading()) {
    on<GetTherapist>(
      (event, emit) async {
        (await _getUsersListUsecase()).whenOrNull(
          success: (data) {
            emit(
              MainScreenState.getTherapist(
                usersList: data?.result,
              ),
            );
          },
          error: (msg, errorCode) => emit(
            MainScreenState.error(msg: msg, errorCode: errorCode),
          ),
        );
      },
    );
  }
  final GetTherapistsUsecase _getUsersListUsecase;
}