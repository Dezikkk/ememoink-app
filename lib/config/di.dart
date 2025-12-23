import "package:ememoink/data/repositories/auth_repository.dart";
import "package:ememoink/data/repositories/calendar_repository.dart";
import "package:ememoink/data/repositories/tasks_repository.dart";
import "package:ememoink/data/services/auth_service.dart";
import "package:ememoink/data/services/onboarding_service.dart";
import "package:ememoink/ui/main/view_model/main_view_model.dart";
import "package:get_it/get_it.dart";
import "package:shared_preferences/shared_preferences.dart";

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Services
  getIt.registerLazySingleton<GoogleAuthService>(() => GoogleAuthService());

  getIt.registerLazySingleton<OnboardingService>(
    () => OnboardingService(getIt<SharedPreferences>()),
  );

  // Repos
  getIt.registerLazySingleton<GoogleAuthRepository>(
    () => GoogleAuthRepository(googleAuthService: getIt<GoogleAuthService>()),
  );

  getIt.registerLazySingleton<CalendarRepository>(
    () => CalendarRepository(authRepo: getIt<GoogleAuthRepository>()),
  );
  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepository(authRepo: getIt<GoogleAuthRepository>()),
  );

  // VievModels
    getIt.registerLazySingleton<MainViewModel>(
    () => MainViewModel(),
  );
}
