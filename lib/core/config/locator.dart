import 'package:get_it/get_it.dart';
import 'package:network/core/services/NavigationService.dart';
import 'package:network/core/viewmodels/discoverVM.dart';
import '../services/AuthService.dart';
import '../services/fireUserService.dart';

GetIt locator = GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FireUserService());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton(() => DiscoverVM());

}