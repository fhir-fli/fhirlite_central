import 'package:at_fhir/services/notify.dart';
import 'package:riverpod/riverpod.dart';

void notify(Map<String, dynamic> notifyMap, String atSign) {
  final ProviderContainer container = ProviderContainer();
  container.read(atNotifyProvider(notifyMap, atSign)).when(
        data: (data) {
          //TODO(Dokotela): decide how to manage results
        },
        error: (e, s) {
          //TODO(Dokotela): decide how to manage results
        },
        loading: () {},
      );
}
