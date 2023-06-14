import 'dart:convert';

import 'package:at_client/at_client.dart';
import 'package:at_fhir/at_fhir.dart';

Future<SuccessOrError> atNotify(
    Map<String, dynamic> json, String atSign) async {
  try {
    final notified = await AtClientManager.getInstance()
        .atClient
        .notificationService
        .notify(NotificationParams.forText(
          jsonEncode(json),
          atSign,
          shouldEncrypt: true,
        ));
    // TODO(Dokotela): what can a NotificationResult be?
    return SuccessOrError.successNotificationResult(notified);
  } catch (exception, stackTrace) {
    if (exception is AtException) {
      return SuccessOrError.atSign(exception, stackTrace);
    } else {
      return SuccessOrError.exception(exception, stackTrace);
    }
  }
}
