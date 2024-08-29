import '../application/contact_cubit/contact_cubit.dart';
import '../data/data.dart';
import '../domain/domain.dart';
import 'di.dart';

void registerContactFeature() {
  // Contact cubit and Use Cases
  sl.registerFactory(() => ContactCubit(sl()));
  sl.registerLazySingleton(() => GetContactsUseCase(sl()));

  // Contact Repository and Data Sources
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ContactRemoteDataSource>(
    () => ContactRemoteDataSourceImpl(client: sl()),
  );
}
