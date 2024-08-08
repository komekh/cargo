import 'package:get_it/get_it.dart';

import 'common.dart';
import 'cubits.dart';
import 'language.dart';
import 'order.dart';
import 'splash.dart';
import 'user.dart';

final sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // Register features

  registerUserFeature();
  registerLanguageFeature();
  registerSplashFeature();
  registerOrderFeature();
  // registerCategoryFeature();
  // registerProductFeature();
  // registerDeliveryInfoFeature();
  // registerCartFeature();
  // registerOrderFeature();

  // Register Cubits
  registerCubits();

  // Register common dependencies
  registerCommonDependencies();
}
