// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ConnectivityInjectableModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
