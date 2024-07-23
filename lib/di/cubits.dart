import '../application/application.dart';
import 'di.dart';

void registerCubits() {
  // Navigation
  sl.registerFactory(() => NavigationCubit());

  //Notiications
  // sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  // sl.registerFactory(() => NotificationsCubit(sl()));
}
