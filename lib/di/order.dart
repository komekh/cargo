import 'package:cargo/application/application.dart';
import 'package:cargo/data/data.dart';
import 'package:cargo/domain/domain.dart';

import 'di.dart';

void registerOrderFeature() {
  // Order bloc and Use Cases
  sl.registerFactory(() => OrderBloc(sl()));
  sl.registerLazySingleton(() => GetOrderUseCase(sl()));

  // OrderDetails
  sl.registerFactory(() => OrderDetailBloc(sl()));
  sl.registerLazySingleton(() => GetRoutesUseCase(sl()));

  // Order Repository and Data Sources
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(client: sl()),
  );
}
