// 📦 Package imports:
import 'package:drift/drift.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/database/app_database.dart';
import 'package:number_trivia/core/database/tables/number_trivia.dart';

part 'number_trivia_dao.g.dart';

@DriftAccessor(tables: [NumberTriviaTable])
class NumberTriviaDao extends DatabaseAccessor<AppDatabase>
    with _$NumberTriviaDaoMixin {
  NumberTriviaDao(super.attachedDatabase);

  /// Return a single concrete [NumberTriviaTableData] with a given number
  ///
  /// Will complete with [StateError] when there is no number trivia with a given number
  Future<NumberTriviaTableData> getConcreteNumberTrivia(int number) {
    final query = select(numberTriviaTable)
      ..where((t) => t.number.equals(number));
    return query.getSingle();
  }

  /// Return a random [NumberTriviaTableData]
  ///
  /// Will complete with [StateError] when there is no rows presented
  Future<NumberTriviaTableData> getRandomNumberTrivia() {
    final query = select(numberTriviaTable)
      ..orderBy([(t) => OrderingTerm.random()])
      ..limit(1);
    return query.getSingle();
  }

  /// Inserts [Insertable<NumberTriviaTableData>] to the numbe trivia table
  ///
  /// Mode: [InsertMode.insertOrReplace]
  Future<int> saveNumberTrivia(NumberTriviaTableData numberTrivia) {
    return into(numberTriviaTable).insert(
      numberTrivia,
      mode: InsertMode.insertOrReplace,
    );
  }
}
