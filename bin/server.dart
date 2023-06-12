import 'package:at_fhir/services/at_fhir_listen.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhirlite_central/src/src.dart';
import 'package:riverpod/riverpod.dart';

Future main() async {
  await onBoarding();

  final ProviderContainer container = ProviderContainer();

  container.listen(atListenProvider, (previous, next) {
    final atNotification = next.value;
    if (atNotification != null && atNotification.value != null) {
      try {
        final FhirRequest fhirRequest =
            FhirRequest.fromJsonString(atNotification.value!);
      } catch (e) {
        notifyMalformedRequest(atNotification.value!, atNotification.from);
      }
    }
  });
}
