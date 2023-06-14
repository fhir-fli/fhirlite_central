import 'dart:developer';

import 'package:at_client/at_client.dart';
import 'package:at_fhir/at_fhir.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhirlite_central/src.dart';

Future main() async {
  await onBoarding();
  AtClientManager.getInstance()
      .atClient
      .notificationService
      .subscribe(shouldDecrypt: true)
      .listen((atNotification) async {
    if (atNotification.value != null) {
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
        final notifyResult =
            await atNotify(result.toJson(), atNotification.from);
      } catch (e) {
        notifyMalformedRequest(atNotification.value!, atNotification.from);
      }
    }
  });
}
