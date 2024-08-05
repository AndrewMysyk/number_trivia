// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/platform/connectivity_observer.dart';

@LazySingleton(as: ConnectivityObserver)
class ConnectivityObserverImpl implements ConnectivityObserver {
  ConnectivityObserverImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isNetworkAvailable {
    return _connectivity.checkConnectivity().then(
          (r) => !r.contains(ConnectivityResult.none),
        );
  }
}
