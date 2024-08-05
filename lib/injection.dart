// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/database/app_database.dart';
import 'package:number_trivia/core/database/dao/number_trivia_dao.dart';
import 'package:number_trivia/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() async {
  getIt.allowReassignment = true;
  _configureAppDatabaseDependencies();
  getIt.registerLazySingleton(() => http.Client());
  return $initGetIt(getIt);
}

void _configureAppDatabaseDependencies() {
  final db = AppDatabase();
  getIt
    ..registerLazySingleton(() => db)
    ..registerLazySingleton<NumberTriviaDao>(() => db.numberTriviaDao);
}
