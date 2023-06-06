import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/presentation/views/splash_screen/bloc/splash_screen_event.dart';
import 'package:therapist_journey/core/presentation/views/splash_screen/bloc/splash_screen_state.dart';

@injectable
class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(const SplashScreenState.loading()) {
    on<GetUser>((event, emit) {
      // todo: get user and navigate to
    });
  }
}
