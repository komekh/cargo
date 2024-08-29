import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/usecases/usecases.dart';
import '../../domain/usecases/splash/splash_usecase.dart';

// Define the states
abstract class SplashState {}

class SplashInitial extends SplashState {}

class NavigateToSplash2 extends SplashState {}

class NavigateToRoot extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  final SplashUseCase _splashUseCase;

  SplashCubit(this._splashUseCase) : super(SplashInitial());

  Future<void> checkToken() async {
    // await Future.delayed(const Duration(seconds: 1)); // Simulating some loading time
    try {
      final result = await _splashUseCase(NoParams());
      result.fold((failure) => emit(NavigateToSplash2()), (result) {
        result ? emit(NavigateToRoot()) : emit(NavigateToSplash2());
      });
    } catch (e) {
      emit(NavigateToSplash2());
    }
  }
}
