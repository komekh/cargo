import '../application/language_bloc/language_bloc.dart';
import 'di.dart';

void registerLanguageFeature() {
  // Product BLoC and Use Cases
  sl.registerFactory(() => LanguageBloc());
}
