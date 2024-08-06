import 'package:cargo/data/data.dart';
import 'package:cargo/domain/domain.dart';

import '../application/splash_cubit/splash_cubit.dart';
import 'di.dart';

void registerSplashFeature() {
  // Splash cubit and Use Cases
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerLazySingleton(() => SplashUseCase(sl()));

  // Splash Repository and Data Sources
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      localDataSource: sl(),
    ),
  );
}
