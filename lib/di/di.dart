import 'package:get_it/get_it.dart';

import 'common.dart';
import 'user.dart';

final sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // Register features
  registerUserFeature();
  // registerCategoryFeature();
  // registerProductFeature();
  // registerDeliveryInfoFeature();
  // registerCartFeature();
  // registerOrderFeature();

  // Register Cubits
  // registerCubits();

  // Register common dependencies
  registerCommonDependencies();
}
