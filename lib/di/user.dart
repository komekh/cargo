// Feature: User

import '../application/user_bloc/user_bloc.dart';
import '../data/data.dart';
import '../domain/domain.dart';
import 'di.dart';

void registerUserFeature() {
  // User BLoC and Use Cases
  sl.registerFactory(() => UserBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteUserUsecase(sl()));

  // User Repository and Data Sources
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );
}
