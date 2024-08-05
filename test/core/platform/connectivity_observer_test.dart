// 📦 Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 🌎 Project imports:
import 'package:number_trivia/core/platform/connectivity_observer_impl.dart';
import 'connectivity_observer_test.mocks.dart';

@GenerateMocks([
  Connectivity,
])
void main() {
  late MockConnectivity mockConnectivity;
  late ConnectivityObserverImpl connectivityObserver;

  setUp(() {
    mockConnectivity = MockConnectivity();
    connectivityObserver = ConnectivityObserverImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity and return a true status',
        () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => [
          ConnectivityResult.mobile,
          ConnectivityResult.bluetooth,
        ],
      );
      final result = await connectivityObserver.isNetworkAvailable;
      verify(mockConnectivity.checkConnectivity());
      expect(result, true);
    });

    test('should forward the call to Connectivity and return a true status',
        () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      final result = await connectivityObserver.isNetworkAvailable;
      verify(mockConnectivity.checkConnectivity());
      expect(result, false);
    });
  });
}
