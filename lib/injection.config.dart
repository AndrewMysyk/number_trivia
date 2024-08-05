// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import 'core/database/dao/number_trivia_dao.dart' as _i214;
import 'core/platform/connectivity_injectable_module.dart' as _i959;
import 'core/platform/connectivity_observer.dart' as _i1026;
import 'core/platform/connectivity_observer_impl.dart' as _i335;
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart'
    as _i850;
import 'features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart'
    as _i453;
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart'
    as _i798;
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart'
    as _i702;
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i36;
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i792;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final connectivityInjectableModule = _$ConnectivityInjectableModule();
  gh.lazySingleton<_i895.Connectivity>(
      () => connectivityInjectableModule.connectivity);
  gh.lazySingleton<_i798.NumberTriviaRemoteDataSource>(
      () => _i702.NumberTriviaRemoteDataSourceImpl(gh<_i519.Client>()));
  gh.lazySingleton<_i1026.ConnectivityObserver>(
      () => _i335.ConnectivityObserverImpl(gh<_i895.Connectivity>()));
  gh.lazySingleton<_i850.NumberTriviaLocalDataSource>(
      () => _i453.NumberTriviaLocalDataSourceImpl(gh<_i214.NumberTriviaDao>()));
  gh.lazySingleton<_i792.NumberTriviaRepository>(() =>
      _i36.NumberTriviaRepositoryImpl(
        numberTriviaRemoteDataSource: gh<_i798.NumberTriviaRemoteDataSource>(),
        numberTriviaLocalDataSource: gh<_i850.NumberTriviaLocalDataSource>(),
        connectivityObserver: gh<_i1026.ConnectivityObserver>(),
      ));
  return getIt;
}

class _$ConnectivityInjectableModule
    extends _i959.ConnectivityInjectableModule {}
