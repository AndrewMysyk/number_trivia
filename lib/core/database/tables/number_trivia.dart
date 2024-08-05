// 📦 Package imports:
import 'package:drift/drift.dart';

class NumberTriviaTable extends Table {
  @override
  Set<Column> get primaryKey => {number};

  IntColumn get number => integer()();
  TextColumn get description => text()();
}
