// 📦 Package imports:
import 'package:drift/drift.dart';

class NumberTriviaTable extends Table {
  @override
  Set<Column> get primaryKey => {number, description};

  IntColumn get number => integer()();
  TextColumn get description => text()();
}
