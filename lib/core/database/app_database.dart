// 📦 Package imports:
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/database/dao/number_trivia_dao.dart';
import 'package:number_trivia/core/database/tables/number_trivia.dart';

part 'app_database.g.dart';

@DriftDatabase(
  daos: [
    NumberTriviaDao,
  ],
  tables: [
    NumberTriviaTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}
