import 'package:get_it/get_it.dart';

import '../enviromnent_service/environment_service.dart';

final GetIt sl = GetIt.instance;

class DependencyInjectionService {
  Future<void> inject() async {
    _injectServices();
  }

  void _injectServices() {
    sl.registerLazySingleton<EnvironmentService>(
      () => EnvironmentService(),
    );
  }
}
