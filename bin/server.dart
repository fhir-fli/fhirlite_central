import 'dart:developer';

import 'package:at_fhir/at_fhir.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhirlite_central/src/src.dart';
import 'package:riverpod/riverpod.dart';

Future main() async {
  await onBoarding();

  ProviderContainer().listen(atListenProvider, (previous, next) async {
    final atNotification = next.value;
    if (atNotification != null && atNotification.value != null) {
      try {
        /// Try to reform request
        final FhirRequest fhirRequest =
            FhirRequest.fromJsonString(atNotification.value!);

        /// Log the request
        final logged = await logRequest(fhirRequest, atNotification.from);

        /// Log the log (how meta!) if it fails
        if (logged is! SuccessNotError) {
          log(logged.toString());
        }
        final Resource result =
            await makeRequest(fhirRequest, atNotification.from);
      } catch (e) {
        notifyMalformedRequest(atNotification.value!, atNotification.from);
      }
    }
  });
}
