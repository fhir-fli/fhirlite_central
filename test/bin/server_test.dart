import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';
import 'package:at_client/at_client.dart';
import 'package:at_fhir/at_fhir.dart';

class MockStream<T> extends Mock implements Stream<T> {}

class MockAtNotification extends Mock implements AtNotification {}

class MockAtFhirNotification extends Mock implements AtFhirNotification {}

class MockAtFhirNotificationValue extends Mock
    implements AtFhirNotificationValue {}

class MockAtClientManager extends Mock implements AtClientManager {}

class MockAtClient extends Mock implements AtClient {}

class MockNotificationService extends Mock implements NotificationService {}

class MockRequest extends Mock implements Request {}

class MockPatient extends Mock implements Patient {}

void main() {
  group('listen', () {
    late StreamController<AtNotification> streamController;
    late Stream<AtNotification> stream;
    late MockAtClientManager mockAtClientManager;
    late MockAtClient mockAtClient;
    late MockNotificationService mockNotificationService;

    setUp(() {
      streamController = StreamController<AtNotification>();
      stream = streamController.stream;

      mockAtClientManager = MockAtClientManager();
      mockAtClient = MockAtClient();
      mockNotificationService = MockNotificationService();

      when(mockAtClientManager.atClient).thenReturn(mockAtClient);
      when(mockAtClient.notificationService)
          .thenReturn(mockNotificationService);
      when(mockNotificationService.subscribe(shouldDecrypt: true))
          .thenAnswer((_) => stream);

      AtNotification createMockAtNotification(
          String value, String from, String key) {
        final mockAtNotification = MockAtNotification();
        when(mockAtNotification.value).thenReturn(value);
        when(mockAtNotification.from).thenReturn(from);
        when(mockAtNotification.key).thenReturn(key);
        return mockAtNotification;
      }

      // Example test case
      test('should log notification and print Dstu2ResourceNotification',
          () async {
        final mockAtNotification =
            createMockAtNotification('value', 'from', '@81xerothermic:key');
        final mockAtFhirNotification = MockAtFhirNotification();
        final mockAtFhirNotificationValue = MockAtFhirNotificationValue();

        when(mockAtFhirNotification.fromJsonString(any))
            .thenReturn(mockAtFhirNotification);
        when(mockAtFhirNotification.toJson())
            .thenReturn('Dstu2ResourceNotification');
        when(mockAtFhirNotification.value)
            .thenReturn(mockAtFhirNotificationValue);

        await listen(stream);

        streamController.add(mockAtNotification);

        await Future.delayed(Duration(seconds: 1));

        verify(mockAtNotification.value);
        verify(mockAtNotification.from);
        verify(mockAtNotification.key);
        verify(mockAtFhirNotification.fromJsonString('key'));

        verifyInOrder([
          mockAtFhirNotification.toJson(),
          mockAtFhirNotification.toJson(),
          mockAtFhirNotificationValue.request()
        ]);

        verifyNoMoreInteractions(mockAtNotification);
        verifyNoMoreInteractions(mockAtFhirNotification);
        verifyNoMoreInteractions(mockAtFhirNotificationValue);
      });
    });

    tearDown(() {
      streamController.close();
    });
  });
}
