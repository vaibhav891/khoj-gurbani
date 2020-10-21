import 'package:get_it/get_it.dart';
import 'package:khojgurbani_music/services/loginAndRegistrationServices.dart';
import 'package:khojgurbani_music/services/services.dart';
import 'package:khojgurbani_music/services/downloadFiles.dart';

GetIt getIt = GetIt.instance;

void getServices() {
  getIt.registerLazySingleton(() => Services());
  getIt.registerLazySingleton(() => LoginAndRegistrationService());
  getIt.registerLazySingleton(() => Downloader());
}
